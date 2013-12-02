package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import fi.joensuu.joyds1.calendar.JalaliCalendar

class LoanRequest_GHController {
    def principalService
    def loanService
    static allowedMethods = [update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def res = viewParams(params)
        res
    }

    def viewParams(params) {
        def branch = principalService.branch
//        def year = new JalaliCalendar().year
//        def startDate = new JalaliCalendar(year, 1, 1).toJavaUtilGregorianCalendar().getTime()
        def permitAmount = PermissionAmount_GH.findAllByBranch(branch, [max: 1, sort: "permissionDate", order: "desc"]).find() ?: new PermissionAmount_GH()
        def usedAmountBranch = cashmanagement.LoanRequest_GH.findAllByBranchAndRequestDateGreaterThanEqualsAndLoanRequestStatusInList(branch, permitAmount.permissionDate, [LoanRequest_GH.Confirm, LoanRequest_GH.Paid]).sum { it.loanAmount } ?: 0
        def paidAmount = cashmanagement.LoanRequest_GH.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_GH.Paid).sum { it.loanAmount } ?: 0
        def paidAmountPeriod = cashmanagement.LoanRequest_GH.findAllByBranchAndRequestDateGreaterThanEqualsAndLoanRequestStatus(branch, permitAmount.permissionDate, LoanRequest_GH.Paid).sum { it.loanAmount } ?: 0
        def loanRequest_gh = LoanRequest_GH.get(params.id)
        return [branch: branch, usedAmount: usedAmountBranch ?: 0,
                permitAmount: permitAmount?.permAmount ?: 0, loanRequest_gh: loanRequest_gh,
                paidLoanAmount: paidAmount ?: 0,
                paidLoanAmountThisPeriod: paidAmountPeriod ?: 0]
    }

    def create() {
        [loanRequest_GHInstance: new LoanRequest_GH(params)]
    }

    def reject() {
        def loanRequest = LoanRequest_GH.get(params.id)
        loanRequest.loanRequestStatus = LoanRequest_GH.Cancel
        loanRequest.rejectReason = RejectReason.get(params.rejectReasonId)
        loanRequest.rejectUser = principalService.user
        loanRequest.rejectDate = new Date()
        loanRequest.save(flush: true)
        render viewParams() as JSON
    }

    private def getPermitAmts() {
        def sysParam = SystemParameters.findAll().first()
        def year = new JalaliCalendar().getYear()
        def month = new JalaliCalendar().month
        def firstOfMonth = new JalaliCalendar(new JalaliCalendar().year, new JalaliCalendar().month, 1).toJavaUtilGregorianCalendar().time
        def usedAmount = LoanRequest_GH.findAllByBranchAndLoanRequestStatus(principalService.branch, LoanRequest_GH.Confirm).sum { it.loanAmount } ?: 0
        def usedAmountMonth = LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateGreaterThanEquals(principalService.branch, LoanRequest_GH.Confirm, firstOfMonth).sum { it.loanAmount } ?: 0
        def permitAmt = PermissionAmount_GH.findByBranchAndYear(principalService.branch, year)?.permAmount ?: 0

        def usedAmountPrevMonths = LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateLessThan(principalService.branch, LoanRequest_GH.Confirm, firstOfMonth).sum { it.loanAmount } ?: 0
        def permitAmountPrevMonths = permitAmt * (month - 1) * sysParam.ghMonthlyPercent - usedAmountPrevMonths
        def res = [usedAmount: usedAmount, remainAmount: permitAmt - usedAmount, permitAmount: permitAmt, permitAmountMonth: permitAmt * sysParam.ghMonthlyPercent,
                usedAmountMonth: usedAmountMonth, remainAmountMonth: permitAmt * sysParam.ghMonthlyPercent + permitAmountPrevMonths - usedAmountMonth,
                branch: principalService.branch, bankPercent: loanService.masarefBeManabeGharzolhasane(), permitAmountPrevMonths: permitAmountPrevMonths]
        return res
    }


    def loanNoCheck = [2, 3, 4, 5, 6, 7, 8, 9, 3, 4, 5, 6, 7]
    def loanNoBrCheck = [0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 7]

    private def checkLoanNo(String loanNo) {
        try {
            if (!loanNo || loanNo.length() != 15)
                return false
            def ch2 = 0
            loanNoCheck.eachWithIndex { int entry, int i ->
                ch2 += entry * (loanNo[i] as int)
            }
            if ((ch2 % 11) % 10 != (loanNo[14] as int))
                return false
            def ch1 = 0
            loanNoBrCheck.eachWithIndex { int entry, int i ->
                ch1 += entry * (loanNo[i] as int)
            }
            if ((ch1 % 11) % 10 != (loanNo[13] as int))
                return false

            return true
        } catch (e) {
            return false
        }

    }

    private def checkMelliCode(String melliCode) {
        try {
            if (!melliCode || melliCode.length() != 10)
                return false;
            def checkDigit = 0
            def orig = 0
            melliCode.eachWithIndex { String entry, int i ->
                if (i < 9)
                    checkDigit += (entry as int) * (10 - i)
                else
                    orig = entry as int
            }
            checkDigit = checkDigit % 11
            if (checkDigit < 2)
                return orig == checkDigit
            else
                return orig == (11 - checkDigit)
        } catch (x) {
            return false
        }
    }

    def save() {
        def prms = [:]

        def branch = principalService.getBranch()
        if (!checkMelliCode(params.melliCode)) {
            flash.message = message(code: 'melli-code')
            redirect(action: "list", params: params)
            return
        }
        if (!checkLoanNo(params.loanNo)) {
            flash.message = message(code: 'loan-no-rej')
            redirect(action: "list", params: params)
            return
        }
        def loanRequest_GHInstance
        if (params.id) {
            loanRequest_GHInstance = LoanRequest_GH.get(params.id)
            loanRequest_GHInstance.properties = params
        } else {
            loanRequest_GHInstance = new LoanRequest_GH(params)
            loanRequest_GHInstance.branch = branch
            loanRequest_GHInstance.requestDate = new Date()
        }
        loanRequest_GHInstance.requestUser = principalService.user
        loanRequest_GHInstance.loanRequestStatus = LoanRequest_GH.Pending

        if (!loanRequest_GHInstance.id && LoanRequest_GH.countByLoanNoAndLoanRequestStatusNotEqual(loanRequest_GHInstance.loanNo, LoanRequest_GH.Cancel) > 0) {
            flash.message = message(code: 'loan-no-not-unique')
            prms = params
        } else {
            if (loanRequest_GHInstance.save(flush: true)) {
            } else {
                flash.message = loanRequest_GHInstance.errors.allErrors.collect {
                    message(error: it)
                }.join("\n")
                prms = params
            }
        }
        redirect(action: "list", params: prms)
    }

    def show() {
        def loanRequest_GHInstance = LoanRequest_GH.get(params.id)
        if (!loanRequest_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_GHInstance: loanRequest_GHInstance]
    }

    def edit() {
        def loanRequest_GHInstance = LoanRequest_GH.get(params.id)
        if (!loanRequest_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_GHInstance: loanRequest_GHInstance]
    }

    def update() {
        def loanRequest_GHInstance = LoanRequest_GH.get(params.id)
        if (!loanRequest_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (loanRequest_GHInstance.version > version) {
                loanRequest_GHInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH')] as Object[],
                        "Another user has updated this LoanRequest_GH while you were editing")
                render(view: "edit", model: [loanRequest_GHInstance: loanRequest_GHInstance])
                return
            }
        }

        loanRequest_GHInstance.properties = params

        if (!loanRequest_GHInstance.save(flush: true)) {
            render(view: "edit", model: [loanRequest_GHInstance: loanRequest_GHInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), loanRequest_GHInstance.id])
        redirect(action: "show", id: loanRequest_GHInstance.id)
    }

    def delete() {
        def loanRequest_GHInstance = LoanRequest_GH.get(params.id)
        if (!loanRequest_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), params.id])
            redirect(action: "list")
            return
        }

        try {
            loanRequest_GHInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def preAccept() {
        def req = LoanRequest_GH.get(params.id)
        if (loanService.checkResourceAvailabilityGH(req.branch, req.loanAmount)) {
            render([result: "OK", message: message(code: "branch-ok", args: [req.loanAmount])] as JSON)
        } else {
            if (loanService.checkResourceAvailabilityGHOld(req.branch, req.loanAmount)) {
                render([result: "CANCEL", message: message(code: "branch-cancel-t")] as JSON)
            } else {
                render([result: "CANCEL", message: message(code: "branch-cancel-gh-central-bank")] as JSON)
            }
        }
    }

    def acceptReject() {
        def req = LoanRequest_GH.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_GH.Pending) {
            req.loanRequestStatus = LoanRequest_NT.Cancel
            req.rejectUser = principalService.user
            req.rejectDate = new Date()
            req.save()
        }
        render 0
    }

    def acceptConfirm() {
        def req = LoanRequest_GH.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_GH.Pending) {
            req.loanRequestStatus = LoanRequest_T.Confirm
            req.loanIDCode = loanService.generateLoanId(req.branch, LoanType.get(req.loanType.id), new Date(), req.loanNo)
            req.confirmUser = principalService.user
            req.confirmedDate = new Date()
            req.save()
        }
        render 0
    }

    def report() {
        def columns = [
                [label: message(code: 'loanRequest_NT.loanNo'), name: "loanNo"],
                [label: message(code: 'loanRequest_NT.loanIDCode'), name: 'loanIDCode', expression: 'obj.loanRequestStatus in [\\\'Confirm\\\',\\\'Paid\\\']?obj.loanIDCode:\\\'\\\''],
                [label: message(code: 'loanRequest_NT.loanType'), name: 'loanType'],
                [label: message(code: 'loanRequest_NT.name'), name: 'name'],
                [label: message(code: 'loanRequest_NT.family'), name: 'family'],
                [label: message(code: 'loanRequest_NT.melliCode'), name: 'melliCode'],
                [label: message(code: 'loanRequest_NT.loanAmount'), name: 'loanAmount'],
                [label: message(code: 'loanRequest_NT.loanRequestStatus'), name: 'loanRequestStatus'],
                [label: message(code: 'loanRequest_T.branch'), name: 'branch'],
                [label: message(code: 'loanRequest_NT.rejectReason'), name: 'rejectReason'],
                [label: message(code: 'loanRequest_T.requestUser'), name: 'requestUser'],
                [label: message(code: 'loanRequest_T.rejectUser'), name: 'rejectUser'],
                [label: message(code: 'loanRequest_T.confirmUser'), name: 'confirmUser'],
                [label: message(code: 'loanRequest_T.requestDate'), name: 'requestDate']]
        def selColumns = params.columns ? columns.findAll { params.columns.contains(it.name) } : columns.subList(0, 7);
        [branch: principalService.branch,
                branchHead: principalService.branchHead,
                bankRegion: principalService.bankRegion,
                columns: columns,
                selColumns: selColumns,
                selColumnsNames: selColumns.collect { it.name }]
    }
}
