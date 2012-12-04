package cashmanagement

class LoanRequestNT_HeadOffice {

    LoanRequest_NT loanRequest_nt
    String loanReqStatus     // ** Confirm - Cancel - Send to BankRegion
    String request_Desc

    Date timeStamp
    String loginUser


    static constraints = {
        loanReqStatus(inList: ["Confirm", "Cancel", "Sent", "Pending"])
    }
}
