package cashmanagement

class LoanRequestNTBarrow {
    Branch branch
    Date date
    Double debit
    Double credit
    LoanRequest_NT request
    String description
    User user
    LoanRequestNTBarrow otherSide
    static constraints = {
        credit(nullable: true)
        debit(nullable: true)
        description(nullable: true)
        user(nullable: true)
        otherSide(nullable: false)
    }
}
