package cashmanagement

class LoanGroup {
    String loanGroupCode
    String loanGroupName
    GLGroup manabe
    GLGroup masaref

    static  hasMany = [loanTypes: LoanType]

    static constraints = {
        loanGroupCode(unique: true)
        loanGroupName()
        manabe(nullable: true)
        masaref(nullable: true)
    }
    String toString(){
        loanGroupName+"("+loanGroupCode+")"
    }
}
