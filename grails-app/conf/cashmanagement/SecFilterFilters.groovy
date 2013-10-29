package cashmanagement

class SecFilterFilters {
    def principalService
    def basicInformation = ['branchHead', 'bankRegion', 'branch', 'loanGroup', 'loanType', 'glCode', 'glGroup', 'rejectReason']
    def admin = ['systemParameters', 'loanRequest_NT:headOffice']
    def branch = ['loanRequest_NT:index', 'loanRequest_NT:list', 'loanRequest_T:index', 'loanRequest_T:list', 'loanRequest_GH:index', 'loanRequest_GH:list']
    def branchHead = ['loanRequest_NT:branchHead', 'loanRequest_NT:branchHeadPercents', 'permissionAmount_T', 'permissionAmount_GH']
    def bankRegion = ['loanRequest_NT:bankRegion', 'loanRequest_NT:bankRegionPercents']
    def bankRegionOrAdmin = ['etayeeTBranchHead', 'etayeeGHBranchHead', 'loanRequest_NT:report_date']
    def branchHeadOrAdmin = ['user']
    def filters = {
        basicInformation.each {
            all(controller: it, action: '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!principalService.user?.basicInformation) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }
        admin.each {
            all(controller: it.split(':')[0], action: (it.contains(':')) ? (it.split(':')[1]) : '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!principalService.user?.isAdmin) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }
        branch.each {
            all(controller: it.split(':')[0], action: (it.contains(':')) ? (it.split(':')[1]) : '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!principalService.user?.branch) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }
        branchHead.each {
            all(controller: it.split(':')[0], action: (it.contains(':')) ? (it.split(':')[1]) : '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!principalService.user?.branchHead) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }
        bankRegion.each {
            all(controller: it.split(':')[0], action: (it.contains(':')) ? (it.split(':')[1]) : '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!principalService.user?.bankRegion) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }
        bankRegionOrAdmin.each {
            all(controller: it.split(':')[0], action: (it.contains(':')) ? (it.split(':')[1]) : '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!(principalService.user?.isAdmin || principalService.user?.bankRegion)) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }
        branchHeadOrAdmin.each {
            all(controller: it.split(':')[0], action: (it.contains(':')) ? (it.split(':')[1]) : '*') {
                before = {
                    if (request.method == 'GET') {
                        if (!(principalService.user?.isAdmin || principalService.user?.branchHead)) {
                            redirect(controller: 'login', action: 'deny')
                            return false
                        }
                    }
                }
            }
        }

    }
}
