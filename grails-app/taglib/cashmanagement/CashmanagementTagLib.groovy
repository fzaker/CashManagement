package cashmanagement

class CashmanagementTagLib {
    def principalService
    static namespace = "c"

    def isAdmin = { attrs, body ->
        if (principalService.user?.isAdmin) {
            out << body()
        }
    }
    def isBankRegionOrAdmin = {attrs, body ->
        if (principalService.user?.isAdmin || principalService.bankRegion) {
            out << body()
        }
    }
    def isBasicInformation = { attrs, body ->
        if (principalService.user?.basicInformation) {
            out << body()
        }
    }

    def isBranchUser = { attrs, body ->
        if (principalService.branch != null) {
            out << body()
        }
    }

    def isBranchHeadUser = { attrs, body ->
        if (principalService.branchHead != null) {
            out << body()
        }
    }

    def isBankRegionUser = { attrs, body ->
        if (principalService.bankRegion) {
            out << body()
        }
    }
    def isAdminOrBasicInformation = { attrs, body ->
        if (principalService.user?.isAdmin || principalService.user?.basicInformation) {
            out << body()
        }
    }
    def isBranchOrBranchHeadOrBankRegion = { attrs, body ->
        if (principalService.branch != null || principalService.branchHead != null || principalService.bankRegion != null) {
            out << body()
        }
    }
    def isBranchOrBranchHeadOrBankRegionOrAdmin = { attrs, body ->
        if (principalService.branch != null || principalService.branchHead != null || principalService.bankRegion != null || principalService.user?.isAdmin) {
            out << body()
        }
    }
    def loginmessage = {attrs, body ->
        if (principalService.user) {
            out << message(code: 'user.name.label')
            out << ': <b>' + principalService.user.name + "</b>  "
            if (principalService.branch) {
                out << message(code: 'branch')
                out << ': <b>' + principalService.branch + "</b>  "
            }
            if (principalService.branchHead) {
                out << message(code: 'branchHead')
                out << ': <b>' + principalService.branchHead + "</b>  "
            }
            if (principalService.bankRegion) {
                out << message(code: 'bankRegion')
                out << ': <b>' + principalService.bankRegion + "</b>  "
            }
        }
    }
}
