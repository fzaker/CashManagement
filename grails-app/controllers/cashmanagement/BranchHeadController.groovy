package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class BranchHeadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [branchHeadInstance: new BranchHead(params)]
    }

    def save() {
        def branchHeadInstance = new BranchHead(params)
        if (!branchHeadInstance.save(flush: true)) {
            render(view: "create", model: [branchHeadInstance: branchHeadInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), branchHeadInstance.id])
        redirect(action: "show", id: branchHeadInstance.id)
    }

    def show() {
        def branchHeadInstance = BranchHead.get(params.id)
        if (!branchHeadInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), params.id])
            redirect(action: "list")
            return
        }

        [branchHeadInstance: branchHeadInstance]
    }

    def edit() {
        def branchHeadInstance = BranchHead.get(params.id)
        if (!branchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), params.id])
            redirect(action: "list")
            return
        }

        [branchHeadInstance: branchHeadInstance]
    }

    def update() {
        def branchHeadInstance = BranchHead.get(params.id)
        if (!branchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (branchHeadInstance.version > version) {
                branchHeadInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'branchHead.label', default: 'BranchHead')] as Object[],
                          "Another user has updated this BranchHead while you were editing")
                render(view: "edit", model: [branchHeadInstance: branchHeadInstance])
                return
            }
        }

        branchHeadInstance.properties = params

        if (!branchHeadInstance.save(flush: true)) {
            render(view: "edit", model: [branchHeadInstance: branchHeadInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), branchHeadInstance.id])
        redirect(action: "show", id: branchHeadInstance.id)
    }

    def delete() {
        def branchHeadInstance = BranchHead.get(params.id)
        if (!branchHeadInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), params.id])
            redirect(action: "list")
            return
        }

        try {
            branchHeadInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'branchHead.label', default: 'BranchHead'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
