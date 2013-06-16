package cashmanagement

class RejectReason {
    String code
    String title
    static constraints = {
        code(unique: true)
        title(nullable: false)
    }
    String toString(){
        "${title}(${code})"
    }
}
