package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class RejectReasonController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [rejectReasonInstance: new RejectReason(params)]
    }

    def save() {
        def rejectReasonInstance = new RejectReason(params)
        if (!rejectReasonInstance.save(flush: true)) {
            render(view: "create", model: [rejectReasonInstance: rejectReasonInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), rejectReasonInstance.id])
        redirect(action: "show", id: rejectReasonInstance.id)
    }

    def show() {
        def rejectReasonInstance = RejectReason.get(params.id)
        if (!rejectReasonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), params.id])
            redirect(action: "list")
            return
        }

        [rejectReasonInstance: rejectReasonInstance]
    }

    def edit() {
        def rejectReasonInstance = RejectReason.get(params.id)
        if (!rejectReasonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), params.id])
            redirect(action: "list")
            return
        }

        [rejectReasonInstance: rejectReasonInstance]
    }

    def update() {
        def rejectReasonInstance = RejectReason.get(params.id)
        if (!rejectReasonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (rejectReasonInstance.version > version) {
                rejectReasonInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'rejectReason.label', default: 'RejectReason')] as Object[],
                        "Another user has updated this RejectReason while you were editing")
                render(view: "edit", model: [rejectReasonInstance: rejectReasonInstance])
                return
            }
        }

        rejectReasonInstance.properties = params

        if (!rejectReasonInstance.save(flush: true)) {
            render(view: "edit", model: [rejectReasonInstance: rejectReasonInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), rejectReasonInstance.id])
        redirect(action: "show", id: rejectReasonInstance.id)
    }

    def delete() {
        def rejectReasonInstance = RejectReason.get(params.id)
        if (!rejectReasonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), params.id])
            redirect(action: "list")
            return
        }

        try {
            rejectReasonInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'rejectReason.label', default: 'RejectReason'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
