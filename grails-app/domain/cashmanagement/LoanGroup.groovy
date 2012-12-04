package cashmanagement

class LoanGroup {
    String loanGroupCode
    String loanGroupName

    static  hasMany = [loanTypes: LoanType]

    static constraints = {
        loanGroupCode(unique: true)
    }
    String toString(){
        loanGroupName+"("+loanGroupCode+")"
    }
}
