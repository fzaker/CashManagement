package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class LoanRequest_GHController {
    def principalService
    def loanService
    static allowedMethods = [update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [loanRequest_GHInstance: new LoanRequest_GH(params)]
    }

    def save() {
        def branch = principalService.getBranch()

        def loanRequest_GHInstance = new LoanRequest_GH(params)
        loanRequest_GHInstance.branch = branch
        loanRequest_GHInstance.loanIDCode = loanService.generateLoanId()
        loanRequest_GHInstance.requestDate = new Date()
        if (loanService.checkResourceAvailability(branch, loanRequest_GHInstance.loanAmount)) {
            loanRequest_GHInstance.loanRequestStatus = LoanRequest_GH.Confirm
        }
        else {
            loanRequest_GHInstance.loanRequestStatus = LoanRequest_GH.Cancel

        }


        if (!loanRequest_GHInstance.save(flush: true)) {
            render(view: "create", model: [loanRequest_NTInstance: loanRequest_GHInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'loanRequest_GH.label', default: 'LoanRequest_NT'), loanRequest_GHInstance.id])
        redirect(action: "show", id: loanRequest_GHInstance.id)
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
