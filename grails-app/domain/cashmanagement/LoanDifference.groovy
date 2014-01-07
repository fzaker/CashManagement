package cashmanagement

class LoanDifference implements Serializable {
    Integer branchCode
    String acctNo
    String firstName
    String lastName
    String melliCode
    String openDate
    Double balance

    static mapping = {
        table 'vwloan_difference'
        id composite: ['branchCode', 'acctNo', 'melliCode', 'openDate', 'balance'], insertable: false, updateable: false
        version(false)
        branchCode column: 'BranchCode'
        acctNo column: 'ACC_No', insertable: false, updateable: false
        firstName column: 'FRST_Name'
        lastName column: 'LAST_Name'
        melliCode column: 'Melli_Id'
        openDate column: 'Open_Date'
        balance column: 'Balance'

    }
    static constraints = {
        branchCode(nullable: true)
        acctNo(nullable: true)
        firstName(nullable: true)
        lastName(nullable: true)
        melliCode(nullable: true)
        openDate(nullable: true)
        balance(nullable: true)
    }
}
