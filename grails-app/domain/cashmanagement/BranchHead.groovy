package cashmanagement

class BranchHead {
    BankRegion bankRegion
    String branchHeadCode
    String branchHeadName

    static hasMany = [branches: Branch]

    static constraints = {
        bankRegion()
        branchHeadCode(unique: true)
        branchHeadName(nullable: false)
    }
    String toString(){
        branchHeadName+"("+branchHeadCode+")"
    }
}
