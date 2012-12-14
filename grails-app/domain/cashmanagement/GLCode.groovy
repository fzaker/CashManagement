package cashmanagement

class GLCode {
    GLGroup glGroup
    String glCode
    Long glFlag
    Branch branch

    static constraints = {
        glGroup()
        glCode()
        glFlag(inList:[1L,-1L] )
        branch(nullable: false)
    }
    String toString(){
        glCode
    }
}
