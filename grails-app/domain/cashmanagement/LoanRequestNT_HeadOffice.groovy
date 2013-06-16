package cashmanagement

class LoanRequestNT_HeadOffice {

    LoanRequest_NT loanRequest_nt
    String loanReqStatus     // ** Confirm - Cancel - Send to BankRegion
    String request_Desc
    RejectReason rejectReason
    Date changeDate
    User user

//    Date timeStamp
//    String loginUser

    transient def getLoanNo() {
        loanRequest_nt.loanNo
    }

    transient def getLoanIDCode() {
        loanRequest_nt.loanIDCode
    }

    transient def getLoanType() {
        loanRequest_nt.loanType
    }

    transient def getLoanAmount() {
        loanRequest_nt.loanAmount
    }

    transient def getRequestDate() {
        loanRequest_nt.requestDate
    }

    transient def getBranch() {
        loanRequest_nt.branch
    }

    static constraints = {
        loanNo()
        loanIDCode()
        loanType()
        loanAmount()
        requestDate()

        branch()
        loanReqStatus(inList: ["Confirm", "Cancel", "Sent", "Pending"])
        request_Desc(nullable: true)
        rejectReason(nullable: true)
        changeDate(nullable: true)
        user(nullable: true)
    }

}
