package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import fi.joensuu.joyds1.calendar.JalaliCalendar
import grails.converters.JSON

class LoanRequest_TController {
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
        def permitAmounts = PermissionAmount_T.findAllByBranch(branch, [sort: "permissionDate", order: "desc"])
        def permitAmount = permitAmounts.find()?: new PermissionAmount_T()
        def usedAmountBranch = cashmanagement.LoanRequest_T.findAllByBranchAndLoanRequestStatusInList(branch, [LoanRequest_T.Confirm, LoanRequest_T.Paid]).sum { it.loanAmount } ?: 0
        def paidAmount = cashmanagement.LoanRequest_T.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_T.Paid).sum { it.loanAmount } ?: 0
        def paidAmountPeriod = cashmanagement.LoanRequest_T.findAllByBranchAndRequestDateGreaterThanEqualsAndLoanRequestStatus(branch, permitAmount.permissionDate, LoanRequest_T.Paid).sum { it.loanAmount } ?: 0
        def loanRequest_t = LoanRequest_T.get(params.id)
        return [branch: branch, usedAmount: usedAmountBranch ?: 0,
                sumPermitAmount:permitAmounts.collect {it.permAmount}.sum(),
                permitAmount: permitAmount?.permAmount ?: 0, loanRequest_t: loanRequest_t,
                paidLoanAmount: paidAmount ?: 0,
                paidLoanAmountThisPeriod: paidAmountPeriod ?: 0]
    }

    def create() {
        [loanRequest_TInstance: new LoanRequest_T(params)]
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
        def loanRequest_TInstance
        if (params.id) {
            loanRequest_TInstance = LoanRequest_T.get(params.id)
            loanRequest_TInstance.properties = params
        } else {
            loanRequest_TInstance = new LoanRequest_T(params)
            loanRequest_TInstance.branch = branch
            loanRequest_TInstance.requestDate = new Date()
        }
        loanRequest_TInstance.requestUser = principalService.user
        loanRequest_TInstance.loanRequestStatus = LoanRequest_T.Pending

        if (!loanRequest_TInstance.id && LoanRequest_T.countByLoanNoAndLoanRequestStatusNotEqual(loanRequest_TInstance.loanNo, LoanRequest_T.Cancel) > 0) {
            flash.message = message(code: 'loan-no-not-unique')
            prms = params

        } else {
            if (loanRequest_TInstance.save(flush: true)) {
            } else {
                flash.message = loanRequest_TInstance.errors.allErrors.collect {
                    message(error: it)
                }.join("\n")
                prms = params
            }
        }
        redirect(action: "list", params: prms)
    }

    def show() {
        def loanRequest_TInstance = LoanRequest_T.get(params.id)
        if (!loanRequest_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_TInstance: loanRequest_TInstance]
    }

    def edit() {
        def loanRequest_TInstance = LoanRequest_T.get(params.id)
        if (!loanRequest_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_TInstance: loanRequest_TInstance]
    }

    def update() {
        def loanRequest_TInstance = LoanRequest_T.get(params.id)
        if (!loanRequest_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (loanRequest_TInstance.version > version) {
                loanRequest_TInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'loanRequest_T.label', default: 'LoanRequest_T')] as Object[],
                        "Another user has updated this LoanRequest_T while you were editing")
                render(view: "edit", model: [loanRequest_TInstance: loanRequest_TInstance])
                return
            }
        }

        loanRequest_TInstance.properties = params

        if (!loanRequest_TInstance.save(flush: true)) {
            render(view: "edit", model: [loanRequest_TInstance: loanRequest_TInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), loanRequest_TInstance.id])
        redirect(action: "show", id: loanRequest_TInstance.id)
    }

    def reject() {
        def loanRequest = LoanRequest_T.get(params.id)
        loanRequest.loanRequestStatus = LoanRequest_T.Cancel
        loanRequest.rejectReason = RejectReason.get(params.rejectReasonId)
        loanRequest.rejectUser = principalService.user
        loanRequest.rejectDate = new Date()
        loanRequest.save(flush: true)
        render viewParams() as JSON
    }

    def delete() {
        def loanRequest_TInstance = LoanRequest_T.get(params.id)
        if (!loanRequest_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), params.id])
            redirect(action: "list")
            return
        }

        try {
            loanRequest_TInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loanRequest_T.label', default: 'LoanRequest_T'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def preAccept() {
        def req = LoanRequest_T.get(params.id)
        if (loanService.checkResourceAvailabilityT(req.branch, req.loanAmount)) {
            render([result: "OK", message: message(code: "branch-ok", args: [req.loanAmount])] as JSON)
        } else
            render([result: "CANCEL", message: message(code: "branch-cancel-t")] as JSON)
    }

    def acceptReject() {
        def req = LoanRequest_T.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_T.Pending) {
            req.loanRequestStatus = LoanRequest_NT.Cancel
            req.rejectUser = principalService.user
            req.rejectDate = new Date()
            req.save()
        }
        render 0
    }

    def acceptConfirm() {
        def req = LoanRequest_T.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_T.Pending) {
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
