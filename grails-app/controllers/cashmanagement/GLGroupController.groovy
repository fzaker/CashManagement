package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class GLGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [GLGroupInstance: new GLGroup(params)]
    }

    def save() {
        def GLGroupInstance = new GLGroup(params)
        if (!GLGroupInstance.save(flush: true)) {
            render(view: "create", model: [GLGroupInstance: GLGroupInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), GLGroupInstance.id])
        redirect(action: "show", id: GLGroupInstance.id)
    }

    def show() {
        def GLGroupInstance = GLGroup.get(params.id)
        if (!GLGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), params.id])
            redirect(action: "list")
            return
        }

        [GLGroupInstance: GLGroupInstance]
    }

    def edit() {
        def GLGroupInstance = GLGroup.get(params.id)
        if (!GLGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), params.id])
            redirect(action: "list")
            return
        }

        [GLGroupInstance: GLGroupInstance]
    }

    def update() {
        def GLGroupInstance = GLGroup.get(params.id)
        if (!GLGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (GLGroupInstance.version > version) {
                GLGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'GLGroup.label', default: 'GLGroup')] as Object[],
                        "Another user has updated this GLGroup while you were editing")
                render(view: "edit", model: [GLGroupInstance: GLGroupInstance])
                return
            }
        }

        GLGroupInstance.properties = params

        if (!GLGroupInstance.save(flush: true)) {
            render(view: "edit", model: [GLGroupInstance: GLGroupInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), GLGroupInstance.id])
        redirect(action: "show", id: GLGroupInstance.id)
    }

    def delete() {
        def GLGroupInstance = GLGroup.get(params.id)
        if (!GLGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), params.id])
            redirect(action: "list")
            return
        }

        try {
            GLGroupInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'GLGroup.label', default: 'GLGroup'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
