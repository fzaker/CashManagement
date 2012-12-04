package cashmanagement

class BranchHeadTransfer {
    Branch sourceBranch
    Branch destinationBranch
    Double transferAmount
    Date transferDate
    String transferStatus
    LoanRequest_NT loanRequest

    static constraints = {
        sourceBranch(nullable: false)
        destinationBranch(nullable: false)
        loanRequest(nullable: false)
        transferDate(nullable: false)
        transferAmount(nullable: false)
        transferStatus(inList:["Confirm","Cancel","Pending"] )

    }
}
