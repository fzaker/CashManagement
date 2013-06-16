package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class LoanTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [loanTypeInstance: new LoanType(params)]
    }

    def save() {
        def loanTypeInstance = new LoanType(params)
        if (!loanTypeInstance.save(flush: true)) {
            render(view: "create", model: [loanTypeInstance: loanTypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'loanType.label', default: 'LoanType'), loanTypeInstance.id])
        redirect(action: "show", id: loanTypeInstance.id)
    }

    def show() {
        def loanTypeInstance = LoanType.get(params.id)
        if (!loanTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanType.label', default: 'LoanType'), params.id])
            redirect(action: "list")
            return
        }

        [loanTypeInstance: loanTypeInstance]
    }

    def edit() {
        def loanTypeInstance = LoanType.get(params.id)
        if (!loanTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanType.label', default: 'LoanType'), params.id])
            redirect(action: "list")
            return
        }

        [loanTypeInstance: loanTypeInstance]
    }

    def update() {
        def loanTypeInstance = LoanType.get(params.id)
        if (!loanTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanType.label', default: 'LoanType'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (loanTypeInstance.version > version) {
                loanTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'loanType.label', default: 'LoanType')] as Object[],
                        "Another user has updated this LoanType while you were editing")
                render(view: "edit", model: [loanTypeInstance: loanTypeInstance])
                return
            }
        }

        loanTypeInstance.properties = params

        if (!loanTypeInstance.save(flush: true)) {
            render(view: "edit", model: [loanTypeInstance: loanTypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'loanType.label', default: 'LoanType'), loanTypeInstance.id])
        redirect(action: "show", id: loanTypeInstance.id)
    }

    def delete() {
        def loanTypeInstance = LoanType.get(params.id)
        if (!loanTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanType.label', default: 'LoanType'), params.id])
            redirect(action: "list")
            return
        }

        try {
            loanTypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanType.label', default: 'LoanType'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loanType.label', default: 'LoanType'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
