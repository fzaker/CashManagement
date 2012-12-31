package cashmanagement

class User {

    transient springSecurityService
    String name
    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired


    transient def getBranch(){
        (authorities?.find {it instanceof BranchRole} as BranchRole)?.branch
    }
    transient def getBranchHead(){
        (authorities?.find {it instanceof BranchHeadRole} as BranchHeadRole)?.branchHead
    }
    transient def getBankRegion(){
        (authorities?.find {it instanceof BankRegionRole} as BankRegionRole)?.bankRegion
    }
    static constraints = {
        name()
        username blank: false, unique: true
        password blank: false
        branch()
        branchHead()
        bankRegion()
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        if(this.id)
            UserRole.findAllByUser(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
}
