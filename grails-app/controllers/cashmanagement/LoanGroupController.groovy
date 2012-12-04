package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class LoanGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [loanGroupInstance: new LoanGroup(params)]
    }

    def save() {
        def loanGroupInstance = new LoanGroup(params)
        if (!loanGroupInstance.save(flush: true)) {
            render(view: "create", model: [loanGroupInstance: loanGroupInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), loanGroupInstance.id])
        redirect(action: "show", id: loanGroupInstance.id)
    }

    def show() {
        def loanGroupInstance = LoanGroup.get(params.id)
        if (!loanGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), params.id])
            redirect(action: "list")
            return
        }

        [loanGroupInstance: loanGroupInstance]
    }

    def edit() {
        def loanGroupInstance = LoanGroup.get(params.id)
        if (!loanGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), params.id])
            redirect(action: "list")
            return
        }

        [loanGroupInstance: loanGroupInstance]
    }

    def update() {
        def loanGroupInstance = LoanGroup.get(params.id)
        if (!loanGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (loanGroupInstance.version > version) {
                loanGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'loanGroup.label', default: 'LoanGroup')] as Object[],
                          "Another user has updated this LoanGroup while you were editing")
                render(view: "edit", model: [loanGroupInstance: loanGroupInstance])
                return
            }
        }

        loanGroupInstance.properties = params

        if (!loanGroupInstance.save(flush: true)) {
            render(view: "edit", model: [loanGroupInstance: loanGroupInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), loanGroupInstance.id])
        redirect(action: "show", id: loanGroupInstance.id)
    }

    def delete() {
        def loanGroupInstance = LoanGroup.get(params.id)
        if (!loanGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), params.id])
            redirect(action: "list")
            return
        }

        try {
            loanGroupInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loanGroup.label', default: 'LoanGroup'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
