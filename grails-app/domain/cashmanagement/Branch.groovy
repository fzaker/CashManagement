package cashmanagement

class Branch {
    BranchHead branchHead
    String branchCode
    String branchName

  static constraints = {
       branchHead()
       branchCode(unique: true)
       branchName(nullable: false)

    }
    String toString(){
        branchName+"("+branchCode+")"
    }
}
