package cashmanagement

class GLCode {
    GLGroup glGroup
    String glCode
    String title
    Long glFlag

    static constraints = {
        glGroup()
        glCode(unique: true)
        title(nullable: true)
        glFlag(inList:[1L,-1L] )

    }
    String toString(){
        glCode
    }
}
