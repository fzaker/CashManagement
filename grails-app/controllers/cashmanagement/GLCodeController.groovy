package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class GLCodeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [GLCodeInstance: new GLCode(params)]
    }

    def save() {
        def GLCodeInstance = new GLCode(params)
        if (!GLCodeInstance.save(flush: true)) {
            render(view: "create", model: [GLCodeInstance: GLCodeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'GLCode.label', default: 'GLCode'), GLCodeInstance.id])
        redirect(action: "show", id: GLCodeInstance.id)
    }

    def show() {
        def GLCodeInstance = GLCode.get(params.id)
        if (!GLCodeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLCode.label', default: 'GLCode'), params.id])
            redirect(action: "list")
            return
        }

        [GLCodeInstance: GLCodeInstance]
    }

    def edit() {
        def GLCodeInstance = GLCode.get(params.id)
        if (!GLCodeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLCode.label', default: 'GLCode'), params.id])
            redirect(action: "list")
            return
        }

        [GLCodeInstance: GLCodeInstance]
    }

    def update() {
        def GLCodeInstance = GLCode.get(params.id)
        if (!GLCodeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLCode.label', default: 'GLCode'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (GLCodeInstance.version > version) {
                GLCodeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'GLCode.label', default: 'GLCode')] as Object[],
                        "Another user has updated this GLCode while you were editing")
                render(view: "edit", model: [GLCodeInstance: GLCodeInstance])
                return
            }
        }

        GLCodeInstance.properties = params

        if (!GLCodeInstance.save(flush: true)) {
            render(view: "edit", model: [GLCodeInstance: GLCodeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'GLCode.label', default: 'GLCode'), GLCodeInstance.id])
        redirect(action: "show", id: GLCodeInstance.id)
    }

    def delete() {
        def GLCodeInstance = GLCode.get(params.id)
        if (!GLCodeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLCode.label', default: 'GLCode'), params.id])
            redirect(action: "list")
            return
        }

        try {
            GLCodeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'GLCode.label', default: 'GLCode'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'GLCode.label', default: 'GLCode'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
