package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
    }

    def create() {
        [userInstance: new User(params)]
    }

    def form() {
        def user
        def branch
        def branchHead
        def bankRegion
        if (params.id) {
            user = User.get(params.id)
            branch = (user.authorities?.find {it instanceof BranchRole} as BranchRole)?.branch
            branchHead = (user.authorities?.find {it instanceof BranchHeadRole} as BranchHeadRole)?.branchHead
            bankRegion = (user.authorities?.find {it instanceof BankRegionRole} as BankRegionRole)?.bankRegion
        }
        else {
            user = new User()
        }
        render(template: "form", model: [userInstance: user, branch: branch, branchHead: branchHead, bankRegion: bankRegion])
    }

    def password() {
        def user = User.get(params.id)
        render(template: "password", model: [user: user])
    }

    def savepass() {
        def user = User.get(params.id)
        user.password = params.password
        user.save()
        render 0;
    }

    def save() {
        def user
        if (params.id) {
            user = User.get(params.id)
            user.properties = params
        }
        else {
            user = new User(params)
            user.accountExpired = false
            user.accountLocked = false
            user.enabled = true
        }

        user.save()

        if (params.branchId) {
            def branch = Branch.get(params.branchId)
            def branchRole = BranchRole.findByBranch(branch) ?: new BranchRole(branch: branch, authority: "branch_${branch.id}").save()
            user.authorities.findAll {it instanceof BranchRole}.each {UserRole.remove(user, it)}
            if (branchRole)
                UserRole.create(user, branchRole)

        }
        else {
            def branchRole = user.authorities.find {it instanceof BranchRole}
            if (branchRole)
                UserRole.remove(user, branchRole)
        }
        if (params.branchHeadId) {
            def branchH = BranchHead.get(params.branchHeadId)
            def branchRole = BranchHeadRole.findByBranchHead(branchH) ?: new BranchHeadRole(branchHead: branchH, authority: "branchHead_${branchH.id}").save()
            user.authorities.findAll {it instanceof BranchHeadRole}.each {UserRole.remove(user, it)}
            if (branchRole)
                UserRole.create(user, branchRole)
        }
        else {
            def branchRole = user.authorities.find {it instanceof BranchHeadRole}
            if (branchRole)
                UserRole.remove(user, branchRole)
        }

        if (params.bankRegionId) {
            def bankRegion = BankRegion.get(params.bankRegionId)
            def branchRole = BankRegionRole.findByBankRegion(bankRegion) ?: new BankRegionRole(bankRegion: bankRegion, authority: "bankRegion_${bankRegion.id}").save()
            user.authorities.findAll {it instanceof BankRegionRole}.each {UserRole.remove(user, it)}
            if (branchRole)
                UserRole.create(user, branchRole)
        }
        else {
            def branchRole = user.authorities.find {it instanceof BankRegionRole}
            if (branchRole)
                UserRole.remove(user, branchRole)
        }
        render user as JSON
    }

    def show() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
