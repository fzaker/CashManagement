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

    transient def getName() {
        "${loanRequest_nt.name} ${loanRequest_nt.family}"
    }

    transient def getMelliCode() {
        loanRequest_nt.melliCode
    }

    transient def getLoanNo() {
        loanRequest_nt.loanNo
    }

    transient def getLoanIDCode() {
        loanRequest_nt.loanIDCode
    }

    transient def getLoanType() {
        loanRequest_nt.loanType
    }

    transient Double getLoanAmount() {
        loanRequest_nt.loanAmount
    }

    transient Double getRemainingAmount() {
        if (id) {
            return Math.max(loanAmount  - branch.available,0)
        }
        return 0

    }

    transient def getRequestDate() {
        loanRequest_nt.requestDate
    }

    transient def getBranch() {
        loanRequest_nt.branch
    }

    static constraints = {
        loanNo()
        name()
        melliCode()
        loanType()
        requestDate()
        branch()
        loanAmount()
        remainingAmount()

        loanReqStatus(inList: ["Confirm", "Cancel", "Sent", "Pending"])
        loanIDCode()
        request_Desc(nullable: true)
        rejectReason(nullable: true)
        changeDate(nullable: true)
        user(nullable: true)
    }

}
