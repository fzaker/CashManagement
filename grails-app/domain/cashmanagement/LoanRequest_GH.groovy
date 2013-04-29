package cashmanagement

class LoanRequest_GH {
    static final String Pending = "Pending"
    static final String Cancel = "Cancel"
    static final String Confirm = "Confirm"
    static final String Sent = "Sent"

    String loanNo
    String name
    String family
    String melliCode
    String loanIDCode
    String loanRequestStatus
    Double loanAmount
    Date requestDate
    LoanType loanType
    Branch branch
    RejectReason rejectReason
//    Date registerTimeStamp
//    String loginUser

    static constraints = {
        loanNo(nullable: false, unique: true)
        loanIDCode(nullable: true, unique: true)
        loanType(nullable: false)
        name()
        family()
        melliCode()
        loanAmount(nullable: false)
        requestDate(nullable: false)
        loanRequestStatus(inList: [Confirm, Cancel, Pending, Sent])
        branch(nullable: false)
        rejectReason(nullable: true)
    }
}
