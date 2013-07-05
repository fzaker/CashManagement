package cashmanagement

class BranchHeadNTParams {
    Double maxGrowth
    Double minGrowth
    Double permitToward
    BranchHead branchHead

    static constraints = {
        maxGrowth(nullable: false)
        minGrowth(nullable: false)
        permitToward(nullable: false)
        branchHead(nullable: false)
    }
}
