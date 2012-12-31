package cashmanagement

import org.codehaus.groovy.grails.commons.ApplicationHolder

class Branch {
    BranchHead branchHead
    String branchCode
    String branchName

    transient def getAvailable() {
        if (this?.id) {
            def service = ApplicationHolder.application.getMainContext().getBean("loanService")
            service.getAvailable(this)
        }
    }


    static constraints = {
        branchHead()
        branchCode(unique: true)
        branchName(nullable: false)
        available()
    }

    String toString() {
        branchName + "(" + branchCode + ")"
    }
}
