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
    transient def getPercentCurMonth() {
        if (this?.id) {
            def service = ApplicationHolder.application.getMainContext().getBean("loanService")
            service.checkAvailable_numofdays_curMonth(this,0)*100
        }
    }
    transient def getPercentOldMonth() {
        if (this?.id) {
            def service = ApplicationHolder.application.getMainContext().getBean("loanService")
            service.checkAvailable_numofdays_oldMonth(this)*100
        }
    }


    static constraints = {
        branchHead()
        branchCode(unique: true)
        branchName(nullable: false)
        available()
        percentCurMonth()
        percentOldMonth()
    }

    String toString() {
        branchName + "(" + branchCode + ")"
    }
}
