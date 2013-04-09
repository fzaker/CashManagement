package cashmanagement

class LoanRequest_NT {
    static final String Pending = "Pending"
    static final String Cancel = "Cancel"
    static final String Confirm = "Confirm"
    static final String Sent = "Sent"

    String loanNo
    String loanIDCode
    String name
    String loanRequestStatus
    Double loanAmount
    Date requestDate
    LoanType loanType
    Branch branch
    RejectReason rejectReason
    User user
    static constraints = {
        loanNo(nullable: false, unique: true)
        loanIDCode(nullable: false, unique: true)
        loanType(nullable: false)
        name()
        loanAmount(nullable: false)
        requestDate(nullable: false)
        loanRequestStatus(inList: [Confirm, Cancel, Pending, Sent])
        branch(nullable: false)
        rejectReason(nullable: true)
        user(nullable: true)
    }
}
