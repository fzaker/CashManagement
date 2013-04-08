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
        def res = getPermitAmts()
        res
    }

    def create() {
        [loanRequest_GHInstance: new LoanRequest_GH(params)]
    }

    def reject() {
        def loanRequest = LoanRequest_GH.get(params.id)
        loanRequest.loanRequestStatus = LoanRequest_GH.Cancel
        loanRequest.save(flush: true)
        def res = getPermitAmts()
        render res as JSON
    }

    private def getPermitAmts() {
        def sysParam = SystemParameters.findAll().first()
        def year = new JalaliCalendar().getYear()
        def month = new JalaliCalendar().month
        def firstOfMonth = new JalaliCalendar(new JalaliCalendar().year, new JalaliCalendar().month, 1).toJavaUtilGregorianCalendar().time
        def usedAmount = LoanRequest_GH.findAllByBranchAndLoanRequestStatus(principalService.branch, LoanRequest_GH.Confirm).sum {it.loanAmount} ?: 0
        def usedAmountMonth = LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateGreaterThanEquals(principalService.branch, LoanRequest_GH.Confirm, firstOfMonth).sum {it.loanAmount} ?: 0
        def permitAmt = PermissionAmount_GH.findByBranchAndYear(principalService.branch, year)?.permAmount ?: 0

        def usedAmountPrevMonths = LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateLessThan(principalService.branch, LoanRequest_GH.Confirm, firstOfMonth).sum {it.loanAmount} ?: 0
        def permitAmountPrevMonths = permitAmt * (month - 1) * sysParam.ghMonthlyPercent - usedAmountPrevMonths
        def res = [usedAmount: usedAmount, remainAmount: permitAmt - usedAmount, permitAmount: permitAmt, permitAmountMonth: permitAmt * sysParam.ghMonthlyPercent,
                usedAmountMonth: usedAmountMonth, remainAmountMonth: permitAmt * sysParam.ghMonthlyPercent +permitAmountPrevMonths - usedAmountMonth,
                branch: principalService.branch, bankPercent: loanService.masarefBeManabeGharzolhasane(), permitAmountPrevMonths: permitAmountPrevMonths]
        return res
    }

    def save() {
        def branch = principalService.getBranch()

        def loanRequest_GHInstance = new LoanRequest_GH(params)
        loanRequest_GHInstance.branch = branch
        loanRequest_GHInstance.loanIDCode = loanService.generateLoanId(branch, LoanType.get(params.loanType.id), new Date(), params.loanNo)
        loanRequest_GHInstance.requestDate = new Date()
        if (loanService.checkResourceAvailabilityGH(branch, loanRequest_GHInstance.loanAmount)) {
            loanRequest_GHInstance.loanRequestStatus = LoanRequest_GH.Confirm
        }
        else {
            loanRequest_GHInstance.loanRequestStatus = LoanRequest_GH.Cancel

        }


        loanRequest_GHInstance.save(flush: true)
        def res = getPermitAmts()
        render res as JSON
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
}
