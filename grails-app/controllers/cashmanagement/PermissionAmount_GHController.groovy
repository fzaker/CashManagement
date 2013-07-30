package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import fi.joensuu.joyds1.calendar.JalaliCalendar

class PermissionAmount_GHController {

    def principalService
    def loanService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def br = principalService.getBranchHead()
        def result
        if (br)
            result = loanService.getVosooliGH(br)
        else
            result = []

        [resultParm: result, branchHead: br]
    }

    def create() {
        [permissionAmount_GHInstance: new PermissionAmount_GH(params)]
    }

    def save() {
        def region = principalService.branchHead
        def date = params.date("date")
        def branchs = Branch.findAllByBranchHead(region)
        branchs.each {
            def permissionAmount = PermissionAmount_GH.findByBranchAndPermissionDate(it, date)
            if (!permissionAmount)
                permissionAmount = new PermissionAmount_GH(branch: it, permissionDate: date)
            def permAmt = params["branch_${it.id}"] ?: "0"
            permAmt = permAmt.replace(",", "")
            permissionAmount.permAmount = Double.valueOf(permAmt)
            permissionAmount.save()
        }
        redirect(action: "list")
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

    def branchHeadList() {
        def region = principalService.bankRegion
        [bankRegion: region]
    }

    def saveBranchHeadPermissionAmount() {
        def region = principalService.bankRegion
        def year = new JalaliCalendar().year
        def branchHeads = BranchHead.findAllByBankRegion(region)
        branchHeads.each {
            def permissionAmount = PermissionAmount_BranchHead_GH.findByBranchHeadAndYear(it, year)
            if (!permissionAmount)
                permissionAmount = new PermissionAmount_BranchHead_GH(branchHead: it, year: year)
            def val = params["branchHead_${it.id}"] ?: "0"
            val = val.replace(",", "")
            permissionAmount.permAmount = Double.valueOf(val)
            permissionAmount.save()
        }
        redirect(action: "branchHeadList")
    }

    def saveBranchPermissionAmount() {
        def region = principalService.branchHead
        def year = new JalaliCalendar().year
        def branchs = Branch.findAllByBranchHead(region)
        branchs.each {
            def permissionAmount = PermissionAmount_GH.findByBranchAndYear(it, year)
            if (!permissionAmount)
                permissionAmount = new PermissionAmount_GH(branch: it, year: year)
            def val = params["branch_${it.id}"] ?: "0"
            val = val.replace(",", "")
            permissionAmount.permAmount = Double.valueOf(val)
            permissionAmount.save()
        }
        redirect(action: "list")
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
