package cashmanagement

class GLCode {
    GLGroup glGroup
    String glCode
    Long glFlag

    static constraints = {
        glGroup()
        glCode()
        glFlag(inList:[1L,-1L] )
    }
    String toString(){
        glCode
    }
}
