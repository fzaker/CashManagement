package cashmanagement

class PermissionAmount_T {
    Branch branch
    Double permAmount
    Date permissionDate

    static constraints = {
        permissionDate(nullable: true)
    }
}
