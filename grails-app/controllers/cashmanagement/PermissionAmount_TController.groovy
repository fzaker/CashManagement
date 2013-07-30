package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import fi.joensuu.joyds1.calendar.JalaliCalendar

class PermissionAmount_TController {
    def loanService
    def principalService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def br = principalService.getBranchHead()
        def result
        if (br)
            result = loanService.getVosooli(br)
        else
            result = []

        [resultParm: result, branchHead: br]
    }

    def create() {
        [permissionAmount_TInstance: new PermissionAmount_T(params)]
    }

    def save() {
        def region = principalService.branchHead
        def date = params.date("date")
        def branchs = Branch.findAllByBranchHead(region)
        branchs.each {
            def permissionAmount = PermissionAmount_T.findByBranchAndPermissionDate(it, date)
            if (!permissionAmount)
                permissionAmount = new PermissionAmount_T(branch: it, permissionDate: date)
            def permAmt = params["branch_${it.id}"] ?: "0"
            permAmt = permAmt.replace(",", "")
            permissionAmount.permAmount = Double.valueOf(permAmt)
            permissionAmount.save()
        }
        redirect(action: "list")
    }

    def show() {
        def permissionAmount_TInstance = PermissionAmount_T.get(params.id)
        if (!permissionAmount_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), params.id])
            redirect(action: "list")
            return
        }

        [permissionAmount_TInstance: permissionAmount_TInstance]
    }

    def edit() {
        def permissionAmount_TInstance = PermissionAmount_T.get(params.id)
        if (!permissionAmount_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), params.id])
            redirect(action: "list")
            return
        }

        [permissionAmount_TInstance: permissionAmount_TInstance]
    }

    def update() {
        def permissionAmount_TInstance = PermissionAmount_T.get(params.id)
        if (!permissionAmount_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (permissionAmount_TInstance.version > version) {
                permissionAmount_TInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T')] as Object[],
                        "Another user has updated this PermissionAmount_T while you were editing")
                render(view: "edit", model: [permissionAmount_TInstance: permissionAmount_TInstance])
                return
            }
        }

        permissionAmount_TInstance.properties = params

        if (!permissionAmount_TInstance.save(flush: true)) {
            render(view: "edit", model: [permissionAmount_TInstance: permissionAmount_TInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), permissionAmount_TInstance.id])
        redirect(action: "show", id: permissionAmount_TInstance.id)
    }

    def delete() {
        def permissionAmount_TInstance = PermissionAmount_T.get(params.id)
        if (!permissionAmount_TInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), params.id])
            redirect(action: "list")
            return
        }

        try {
            permissionAmount_TInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
