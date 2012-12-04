package cashmanagement

class GLCode {
    GLGroup glGroup
    String glCode
    Long glFlag

    static constraints = {
        glGroup()
        glCode(unique: true)
        glFlag(inList:[1,-1] )

    }
    String toString(){
        glCode
    }
}
