package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class SystemParametersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [systemParametersInstance: new SystemParameters(params)]
    }

    def save() {
        def systemParametersInstance = new SystemParameters(params)
        if (!systemParametersInstance.save(flush: true)) {
            render(view: "create", model: [systemParametersInstance: systemParametersInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), systemParametersInstance.id])
        redirect(action: "show", id: systemParametersInstance.id)
    }

    def show() {
        def systemParametersInstance = SystemParameters.get(params.id)
        if (!systemParametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "list")
            return
        }

        [systemParametersInstance: systemParametersInstance]
    }

    def edit() {
        def systemParametersInstance = SystemParameters.get(params.id)
        if (!systemParametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "list")
            return
        }

        [systemParametersInstance: systemParametersInstance]
    }

    def update() {
        def systemParametersInstance = SystemParameters.get(params.id)
        if (!systemParametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (systemParametersInstance.version > version) {
                systemParametersInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'systemParameters.label', default: 'SystemParameters')] as Object[],
                        "Another user has updated this SystemParameters while you were editing")
                render(view: "edit", model: [systemParametersInstance: systemParametersInstance])
                return
            }
        }

        systemParametersInstance.properties = params

        if (!systemParametersInstance.save(flush: true)) {
            render(view: "edit", model: [systemParametersInstance: systemParametersInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), systemParametersInstance.id])
        redirect(action: "show", id: systemParametersInstance.id)
    }

    def delete() {
        def systemParametersInstance = SystemParameters.get(params.id)
        if (!systemParametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "list")
            return
        }

        try {
            systemParametersInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
