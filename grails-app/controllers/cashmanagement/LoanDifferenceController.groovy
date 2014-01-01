package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class LoanDifferenceController {
    def principalService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        [branch: principalService.branch, branchHead: principalService.branchHead, bankRegion: principalService.bankRegion]
    }

}
