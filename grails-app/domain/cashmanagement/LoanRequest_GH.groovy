package cashmanagement

class LoanRequest_GH {
    static final String Pending = "Pending"
    static final String Cancel = "Cancel"
    static final String Confirm = "Confirm"
    static final String Sent = "Sent"

    String loanNo
    String loanIDCode
    String loanRequestStatus
    Double loanAmount
    Date requestDate
    LoanType loanType
    Branch branch
//    Date registerTimeStamp
//    String loginUser

    static constraints = {
        loanNo(nullable: false, unique: true)
        loanIDCode(nullable: false, unique: true)
        loanType(nullable: false)
        loanAmount(nullable: false)
        requestDate(nullable: false)
        loanRequestStatus(inList: [Confirm, Cancel, Pending, Sent])
        branch(nullable: false)
    }
}
