package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class EtayeeGHBranchHeadController {
    def principalService
    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def branchHeads = []
        if (principalService.user?.isAdmin)
            branchHeads = BranchHead.list().sort()
        if (principalService.user?.bankRegion)
            branchHeads = BranchHead.findAllByBankRegion(principalService.user?.bankRegion).sort()
        [branchHeads: branchHeads]
    }

    def create() {
        [etayeeGHBranchHeadInstance: new EtayeeGHBranchHead(params)]
    }

    def save() {
        def etayeeGHBranchHeadInstance
        if (params.id) {
            etayeeGHBranchHeadInstance = EtayeeGHBranchHead.get(params.id)
            etayeeGHBranchHeadInstance.properties = params
        }
        else
            etayeeGHBranchHeadInstance = new EtayeeGHBranchHead(params)
        etayeeGHBranchHeadInstance.date = new Date()
        etayeeGHBranchHeadInstance.user = principalService.user
        etayeeGHBranchHeadInstance.save(flush: true)
        render 0
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
        def count = LoanRequest_GH.createCriteria().get {
            projections {
                count("id")
            }
            branch {
                branchHead {
                    eq("id", etayeeGHBranchHeadInstance?.id)
                }
            }
            ge("requestDate", etayeeGHBranchHeadInstance?.date)
        }
        if (count > 0) {
            render message(code: 'cannot-delete-this')
        }
        else {
            etayeeGHBranchHeadInstance.delete()
            render 1
        }
    }
}
