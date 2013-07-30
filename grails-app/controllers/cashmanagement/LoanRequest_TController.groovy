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
        def permitAmount = PermissionAmount_T.findAllByBranch(branch, [max: 1, sort: "permissionDate", order: "desc"]).find()
        def usedAmountBranch = cashmanagement.LoanRequest_T.findAllByBranchAndRequestDateGreaterThanEqualsAndLoanRequestStatus(branch, permitAmount.permissionDate, LoanRequest_T.Confirm).sum {it.loanAmount} ?: 0
        def loanRequest_t = LoanRequest_T.get(params.id)
        return [branch: branch, usedAmount: usedAmountBranch, permitAmount: permitAmount?.permAmount, loanRequest_t: loanRequest_t]
    }

    def create() {
        [loanRequest_TInstance: new LoanRequest_T(params)]
    }

    def save() {
        def branch = principalService.getBranch()

        def loanRequest_TInstance
        if (params.id) {
            loanRequest_TInstance = LoanRequest_T.get(params.id)
            loanRequest_TInstance.properties = params
        }
        else {
            loanRequest_TInstance = new LoanRequest_T(params)
            loanRequest_TInstance.branch = branch
            loanRequest_TInstance.requestDate = new Date()
        }
        loanRequest_TInstance.requestUser = principalService.user
//        if (loanService.checkResourceAvailabilityT(branch, loanRequest_TInstance.loanAmount)) {
//        loanRequest_TInstance.loanIDCode = loanService.generateLoanId(branch, LoanType.get(params.loanType.id), new Date(), params.loanNo)
//            loanRequest_TInstance.loanRequestStatus = LoanRequest_NT.Confirm
//        }
//        else {
//            loanRequest_TInstance.loanRequestStatus = LoanRequest_NT.Cancel
//
//        }
        loanRequest_TInstance.loanRequestStatus = LoanRequest_T.Pending
        loanRequest_TInstance.save(flush: true)
        redirect(action: "list")
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
}
