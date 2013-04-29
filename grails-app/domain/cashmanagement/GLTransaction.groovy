package cashmanagement

class GLTransaction {
    GLCode glCode
    Integer tranDate
    Double glAmount
    Branch branch

    static constraints = {
    }

    String toString() {
        "${glCode} ${tranDate} ${glAmount}"
    }
}
