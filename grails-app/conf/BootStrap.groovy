import cashmanagement.LoanGroup
import cashmanagement.BankRegion
import cashmanagement.BranchHead
import cashmanagement.Branch
import cashmanagement.User
import cashmanagement.BranchRole
import cashmanagement.BranchHeadRole
import cashmanagement.BankRegionRole
import cashmanagement.UserRole
import cashmanagement.LoanType

class BootStrap {

    def init = { servletContext ->

        def lg = new LoanGroup(loanGroupCode: "01", loanGroupName: "تستی").save()
        def lt=new LoanType(loanGroup: lg,loanTypeCode: "011",loanTypeName: "تست").save()
        def br = new BankRegion(bankRegionCode: "01", bankRegionName: "منطقه 1").save()
        def bh=new BranchHead(branchHeadCode: "011",branchHeadName: "سرپرستی 1",bankRegion: br).save()
        def b=new Branch(branchCode: "0111",branchName: "شعبه 1",branchHead: bh).save()

        def branchRole=new BranchRole(branch: b,authority: "user").save()
        def branchHeadRole=new BranchHeadRole(branchHead: bh,authority: "user").save()
        def bankRegionRole=new BankRegionRole(bankRegion: br,authority: "user").save()

        def bu=new User(name:"کاربر شعبه 1",username: "user1",password: "pass",enabled: true).save()
        UserRole.create(bu,branchRole,true)

        def bhu=new User(name:"کاربر اداره شعبه 1",username: "user2",password: "pass",enabled: true).save()
        UserRole.create(bhu,branchHeadRole,true)

        def bru=new User(name:"کاربر سرپرستی1",username: "user3",password: "pass",enabled: true).save()
        UserRole.create(bru,bankRegionRole,true)


    }
    def destroy = {
    }
}
