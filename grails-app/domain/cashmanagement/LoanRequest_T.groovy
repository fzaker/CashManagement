package cashmanagement

class LoanRequest_T {
    static final String Pending = "Pending"
    static final String Cancel = "Cancel"
    static final String Confirm = "Confirm"
    static final String Sent = "Sent"
    static final String Paid = "Paid"

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

    User requestUser
    User confirmUser
    Date confirmedDate
    User rejectUser
    Date rejectDate

//    Date registerTimeStamp
//    String loginUser

    static constraints = {
        loanNo(nullable: false, unique: true)
        loanIDCode(nullable: true)
        loanType(nullable: false)
        name()
        family()
        melliCode()
        loanAmount(nullable: false)
        requestDate(nullable: false)
        loanRequestStatus(inList: [Confirm, Cancel, Pending, Paid])
        branch(nullable: false)
        rejectReason(nullable: true)
        requestUser(nullable: true)
        confirmUser(nullable: true)
        confirmedDate(nullable: true)
        rejectUser(nullable: true)
        rejectDate(nullable: true)
    }
}
