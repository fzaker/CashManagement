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
    boolean isAdmin
    boolean basicInformation
    Boolean tabsare = true
    Boolean ntabsare = true
    Boolean gharzolhasane = true


    transient def getBranch() {
        (authorities?.find { it.instanceOf(BranchRole) })?.branch
    }

    transient def getBranchHead() {
        (authorities?.find { it.instanceOf(BranchHeadRole) })?.branchHead
    }

    transient def getBankRegion() {
        (authorities?.find { it.instanceOf(BankRegionRole) })?.bankRegion
    }

    static hasMany = [authorities: Role]
    static constraints = {
        name()
        username blank: false, unique: true
        password blank: false
        branch()
        branchHead()
        bankRegion()
        isAdmin()
        basicInformation()
        tabsare(nullable: true, blank: true)
        ntabsare(nullable: true, blank: true)
        gharzolhasane(nullable: true, blank: true)
    }

    static mapping = {
        table 'UserAccount'
        authorities joinTable: [name: 'user_role', key: 'user_id', column: 'role_id']
        password column: '`password`'

    }
//
//    Set<Role> getAuthorities() {
//        if (this.id)
//            UserRole.findAllByUser(this).collect { it.role } as Set
//    }

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

    String toString() {
        name
    }
}
