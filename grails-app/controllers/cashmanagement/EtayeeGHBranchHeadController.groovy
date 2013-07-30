package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class EtayeeGHBranchHeadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [etayeeGHBranchHeadInstance: new EtayeeGHBranchHead(params)]
    }

    def save() {
        def etayeeGHBranchHeadInstance = new EtayeeGHBranchHead(params)
        if (!etayeeGHBranchHeadInstance.save(flush: true)) {
            render(view: "create", model: [etayeeGHBranchHeadInstance: etayeeGHBranchHeadInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), etayeeGHBranchHeadInstance.id])
        redirect(action: "show", id: etayeeGHBranchHeadInstance.id)
    }

    def show() {
        def etayeeGHBranchHeadInstance = EtayeeGHBranchHead.get(params.id)
        if (!etayeeGHBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        [etayeeGHBranchHeadInstance: etayeeGHBranchHeadInstance]
    }

    def edit() {
        def etayeeGHBranchHeadInstance = EtayeeGHBranchHead.get(params.id)
        if (!etayeeGHBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        [etayeeGHBranchHeadInstance: etayeeGHBranchHeadInstance]
    }

    def update() {
        def etayeeGHBranchHeadInstance = EtayeeGHBranchHead.get(params.id)
        if (!etayeeGHBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (etayeeGHBranchHeadInstance.version > version) {
                etayeeGHBranchHeadInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead')] as Object[],
                        "Another user has updated this EtayeeGHBranchHead while you were editing")
                render(view: "edit", model: [etayeeGHBranchHeadInstance: etayeeGHBranchHeadInstance])
                return
            }
        }

        etayeeGHBranchHeadInstance.properties = params

        if (!etayeeGHBranchHeadInstance.save(flush: true)) {
            render(view: "edit", model: [etayeeGHBranchHeadInstance: etayeeGHBranchHeadInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), etayeeGHBranchHeadInstance.id])
        redirect(action: "show", id: etayeeGHBranchHeadInstance.id)
    }

    def delete() {
        def etayeeGHBranchHeadInstance = EtayeeGHBranchHead.get(params.id)
        if (!etayeeGHBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        try {
            etayeeGHBranchHeadInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
