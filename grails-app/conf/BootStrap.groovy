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
import grails.util.GrailsUtil
import cashmanagement.GLCode
import cashmanagement.GLGroup
import cashmanagement.GLTransaction
import cashmanagement.SystemParameters
import cashmanagement.Role

class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        if (GrailsUtil.environment == "development") {
//            def validationTagLib = grailsApplication.mainContext.getBean('org.codehaus.groovy.grails.plugins.web.taglib.ValidationTagLib')
//            Closure messageClosure = { attrs ->
//                //println "${attrs.code}"
//                def messagesFile = grailsApplication.config.cashmanagement.messages.file
//                messagesFile.append("${attrs.code}\n")
//
//                messageImpl(attrs)
//            }
//            messageClosure.setResolveStrategy(Closure.DELEGATE_ONLY)
//            messageClosure.setDelegate(validationTagLib)
//            validationTagLib.message = messageClosure
//
//            def lg = new LoanGroup(loanGroupCode: "01", loanGroupName: "تستی").save()
//            def lt = new LoanType(loanGroup: lg, loanTypeCode: "011", loanTypeName: "تست").save()
//            def br = new BankRegion(bankRegionCode: "01", bankRegionName: "منطقه 1").save()
//            def bh = new BranchHead(branchHeadCode: "011", branchHeadName: "سرپرستی 1", bankRegion: br).save()
//            def b = new Branch(branchCode: "0111", branchName: "شعبه 1", branchHead: bh).save()
//
//            def glmanabe = new GLGroup(glGroupCode: "02", glGroupName: "manabe").save()
//            def glmasaref = new GLGroup(glGroupCode: "03", glGroupName: "masaref").save()
//            def glCodemanabe = new GLCode(glCode: "1", glFlag: 1L, glGroup: glmanabe, branch: b)
//            def glCodemasaref = new GLCode(glCode: "1", glFlag: 1L, glGroup: glmasaref, branch: b)
//            glCodemanabe.validate()
//            glCodemanabe=glCodemanabe.save()
//            def cal = Calendar.getInstance()
//            cal.add(Calendar.DATE, -1)
//            cal.set(Calendar.MILLISECOND, 0)
//            cal.set(Calendar.SECOND, 0)
//            cal.set(Calendar.MINUTE, 0)
//            cal.set(Calendar.HOUR_OF_DAY, 0)
//            def date = cal.getTime()
//
//            def glT=new GLTransaction(glCode: glCodemanabe,glAmount: 1000,branch: b,tranDate: date).save()
//            def glT1=new GLTransaction(glCode: glCodemasaref,glAmount: 2000,branch: b,tranDate: date).save()
//
//            def branchRole = new BranchRole(branch: b, authority: "user").save()
//            def branchHeadRole = new BranchHeadRole(branchHead: bh, authority: "user").save()
//            def bankRegionRole = new BankRegionRole(bankRegion: br, authority: "user").save()
//
//            def bu = new User(name: "کاربر شعبه 1", username: "user1", password: "pass", enabled: true).save()
//            UserRole.create(bu, branchRole, true)
//
//            def bhu = new User(name: "کاربر اداره شعبه 1", username: "user2", password: "pass", enabled: true).save()
//            UserRole.create(bhu, branchHeadRole, true)
//
//            def bru = new User(name: "کاربر سرپرستی1", username: "user3", password: "pass", enabled: true).save()
//            UserRole.create(bru, bankRegionRole, true)
//
//            def sysParam=new SystemParameters(permitToward:0.65D,maxGrowth:1.0D,minGrowth:0.0D,permitReceivePercent:0.3D,permitReceiveDaysNum:10D).save()
//            def branchRole = new BranchRole(branch: b, authority: "user").save()
//            def branchHeadRole = new BranchHeadRole(branchHead: bh, authority: "user").save()
//            def bankRegionRole = new BankRegionRole(bankRegion: br, authority: "user").save()

        }
        def adminRole = Role.findByAuthority("user")?:new Role(authority: "user").save()
        def adminUser = User.findByUsername('admin') ?: new User(
                username: 'admin',
                password: 'admin',
                name: 'admin',
                enabled: true).save(failOnError: true)

        if (!adminUser.authorities.contains(adminRole)) {
            UserRole.create adminUser, adminRole
        }
    }

    def destroy = {
    }
}
