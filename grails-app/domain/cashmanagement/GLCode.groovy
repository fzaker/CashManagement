package cashmanagement

class GLCode {
    GLGroup glGroup
    String glCode
    Long glFlag
    Branch branch

    static constraints = {
        glGroup()
        glCode(unique: true)
        glFlag(inList:[1,-1] )
        branch(nullable: false)
    }
    String toString(){
        glCode
    }
}
