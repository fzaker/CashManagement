package cashmanagement

class LoanType {
    String loanTypeCode
    String loanTypeName
    LoanGroup loanGroup

    static constraints = {
        loanGroup()
        loanTypeCode(unique: true)
        loanTypeName(nullable: false)
    }
    String toString(){
        loanTypeName+"("+loanTypeCode+")"
    }
}
