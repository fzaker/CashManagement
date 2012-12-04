package cashmanagement

class BankRegion {
    String bankRegionCode
    String bankRegionName

    static hasMany = [branchHeads: BranchHead]

    static constraints = {
        bankRegionCode(unique: true)
        bankRegionName(nullable:false)
    }
    String toString(){
        bankRegionName+"("+bankRegionCode+")"
    }
}
