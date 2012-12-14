package cashmanagement

class GLGroup {
    String glGroupCode
    String glGroupName


    static constraints = {
        glGroupCode()
        glGroupName(nullable: false)
    }
    String toString(){
        glGroupName+"("+glGroupCode+")"
    }
}
