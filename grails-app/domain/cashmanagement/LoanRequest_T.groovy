package cashmanagement

class LoanRequest_T {
    String loanNo
    String loanIDCode
    int loanReqStatus
    Number loanAmount
    Date statusDate
    LoanType loanType
    Branch branchCode

    Date registerTimeStamp
    String loginUser

    static constraints = {
    }
}
