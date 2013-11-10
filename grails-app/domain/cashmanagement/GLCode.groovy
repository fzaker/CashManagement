package cashmanagement

class GLCode {
    GLGroup glGroup
    String glCode
    String title
    Double glFlag=1

    static constraints = {
        glGroup()
        glCode(unique: true)
        title(nullable: true)
        glFlag()

    }
    String toString(){
        glCode
    }
}
