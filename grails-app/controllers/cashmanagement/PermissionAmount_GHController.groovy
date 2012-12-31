package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class PermissionAmount_GHController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [permissionAmount_GHInstance: new PermissionAmount_GH(params)]
    }

    def save() {
        def permissionAmount_GHInstance = new PermissionAmount_GH(params)
        if (!permissionAmount_GHInstance.save(flush: true)) {
            render(view: "create", model: [permissionAmount_GHInstance: permissionAmount_GHInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), permissionAmount_GHInstance.id])
        redirect(action: "show", id: permissionAmount_GHInstance.id)
    }

    def show() {
        def permissionAmount_GHInstance = PermissionAmount_GH.get(params.id)
        if (!permissionAmount_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), params.id])
            redirect(action: "list")
            return
        }

        [permissionAmount_GHInstance: permissionAmount_GHInstance]
    }

    def edit() {
        def permissionAmount_GHInstance = PermissionAmount_GH.get(params.id)
        if (!permissionAmount_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), params.id])
            redirect(action: "list")
            return
        }

        [permissionAmount_GHInstance: permissionAmount_GHInstance]
    }

    def update() {
        def permissionAmount_GHInstance = PermissionAmount_GH.get(params.id)
        if (!permissionAmount_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (permissionAmount_GHInstance.version > version) {
                permissionAmount_GHInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH')] as Object[],
                        "Another user has updated this PermissionAmount_GH while you were editing")
                render(view: "edit", model: [permissionAmount_GHInstance: permissionAmount_GHInstance])
                return
            }
        }

        permissionAmount_GHInstance.properties = params

        if (!permissionAmount_GHInstance.save(flush: true)) {
            render(view: "edit", model: [permissionAmount_GHInstance: permissionAmount_GHInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), permissionAmount_GHInstance.id])
        redirect(action: "show", id: permissionAmount_GHInstance.id)
    }

    def delete() {
        def permissionAmount_GHInstance = PermissionAmount_GH.get(params.id)
        if (!permissionAmount_GHInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), params.id])
            redirect(action: "list")
            return
        }

        try {
            permissionAmount_GHInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
