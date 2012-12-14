package cashmanagement

class LoanRequestNT_BankRegion {
    LoanRequest_NT loanRequest_nt
    String loanReqStatus     // ** Confirm - Cancel - Send to BankRegion
    String request_Desc


    static constraints = {

        loanReqStatus(inList: ["Confirm", "Cancel", "Sent", "Pending"])
        request_Desc(nullable: true)

    }
}
