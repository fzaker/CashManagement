package cashmanagement

import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.commons.ApplicationHolder
import grails.converters.JSON

class LoanRequest_NTController {
    def principalService
    def loanService

    static allowedMethods = [update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def branch = principalService.branch
        [branch: branch, permitAmount: loanService.getAvailable(branch), usedPercent: loanService.checkAvailable_numofdays_curMonth(branch, 0) * 100, usedPercentPrevMonth: loanService.checkAvailable_numofdays_oldMonth(branch) * 100]
    }

    def create() {
        [loanRequest_NTInstance: new LoanRequest_NT(params)]
    }

    def accept() {
        def req = LoanRequest_NT.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_NT.Pending) {
            def loanReqBranch = new LoanRequestNT_BranchHead(loanReqStatus: LoanRequest_NT.Pending, loanRequest_nt: req)
            loanReqBranch.save(true)
            req.loanRequestStatus = LoanRequest_NT.Sent
            req.save()
        }
        render 0
    }

    def reject() {
        def req = LoanRequest_NT.get(params.id)
        if (req && req.loanRequestStatus == LoanRequest_NT.Pending) {
            req.loanRequestStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.save()
        }
        render 0
    }

    def acceptBranchHead() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            def loanReqRegion = new LoanRequestNT_BankRegion(loanReqStatus: LoanRequest_NT.Pending, loanRequest_nt: req.loanRequest_nt)
            loanReqRegion.save(true)
            req.loanReqStatus = LoanRequest_NT.Sent
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
        }
        render 0
    }

    def rejectBranchHead() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            req.loanReqStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Cancel
            req.loanRequest_nt.rejectReason = RejectReason.get(params.rejectReasonId)
            req.save()
        }
        render 0
    }

    def acceptBankRegion() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            def loanReqHead = new LoanRequestNT_HeadOffice(loanReqStatus: LoanRequest_NT.Pending, loanRequest_nt: req.loanRequest_nt)
            loanReqHead.save(true)
            req.loanReqStatus = LoanRequest_NT.Sent
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
        }
        render 0
    }

    def rejectBankRegion() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        if (req && req.loanReqStatus == LoanRequest_NT.Pending) {
            req.loanReqStatus = LoanRequest_NT.Cancel
            req.rejectReason = RejectReason.get(params.rejectReasonId)
            req.user = principalService.user
            req.changeDate = new Date()
            req.save()
            req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Cancel
            req.loanRequest_nt.rejectReason = RejectReason.get(params.rejectReasonId)
            req.save()
        }
        render 0
    }

    def save() {
        def branch = principalService.getBranch()
        def loanRequest_NTInstance = new LoanRequest_NT(params)
        loanRequest_NTInstance.branch = branch
        loanRequest_NTInstance.loanIDCode = loanService.generateLoanId(branch, LoanType.get(params.loanType.id), new Date(), params.loanNo)
        loanRequest_NTInstance.requestDate = new Date()
        loanRequest_NTInstance.user = principalService.user
        if (loanService.checkResourceAvailability(branch, loanRequest_NTInstance.loanAmount)) {
            loanRequest_NTInstance.loanRequestStatus = LoanRequest_NT.Confirm
        }
        else {
            loanRequest_NTInstance.loanRequestStatus = LoanRequest_NT.Pending

        }
        if (LoanRequest_NT.countByLoanNo(loanRequest_NTInstance.loanNo) > 0) {
            flash.message = message(code: 'loan-no-not-unique')

        }
        else {
            if (loanRequest_NTInstance.save(flush: true)) {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), loanRequest_NTInstance.id])
            }
        }
        redirect(action: "list")
    }

    def branchHead() {
        def branchHead = principalService.getBranchHead()
        [branchHead: branchHead]
    }

    def bankRegion() {
        def bankRegion = principalService.getBankRegion()
        [bankRegion: bankRegion]
    }

    def getRequestBranch() {
        def req = LoanRequestNT_BranchHead.get(params.id)
        render req.branch as JSON
    }

    def getRequestBranchHead() {
        def req = LoanRequestNT_BankRegion.get(params.id)
        render req.branch as JSON
    }

    def linkBranchRequest() {
        try {
            def destBranch = Branch.get(params.branchId)
            def req = LoanRequestNT_BranchHead.get(params.reqId)
            def amt = params.amt ?: "0"
            def amount = amt as Double
            if (amount <= 0) {
                render message(code: 'please-enter-amount')
            }
            else if (amount >= destBranch.available) {
                render message(code: 'branch-available-is-less-than-request')
            }
            else {
                def user = principalService.user
                def debitBarrow = new LoanRequestNTBarrow(branch: req.branch, date: new Date(), debit: amount, request: req.loanRequest_nt, user: user).save()
                def creditBarrow = new LoanRequestNTBarrow(branch: destBranch, date: new Date(), credit: amount, request: req.loanRequest_nt, user: user).save()
                if (loanService.getAvailable(req.branch) >= req.loanAmount) {
                    req.loanReqStatus = LoanRequest_NT.Confirm
                    req.changeDate=new Date()
                    req.user=principalService.user
                    req.save()
                    req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Confirm
                    req.loanRequest_nt.save()
                }
                render message(code: 'request-assign-successfull')
            }
        } catch (e) {
            render(message(code: 'error') + e.message)
        }
    }

    def linkBranchRequestRegion() {
        try {
            def destBranch = Branch.get(params.branchId)
            def amt = params.amt ?: "0"
            def amount = amt as Double
            def req = LoanRequestNT_BankRegion.get(params.reqId)
            if (amount <= 0) {
                render message(code: 'please-enter-amount')
            }
            else if (amount >= destBranch.available) {
                render message(code: 'branch-available-is-less-than-request')
            }
            else {
                def user = principalService.user
                def debitBarrow = new LoanRequestNTBarrow(branch: req.branch, date: new Date(), debit: amount, request: req.loanRequest_nt, user: user).save()
                def creditBarrow = new LoanRequestNTBarrow(branch: destBranch, date: new Date(), credit: amount, request: req.loanRequest_nt, user: user).save()
                if (loanService.getAvailable(req.branch) >= req.loanAmount) {
                    req.loanReqStatus = LoanRequest_NT.Confirm
                    req.changeDate=new Date()
                    req.user=principalService.user
                    req.save()
                    req.loanRequest_nt.loanRequestStatus = LoanRequest_NT.Confirm
                    req.loanRequest_nt.save()
                }
                render message(code: 'request-assign-successfull')
            }
        } catch (e) {
            render(message(code: 'error') + e.message)
        }
    }

    def showBranchDetails() {
        def branch = Branch.get(params.id)
        [branchInstance: branch]
    }

    def showRequestDetails() {
        def loanRequest
        if (params.bankRegion)
            loanRequest = LoanRequestNT_BankRegion.get(params.bankRegion).loanRequest_nt
        if (params.branchHead)
            loanRequest = LoanRequestNT_BranchHead.get(params.branchHead).loanRequest_nt
        if (params.id)
            loanRequest = LoanRequest_NT.get(params.id)
        def branchHead = LoanRequestNT_BranchHead.findByLoanRequest_nt(loanRequest)
        def bankRegion = LoanRequestNT_BankRegion.findByLoanRequest_nt(loanRequest)
        def hasBarrow = LoanRequestNTBarrow.countByRequest(loanRequest) > 0
        [loanRequest_NTInstance: loanRequest, requestBranchHead: branchHead, requestBankRegion: bankRegion, hasBarrow: hasBarrow]

    }

    def show() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_NTInstance: loanRequest_NTInstance]
    }

    def edit() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        [loanRequest_NTInstance: loanRequest_NTInstance]
    }

    def update() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (loanRequest_NTInstance.version > version) {
                loanRequest_NTInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')] as Object[],
                        "Another user has updated this LoanRequest_NT while you were editing")
                render(view: "edit", model: [loanRequest_NTInstance: loanRequest_NTInstance])
                return
            }
        }

        loanRequest_NTInstance.properties = params

        if (!loanRequest_NTInstance.save(flush: true)) {
            render(view: "edit", model: [loanRequest_NTInstance: loanRequest_NTInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), loanRequest_NTInstance.id])
        redirect(action: "show", id: loanRequest_NTInstance.id)
    }

    def delete() {
        def loanRequest_NTInstance = LoanRequest_NT.get(params.id)
        if (!loanRequest_NTInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
            return
        }

        try {
            loanRequest_NTInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
