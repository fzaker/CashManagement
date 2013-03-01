package cashmanagement

class CashmanagementTagLib {
    def principalService
    static namespace = "c"

    def isAdmin = { attrs, body ->
        if (principalService.user?.isAdmin) {
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
        if (principalService.user?.isAdmin || principalService.user?.isBasicInformation()) {
            out << body()
        }
    }
    def isBranchOrBranchHeadOrBankRegion = { attrs, body ->
        if (principalService.branch != null || principalService.branchHead != null || principalService.bankRegion != null) {
            out << body()
        }
    }

}
