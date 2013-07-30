package cashmanagement

class PermissionAmount_GH {
    Branch branch
    Double permAmount
    Date permissionDate

    static constraints = {
        permissionDate(nullable: true)
    }
}
