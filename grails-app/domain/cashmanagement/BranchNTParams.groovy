package cashmanagement

class BranchNTParams {
    Double maxGrowth
    Double minGrowth
    Double permitToward
    Branch branch

    static constraints = {
        maxGrowth(nullable: false)
        minGrowth(nullable: false)
        permitToward(nullable: false)
        branch(nullable: false)
    }
}
