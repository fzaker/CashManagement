package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class BankRegionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [bankRegionInstance: new BankRegion(params)]
    }

    def save() {
        def bankRegionInstance = new BankRegion(params)
        if (!bankRegionInstance.save(flush: true)) {
            render(view: "create", model: [bankRegionInstance: bankRegionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), bankRegionInstance.id])
        redirect(action: "show", id: bankRegionInstance.id)
    }

    def show() {
        def bankRegionInstance = BankRegion.get(params.id)
        if (!bankRegionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), params.id])
            redirect(action: "list")
            return
        }

        [bankRegionInstance: bankRegionInstance]
    }

    def edit() {
        def bankRegionInstance = BankRegion.get(params.id)
        if (!bankRegionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), params.id])
            redirect(action: "list")
            return
        }

        [bankRegionInstance: bankRegionInstance]
    }

    def update() {
        def bankRegionInstance = BankRegion.get(params.id)
        if (!bankRegionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (bankRegionInstance.version > version) {
                bankRegionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'bankRegion.label', default: 'BankRegion')] as Object[],
                        "Another user has updated this BankRegion while you were editing")
                render(view: "edit", model: [bankRegionInstance: bankRegionInstance])
                return
            }
        }

        bankRegionInstance.properties = params

        if (!bankRegionInstance.save(flush: true)) {
            render(view: "edit", model: [bankRegionInstance: bankRegionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), bankRegionInstance.id])
        redirect(action: "show", id: bankRegionInstance.id)
    }

    def delete() {
        def bankRegionInstance = BankRegion.get(params.id)
        if (!bankRegionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), params.id])
            redirect(action: "list")
            return
        }

        try {
            bankRegionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'bankRegion.label', default: 'BankRegion'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
