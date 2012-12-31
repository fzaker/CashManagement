package cashmanagement

import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser

class PrincipalService {

    def springSecurityService

    def getUser() {
        def princ = springSecurityService.getPrincipal()
        if (princ instanceof GrailsUser) {
            return User.findByUsername(princ.getUsername())
        }
    }

    def getBranch() {
        def user = getUser()
        def branch
        user.authorities.each {
            if(it instanceof BranchRole)
                branch = it.branch
        }
        return branch
    }
    def getBranchHead() {
        def user = getUser()
        def branchhead
        user.authorities.each {
            if(it instanceof BranchHeadRole)
                branchhead = it.branchHead
        }
        return branchhead
    }
    def getBankRegion() {
        def user = getUser()
        def bankRegion
        user.authorities.each {
            if(it instanceof BankRegionRole)
                bankRegion = it.bankRegion
        }
        return bankRegion
    }
}
