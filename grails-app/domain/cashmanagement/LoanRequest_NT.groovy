package cashmanagement

class LoanRequest_NT {
    static final String Pending = "Pending"
    static final String Cancel = "Cancel"
    static final String Confirm = "Confirm"
    static final String Sent = "Sent"
    static final String Paid = "Paid"

    String loanNo
    String loanIDCode
    String name
    String family
    String customerType
    String melliCode
    String loanRequestStatus
    Double loanAmount
    Date requestDate
    Date payDate
    LoanType loanType
    Branch branch
    RejectReason rejectReason
    User user
    User sendUser
    User sendUserBranchHead
    User rejectUser
    User confirmUser

    static constraints = {
        loanNo(nullable: false)
        loanType(nullable: false)
        customerType(nullable: true, inList: ['indv', 'corp', 'frgn'])
        name()
        family()
        melliCode()
        loanAmount(nullable: false)
        requestDate(nullable: false)
        loanRequestStatus(inList: [Confirm, Cancel, Pending, Sent, Paid])
        branch(nullable: false)
        rejectReason(nullable: true)
        loanIDCode(nullable: true)
        user(nullable: true)
        sendUser(nullable: true)
        sendUserBranchHead(nullable: true)
        confirmUser(nullable: true)
        rejectUser(nullable: true)
        payDate(nullable: true)
    }
    static charts = {
        chart(title: "masarefbemanabeBranches", yTitle: "", subtitle: "", variable: "branch") {
            column("value")
        }
        chart(title: "availableBranches", yTitle: "", subtitle: "", variable: "branch") {
            column("value")
        }
        chart(title: "masarefbemanabeBrancheHeads", yTitle: "", subtitle: "", variable: "branchHead") {
            column("value")
        }
        chart(title: "availableBrancheHeads", yTitle: "", subtitle: "", variable: "branchHead") {
            column("value")
        }
        chart(title: "sumLoanBranch", yTitle: "", subtitle: "", variable: "requestDate") {
            column("loanAmount")
        }
        chart(title: "masarefbemanabe", yTitle: "", subtitle: "", variable: "title") {
            column("amount")
        }


    }
}
