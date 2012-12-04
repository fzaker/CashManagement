package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class LoanRequest_NTController {
    def principalService
    def loanService

    static allowedMethods = [ update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [loanRequest_NTInstance: new LoanRequest_NT(params)]
    }

    def save() {
        def branch = principalService.getBranch()

        def loanRequest_NTInstance = new LoanRequest_NT(params)
        loanRequest_NTInstance.branch = branch
        loanRequest_NTInstance.loanIDCode = loanService.generateLoanId()
        loanRequest_NTInstance.requestDate=new Date()
        if(loanService.checkResourceAvailability(branch,loanRequest_NTInstance.loanAmount)){
            loanRequest_NTInstance.loanRequestStatus=LoanRequest_NT.Confirm
        }
        else{
            loanRequest_NTInstance.loanRequestStatus=LoanRequest_NT.Pending

        }


        if (!loanRequest_NTInstance.save(flush: true)) {
            render(view: "create", model: [loanRequest_NTInstance: loanRequest_NTInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), loanRequest_NTInstance.id])
        redirect(action: "show", id: loanRequest_NTInstance.id)
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
