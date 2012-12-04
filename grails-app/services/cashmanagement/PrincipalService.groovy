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
        user.authorities.each {
            if(it instanceof BranchRole)
                return it.branch
        }
    }
}
