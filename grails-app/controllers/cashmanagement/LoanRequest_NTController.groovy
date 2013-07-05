package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.commons.ApplicationHolder
import grails.converters.JSON
import fi.joensuu.joyds1.calendar.JalaliCalendar

class LoanRequest_NTController {
    def principalService
    def loanService

    static allowedMethods = [update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def report() {
        def columns = [
                [label: message(code: 'loanRequest_NT.loanNo'), name: "loanNo"],
                [label: message(code: 'loanRequest_NT.loanIDCode'), name: 'loanIDCode', expression: 'obj.loanRequestStatus==\\\'Confirm\\\'?obj.loanIDCode:\\\'\\\''],
                [label: message(code: 'loanRequest_NT.loanType'), name: 'loanType'],
                [label: message(code: 'loanRequest_NT.name'), name: 'name'],
                [label: message(code: 'loanRequest_NT.family'), name: 'family'],
                [label: message(code: 'loanRequest_NT.melliCode'), name: 'melliCode'],
                [label: message(code: 'loanRequest_NT.loanAmount'), name: 'loanAmount'],
                [label: message(code: 'loanRequest_NT.loanRequestStatus'), name: 'loanRequestStatus'],
                [label: message(code: 'loanRequest_NT.branch'), name: 'branch'],
                [label: message(code: 'loanRequest_NT.rejectReason'), name: 'rejectReason'],
                [label: message(code: 'loanRequest_NT.user'), name: 'user'],
                [label: message(code: 'loanRequest_NT.sendUser'), name: 'sendUser'],
                [label: message(code: 'loanRequest_NT.sendUserBranchHead'), name: 'sendUserBranchHead'],
                [label: message(code: 'loanRequest_NT.rejectUser'), name: 'rejectUser'],
                [label: message(code: 'loanRequest_NT.confirmUser'), name: 'confirmUser'],
                [label: message(code: 'loanRequest_NT.requestDate'), name: 'requestDate']]
        def selColumns = params.columns ? columns.findAll {params.columns.contains(it.name)} : columns.subList(0, 7);
        [branch: principalService.branch,
                branchHead: principalService.branchHead,
                bankRegion: principalService.bankRegion,
                columns: columns,
                selColumns: selColumns,
                selColumnsNames: selColumns.collect {it.name}]
    }

    def list() {
        def branch = principalService.branch
        def manabe = Math.max(loanService.getManabeGT(branch) as Long, 0)
        def masaref = loanService.getMasarefGT(branch)
        def mojavezSadere = loanService.getMojavezSadereGT(branch)
        def sumDebit = loanService.getEtebarDaryaftiGT(branch)
        def sumCredit = loanService.getEtebarEtayeeGT(branch)
        def permitToward = loanService.getPermitTowardGT(branch)
        def sysParam = SystemParameters.findAll().first()
        def manabeDays = sysParam.numofDays
        def cal = loanService.getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        def pmjcalt = new JalaliCalendar(cal)
        def today = "${pmjcalt.year}/${pmjcalt.month}/${pmjcalt.day}"
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = "${pmjcal.year}/${pmjcal.month}/${pmjcal.day}"
        def loanRequest
        if (params.id) {
            def l = LoanRequest_NT.get(params.id)
            if (l.loanRequestStatus == LoanRequest_NT.Pending)
                loanRequest = l
        }
        [branch: branch,
                permitAmount: loanService.getAvailable(branch),
                usedPercent: loanService.checkAvailable_numofdays_curMonth(branch, 0) * 100,
                usedPercentPrevMonth: loanService.checkAvailable_numofdays_oldMonth(branch) * 100,
                manabe: manabe,
                masaref: masaref,
                tashilatEtayee: mojavezSadere,
                sumCredit: sumCredit,
                sumDebit: sumDebit,
                permitToward: permitToward,
                manabeDays: manabeDays,
                today: today,
                tendaysago: tendaysagno,
                loanRequest_nt: loanRequest
        ]
    }

    def create() {
        [loanRequest_NTInstance: new LoanRequest_NT(params)]
    }

    def preAccept() {
        def req = LoanRequest_NT.get(params.id)
        if (loanService.checkResourceAvailability(req.branch, req.loanAmount)) {
            render([result: "OK", message: message(code: "branch-ok", args: [req.loanAmount])] as JSON)
        }
        else
            render([result: "CANCEL", message: message(code: "branch-cancel")] as JSON)
    }

    def acceptSend() {
        def req = LoanRequest_NT.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_NT.Pending) {
            def loanReqBranch = new LoanRequestNT_BranchHead(loanReqStatus: LoanRequest_NT.Pending, loanRequest_nt: req)
            loanReqBranch.save()
            req.loanRequestStatus = LoanRequest_NT.Sent
            req.sendUser = principalService.user
            req.merge()
        }
        render 0
    }

    def acceptConfirm() {
        def req = LoanRequest_NT.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_NT.Pending) {
            req.loanRequestStatus = LoanRequest_NT.Confirm
            req.loanIDCode = loanService.generateLoanId(req.branch, LoanType.get(req.loanType.id), new Date(), req.loanNo)
            req.confirmUser = principalService.user
            req.save()
        }
        render 0
    }

    def reject() {
        def req = LoanRequest_NT.get(params.id)
        if (req && (req.loanRequestStatus == LoanRequest_NT.Pending || req.loanRequestStatus == LoanRequest_NT.Confirm)) {
            req.loanRequestStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.rejectUser = principalService.user
            req.save()
        }
        render 0
    }

    def preAcceptBranchHead() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        if (loanService.checkResourceAvailability(req.branch, req.loanAmount)) {
            def mojoodi = []
            def sum = 0;
            def count = 0;
            LoanRequestNTBarrow.findAllByRequestAndBranch(req.loanRequest_nt, req.branch).eachWithIndex {barrow, index ->
                mojoodi << message(code: "link-amount-branch", args: [index + 1, barrow.debit, barrow.otherSide.branch])
                sum += barrow.debit
                count = index
            }
            if (req.loanAmount - sum > 0)
                mojoodi << message(code: "link-amount-branch", args: [count + 2, req.loanAmount - sum, req.branch])

            render([result: "OK", message: message(code: "branch-head-ok", args: [mojoodi.join("\n")])] as JSON)
        }
        else
            render([result: "CANCEL", message: message(code: "branchead-cancel")] as JSON)
    }

    def acceptConfirmBranchHead() {
        def req = LoanRequestNT_BranchHead.get(params.id)

        if (req && req.loanReqStatus == LoanRequest_NT.Pending && loanService.getAvailable(req.branch) >= req.loanAmount) {
            req.loanReqStatus = LoanRequest_NT.Confirm
            req.changeDate = new Date()
            req.user = principalService.user
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Confirm
            req.loanRequest_nt.loanIDCode = loanService.generateLoanId(req.branch, LoanType.get(req.loanType.id), new Date(), req.loanNo)
            req.loanRequest_nt.confirmUser = principalService.user
            req.loanRequest_nt.save()
        }
        render 0
    }

    def acceptSendBranchHead() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            def loanReqRegion = new LoanRequestNT_BankRegion(loanReqStatus: LoanRequest_NT.Pending, loanRequest_nt: req.loanRequest_nt)
            loanReqRegion.save(true)
            req.loanReqStatus = LoanRequest_NT.Sent
            req.user = principalService.user
            req.changeDate = new Date()
            req.loanRequest_nt.sendUserBranchHead = principalService.user
            req.save()
        }
        render 0
    }

    def rejectBranchHead() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            req.loanReqStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Cancel
            req.loanRequest_nt.rejectReason = RejectReason.get(params.rejectReasonId)
            req.loanRequest_nt.rejectUser = principalService.user
            req.save()
        }
        render 0
    }
    def rejectHeadOffice(){
        def req = LoanRequestNT_HeadOffice.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            req.loanReqStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Cancel
            req.loanRequest_nt.rejectReason = RejectReason.get(params.rejectReasonId)
            req.loanRequest_nt.rejectUser = principalService.user
            req.save()
        }
        render 0
    }
    def preAcceptBankRegion() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        if (loanService.checkResourceAvailability(req.branch, req.loanAmount)) {
            def branchHeads = LoanRequestNTBarrow.findAllByRequest(req.loanRequest_nt).collect {it.branch.branchHead}.unique()
            if (branchHeads.size() > 1) {
                render([result: "CANCEL", message: message(code: "branch-head-ok-headOfficeReq")] as JSON)
            } else {
                def mojoodi = []
                def sum = 0;
                def count = 0;
                LoanRequestNTBarrow.findAllByRequestAndBranch(req.loanRequest_nt, req.branch).eachWithIndex {barrow, index ->
                    mojoodi << message(code: "link-amount-branch", args: [index + 1, barrow.debit, barrow.otherSide.branch])
                    sum += barrow.debit
                    count = index
                }

                if (req.loanAmount - sum > 0)
                    mojoodi << message(code: "link-amount-branch", args: [count + 2, req.loanAmount - sum, req.branch])

                render([result: "OK", message: message(code: "branch-head-ok", args: [mojoodi.join("\n")])] as JSON)
            }
        }
        else
            render([result: "CANCEL", message: message(code: "bankregion-cancel")] as JSON)
    }

    def acceptConfirmBankRegion() {
        def req = LoanRequestNT_BankRegion.get(params.id)

        if (req && req.loanReqStatus == LoanRequest_NT.Pending && loanService.getAvailable(req.branch) >= req.loanAmount) {
            req.loanReqStatus = LoanRequest_NT.Confirm
            req.changeDate = new Date()
            req.user = principalService.user
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Confirm
            req.loanRequest_nt.loanIDCode = loanService.generateLoanId(req.branch, LoanType.get(req.loanType.id), new Date(), req.loanNo)
            req.loanRequest_nt.confirmUser = principalService.user
            req.loanRequest_nt.save()
        }
        render 0
    }
    def acceptHeadOffice() {
        def req = LoanRequestNT_HeadOffice.get(params.id)

        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            req.loanReqStatus = LoanRequest_NT.Confirm
            req.changeDate = new Date()
            req.user = principalService.user
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Confirm
            req.loanRequest_nt.loanIDCode = loanService.generateLoanId(req.branch, LoanType.get(req.loanType.id), new Date(), req.loanNo)
            req.loanRequest_nt.confirmUser = principalService.user
            req.loanRequest_nt.save()
        }
        render message(code: "request-assign-successfull")
    }

    def acceptSendBankRegion() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            def loanReqHead = new LoanRequestNT_HeadOffice(loanReqStatus: LoanRequest_NT.Pending, loanRequest_nt: req.loanRequest_nt)
            loanReqHead.save(true)
            req.loanReqStatus = LoanRequest_NT.Sent
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
        }
        render 0
    }

    def rejectBankRegion() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            req.loanReqStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Cancel
            req.loanRequest_nt.rejectReason = RejectReason.get(params.rejectReasonId)
            req.loanRequest_nt.rejectUser = principalService.user
            req.save()
        }
        render 0
    }

    def save() {
        def branch = principalService.getBranch()
        def loanRequest_NTInstance
        if (params.id) {
            loanRequest_NTInstance = LoanRequest_NT.get(params.id)
            if (loanRequest_NTInstance.loanRequestStatus == LoanRequest_NT.Pending)
                loanRequest_NTInstance.properties = params
            else {
                redirect(action: "list")
                return
            }
        }
        else
            loanRequest_NTInstance = new LoanRequest_NT(params)
        loanRequest_NTInstance.branch = branch
//        loanRequest_NTInstance.loanIDCode = loanService.generateLoanId(branch, LoanType.get(params.loanType.id), new Date(), params.loanNo)
        loanRequest_NTInstance.requestDate = new Date()
        loanRequest_NTInstance.user = principalService.user
//        if (loanService.checkResourceAvailability(branch, loanRequest_NTInstance.loanAmount)) {
//            loanRequest_NTInstance.loanRequestStatus = LoanRequest_NT.Confirm
//        }
//        else {
        loanRequest_NTInstance.loanRequestStatus = LoanRequest_NT.Pending

//        }
        if (!loanRequest_NTInstance.id && LoanRequest_NT.countByLoanNo(loanRequest_NTInstance.loanNo) > 0) {
            flash.message = message(code: 'loan-no-not-unique')

        }
        else {
            if (loanRequest_NTInstance.save()) {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), loanRequest_NTInstance.id])
            }
        }
        redirect(action: "list")
    }

    def branchHead() {
        def branchHead = principalService.getBranchHead()
        def manabe = Math.max(loanService.getManabeGT(branchHead) as Long, 0)
        def masaref = loanService.getMasarefGT(branchHead)
        def mojavezSadere = loanService.getMojavezSadereGT(branchHead)
        def sumDebit = loanService.getEtebarDaryaftiGT(branchHead)
        def sumCredit = loanService.getEtebarEtayeeGT(branchHead)
        def permitToward = loanService.getPermitTowardGT(branchHead)
        def sysParam = SystemParameters.findAll().first()
        def manabeDays = sysParam.numofDays
        def cal = loanService.getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        def pmjcalt = new JalaliCalendar(cal)
        def today = "${pmjcalt.year}/${pmjcalt.month}/${pmjcalt.day}"
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = "${pmjcal.year}/${pmjcal.month}/${pmjcal.day}"

        [branchHead: branchHead,
                permitAmount: loanService.getAvailable(branchHead),
                usedPercent: loanService.checkAvailable_numofdays_curMonth(branchHead, 0) * 100,
                usedPercentPrevMonth: loanService.checkAvailable_numofdays_oldMonth(branchHead) * 100,
                manabe: manabe,
                masaref: masaref,
                tashilatEtayee: mojavezSadere,
                sumCredit: sumCredit,
                sumDebit: sumDebit,
                permitToward: permitToward,
                manabeDays: manabeDays,
                today: today,
                tendaysago: tendaysagno]
    }
    def headOffice() {

    }
    def bankRegionPercents() {
        def sysParam = SystemParameters.findAll().first()
        def branchHeads
        if (principalService.user?.isAdmin)
            branchHeads = BranchHead.findAll()
        else if (principalService.user?.bankRegion) {
            def bankRegion = principalService.getBankRegion()
            branchHeads = BranchHead.findAllByBankRegion(bankRegion)
        }
        else {
            render "Permission Denied"
            return
        }
        def branchHeadsParams = []
        branchHeads.each {
            def ntParam = BranchHeadNTParams.findByBranchHead(it) ?:
                new BranchHeadNTParams(branchHead: it, permitToward: sysParam.permitToward,
                        maxGrowth: sysParam.maxGrowth, minGrowth: sysParam.minGrowth).save()
            branchHeadsParams << [branchHead: it, ntParam: ntParam, manabe: loanService.getManabeGT(it) ?: 0]
        }
        def sumManabe = branchHeadsParams.sum {it.manabe ?: 0}
        branchHeadsParams.each {
            it.manabePercent = it.manabe / sumManabe
        }
        def curManabeBeMasaref = branchHeadsParams.sum {
            it.manabePercent * it.ntParam.permitToward
        }
        branchHeadsParams.each {
            it.maxPermitToward = it.manabePercent ? ((sysParam.permitToward - curManabeBeMasaref) / it.manabePercent + it.ntParam.permitToward) : it.ntParam.permitToward
        }
        [permitToward: sysParam.permitToward, sumManabe: sumManabe, curManabeBeMasaref: curManabeBeMasaref, branchHeadsParams: branchHeadsParams]
    }

    def savePermitPercents() {
        params.findAll {it.key.contains("_")}.groupBy {
            it.key.split("_")[1]
        }.each { key, val ->
            def param = BranchHeadNTParams.get(key as Long)
            param.permitToward = val["permitToward_${key}"] as Double
            param.maxGrowth = val["maxGrowth_${key}"] as Double
            param.minGrowth = val["minGrowth_${key}"] as Double
            param.save()
        }
        redirect(action: "bankRegionPercents")
    }

    def bankRegion() {
        def bankRegion = principalService.getBankRegion()
        [bankRegion: bankRegion]
    }

    def getRequestBranch() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        render req.branch as JSON
    }

    def getRequestBranchHead() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        render req.branch as JSON
    }

    def linkBranchRequest() {
        try {
            def destBranch = Branch.get(params.branchId)
            def req = LoanRequestNT_BranchHead.get(params.reqId)
            def amt = params.amt ?: "0"
            def amount = amt as Double
            def sumDebit = LoanRequestNTBarrow.findAllByRequestAndBranch(req.loanRequest_nt, req.branch).sum {it.debit} ?: 0
            if (amount <= 0) {
                render message(code: 'please-enter-amount')
            }
            else if (amount > destBranch.available) {
                render message(code: 'branch-available-is-less-than-request')
            }
            else if (amount > req.loanAmount - sumDebit) {
                render message(code: 'cannot-link-more-than-loanAmount')
            }
            else {
                def user = principalService.user
                def debitBarrow = new LoanRequestNTBarrow(branch: req.branch, date: new Date(), debit: amount, request: req.loanRequest_nt, user: user)
                def creditBarrow = new LoanRequestNTBarrow(branch: destBranch, date: new Date(), credit: amount, request: req.loanRequest_nt, user: user, otherSide: debitBarrow)
                debitBarrow.otherSide = creditBarrow
                debitBarrow.save()
                creditBarrow.save()

                render message(code: 'request-assign-successfull')
            }
        } catch (e) {
            render(message(code: 'error') + e.message)
        }
    }

    def rejectBarrow() {
        def barrw = LoanRequestNTBarrow.get(params.id)
        if ([LoanRequest_NT.Sent, LoanRequest_NT.Pending].contains(barrw.request.loanRequestStatus)) {
            barrw.otherSide.delete()
            barrw.delete()
        }
        render 0
    }

    def linkBranchRequestRegion() {
        try {
            def destBranch = Branch.get(params.branchId)
            def amt = params.amt ?: "0"
            def amount = amt as Double
            def req = LoanRequestNT_BankRegion.get(params.reqId)
            def sumDebit = LoanRequestNTBarrow.findAllByRequestAndBranch(req.loanRequest_nt, req.branch).sum {it.debit} ?: 0
            if (amount <= 0) {
                render message(code: 'please-enter-amount')
            }
            else if (amount > destBranch.available) {
                render message(code: 'branch-available-is-less-than-request')
            }
            else if (amount > req.loanAmount - sumDebit) {
                render message(code: 'cannot-link-more-than-loanAmount')
            }
            else {
                def user = principalService.user
                def debitBarrow = new LoanRequestNTBarrow(branch: req.branch, date: new Date(), debit: amount, request: req.loanRequest_nt, user: user)
                def creditBarrow = new LoanRequestNTBarrow(branch: destBranch, date: new Date(), credit: amount, request: req.loanRequest_nt, user: user, otherSide: debitBarrow)
                debitBarrow.otherSide = creditBarrow
                debitBarrow.save()
                creditBarrow.save()
//                if (loanService.getAvailable(req.branch) >= req.loanAmount) {
//                    req.loanReqStatus = LoanRequest_NT.Confirm
//                    req.changeDate = new Date()
//                    req.user = principalService.user
//                    req.save()
//                    req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Confirm
//                    req.loanRequest_nt.save()
//                }
                if (req.branch.branchHead != destBranch.branchHead)
                    render message(code: 'request-assign-successfull-branchHeadDiffers')
                else
                    render message(code: 'request-assign-successfull')
            }
        } catch (e) {
            render(message(code: 'error') + e.message)
        }
    }

    def showBranchDetails() {
        def branch = Branch.get(params.id)
        [branchInstance: branch]
    }

    def showRequestDetails() {
        def loanRequest
        if (params.bankRegion)
            loanRequest = LoanRequestNT_BankRegion.get(params.bankRegion).loanRequest_nt
        if (params.branchHead)
            loanRequest = LoanRequestNT_BranchHead.get(params.branchHead).loanRequest_nt
        if (params.headOffice)
            loanRequest = LoanRequestNT_HeadOffice.get(params.headOffice).loanRequest_nt
        if (params.id)
            loanRequest = LoanRequest_NT.get(params.id)
        def branchHead = LoanRequestNT_BranchHead.findByLoanRequest_nt(loanRequest)
        def bankRegion = LoanRequestNT_BankRegion.findByLoanRequest_nt(loanRequest)
        def hasBarrow = LoanRequestNTBarrow.countByRequest(loanRequest) > 0
        [loanRequest_NTInstance: loanRequest, requestBranchHead: branchHead, requestBankRegion: bankRegion, hasBarrow: hasBarrow]

    }

    def show() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_NTInstance: loanRequest_NTInstance]
    }

    def edit() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_NTInstance: loanRequest_NTInstance]
    }

    def update() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (loanRequest_NTInstance.version > version) {
                loanRequest_NTInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')] as Object[],
                        "Another user has updated this LoanRequest_NT while you were editing")
                render(view: "edit", model: [loanRequest_NTInstance: loanRequest_NTInstance])
                return
            }
        }

        loanRequest_NTInstance.properties = params

        if (!loanRequest_NTInstance.save(flush: true)) {
            render(view: "edit", model: [loanRequest_NTInstance: loanRequest_NTInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), loanRequest_NTInstance.id])
        redirect(action: "show", id: loanRequest_NTInstance.id)
    }

    def delete() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        try {
            loanRequest_NTInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
