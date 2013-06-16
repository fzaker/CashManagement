package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class BranchController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [branchInstance: new Branch(params)]
    }

    def save() {
        def branchInstance = new Branch(params)
        if (!branchInstance.save(flush: true)) {
            render(view: "create", model: [branchInstance: branchInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'branch.label', default: 'Branch'), branchInstance.id])
        redirect(action: "show", id: branchInstance.id)
    }

    def show() {
        def branchInstance = Branch.get(params.id)
        if (!branchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
            redirect(action: "list")
            return
        }

        [branchInstance: branchInstance]
    }

    def edit() {
        def branchInstance = Branch.get(params.id)
        if (!branchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
            redirect(action: "list")
            return
        }

        [branchInstance: branchInstance]
    }

    def update() {
        def branchInstance = Branch.get(params.id)
        if (!branchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (branchInstance.version > version) {
                branchInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'branch.label', default: 'Branch')] as Object[],
                        "Another user has updated this Branch while you were editing")
                render(view: "edit", model: [branchInstance: branchInstance])
                return
            }
        }

        branchInstance.properties = params

        if (!branchInstance.save(flush: true)) {
            render(view: "edit", model: [branchInstance: branchInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'branch.label', default: 'Branch'), branchInstance.id])
        redirect(action: "show", id: branchInstance.id)
    }

    def delete() {
        def branchInstance = Branch.get(params.id)
        if (!branchInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
            redirect(action: "list")
            return
        }

        try {
            branchInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
