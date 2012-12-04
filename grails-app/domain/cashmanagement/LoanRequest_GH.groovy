package cashmanagement

class LoanRequest_GH {
    String loanNo
    String loanIDCode
    Integer loanReqStatus
    Number loanAmount
    Date statusDate
    LoanType loanType
    Branch branchCode
    Date registerTimeStamp
    String loginUser

    static constraints = {
    }
}
