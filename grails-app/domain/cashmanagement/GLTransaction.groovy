package cashmanagement

class GLTransaction {
    GLCode glCode
    Date tranDate
    Double glAmount
    Branch branch

    static constraints = {
    }

    String toString() {
        "${glCode} ${tranDate} ${glAmount}"
    }
}
