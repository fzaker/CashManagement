package cashmanagement

import org.codehaus.groovy.grails.commons.ApplicationHolder

class Branch {
    BranchHead branchHead
    String branchCode
    String branchName

    transient Double getAvailable() {
        if (this?.id) {
            def service = ApplicationHolder.application.getMainContext().getBean("loanService")
            service.getAvailable(this)
        }
    }
    transient Double getPermitTowardGT(){
        if (this?.id) {
            def service = ApplicationHolder.application.getMainContext().getBean("loanService")
            service.getPermitTowardGT(this)
        }
    }
    transient Double getKasri() {
        if (this?.id) {
            def service = ApplicationHolder.application.getMainContext().getBean("loanService")
            def k=service.getAvailable(this,Long.MIN_VALUE)
            Math.abs(Math.min(k,0))
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
