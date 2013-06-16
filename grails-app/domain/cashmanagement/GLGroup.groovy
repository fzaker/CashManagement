package cashmanagement

class GLGroup {
    String glGroupCode
    String glGroupName


    static constraints = {
        glGroupCode(unique: true)
        glGroupName(nullable: false)
    }
    String toString(){
        glGroupName+"("+glGroupCode+")"
    }
}
