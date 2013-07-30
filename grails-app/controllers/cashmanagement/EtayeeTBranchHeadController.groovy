package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class EtayeeTBranchHeadController {
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
        [etayeeTBranchHeadInstance: new EtayeeTBranchHead(params)]
    }

    def save() {
        def etayeeTBranchHeadInstance
        if (params.id) {
            etayeeTBranchHeadInstance = EtayeeTBranchHead.get(params.id)
            etayeeTBranchHeadInstance.properties = params
        }
        else
            etayeeTBranchHeadInstance = new EtayeeTBranchHead(params)
        etayeeTBranchHeadInstance.date = new Date()
        etayeeTBranchHeadInstance.user = principalService.user
        etayeeTBranchHeadInstance.save(flush: true)
        render 0
    }

    def show() {
        def etayeeTBranchHeadInstance = EtayeeTBranchHead.get(params.id)
        if (!etayeeTBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        [etayeeTBranchHeadInstance: etayeeTBranchHeadInstance]
    }

    def edit() {
        def etayeeTBranchHeadInstance = EtayeeTBranchHead.get(params.id)
        if (!etayeeTBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        [etayeeTBranchHeadInstance: etayeeTBranchHeadInstance]
    }

    def update() {
        def etayeeTBranchHeadInstance = EtayeeTBranchHead.get(params.id)
        if (!etayeeTBranchHeadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (etayeeTBranchHeadInstance.version > version) {
                etayeeTBranchHeadInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead')] as Object[],
                        "Another user has updated this EtayeeTBranchHead while you were editing")
                render(view: "edit", model: [etayeeTBranchHeadInstance: etayeeTBranchHeadInstance])
                return
            }
        }

        etayeeTBranchHeadInstance.properties = params

        if (!etayeeTBranchHeadInstance.save(flush: true)) {
            render(view: "edit", model: [etayeeTBranchHeadInstance: etayeeTBranchHeadInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead'), etayeeTBranchHeadInstance.id])
        redirect(action: "show", id: etayeeTBranchHeadInstance.id)
    }

    def delete() {
        def etayeeTBranchHeadInstance = EtayeeTBranchHead.get(params.id)
        def count = LoanRequest_T.createCriteria().get {
            projections {
                count("id")
            }
            branch {
                branchHead {
                    eq("id", etayeeTBranchHeadInstance?.id)
                }
            }
            ge("requestDate", etayeeTBranchHeadInstance?.date)
        }
        if (count > 0) {
            render message(code: 'cannot-delete-this')
        }
        else {
            etayeeTBranchHeadInstance.delete()
            render 1
        }
    }
}
