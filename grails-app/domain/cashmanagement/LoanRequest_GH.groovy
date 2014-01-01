package cashmanagement

class LoanRequest_GH {
    static final String Pending = "Pending"
    static final String Cancel = "Cancel"
    static final String Confirm = "Confirm"
    static final String Paid = "Paid"

    String loanNo
    String name
    String family
    String customerType
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

    Date payDate
//    Date registerTimeStamp
//    String loginUser

    static constraints = {
        loanNo(nullable: false)
        loanIDCode(nullable: true)
        loanType(nullable: false)
        customerType(nullable: true, inList: ['indv', 'corp', 'frgn'])
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
        payDate(nullable: true)
    }
}
