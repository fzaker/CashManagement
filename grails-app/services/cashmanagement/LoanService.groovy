package cashmanagement

import fi.joensuu.joyds1.calendar.JalaliCalendar

class LoanService {

    def generateLoanId(Branch branch, LoanType loanType, Date date, String loanNo) {
        def cal = Calendar.getInstance()
        cal.setTime(date)
        def jc = new JalaliCalendar(cal)
        def d = String.format("%04d%02d%02d", jc.getYear(), jc.getMonth(), jc.getDay())

        return "${branch.branchCode}-${loanType.loanTypeCode}-${d}-${loanNo}"
    }
    def checkResourceAvailabilityGH(Branch branch, double amt){
        def cal = Calendar.getInstance()
        cal.setTime(new Date())
        def jc = new JalaliCalendar(cal)
        def year=jc.year
        def sumBranch = (LoanRequest_GH.findAllByBranchAndLoanRequestStatus(branch,LoanRequest_GH.Confirm).sum{it.loanAmount})?:0
        def permAmount = (PermissionAmount_GH.findByBranchAndYear(branch,year)?.permAmount)?:0
        return permAmount>=(sumBranch+amt)
    }
    def checkResourceAvailabilityT(Branch branch, double amt){
        def cal = Calendar.getInstance()
        cal.setTime(new Date())
        def jc = new JalaliCalendar(cal)
        def year=jc.year
        def sumBranch = (LoanRequest_T.findAllByBranchAndLoanRequestStatus(branch,LoanRequest_T.Confirm).sum{it.loanAmount})?:0
        def permAmount = (PermissionAmount_T.findByBranchAndYear(branch,year)?.permAmount)?:0
        return permAmount>=(sumBranch+amt)
    }
    def checkResourceAvailability(Branch branch, double amt) {
        SystemParameters sysParam = SystemParameters.findAll().first()
       // def avail=getAvailable(branch)
       // return amt <= avail
        if(checkAvailable_numofdays_curMonth(branch)<sysParam.permitToward){
            if(checkAvailable_numofdays_curMonth(branch)-checkAvailable_numofdays_oldMonth(branch)<=sysParam.maxGrowth)
                return true
            else
                return false
        }
        else{
            if(checkAvailable_numofdays_curMonth(branch)-checkAvailable_numofdays_oldMonth(branch)<=sysParam.minGrowth)
                return true
            else
                return false
        }

    }
    def checkAvailable_numofdays_curMonth(Branch branch){
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, sysParam.numofDays)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def date = cal.getTime()

        def manabeGLGroup = GLGroup.findByGlGroupCode("02")
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glManabe, branch, date).sum{it.glAmount })?:0 / (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glManabe, branch, date).count{it.glAmount })?:1

        def masarefGLGroup = GLGroup.findByGlGroupCode("03")
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glMasaref, branch, date).sum {it.glAmount })?:0 / (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glMasaref, branch, date).count {it.glAmount })?:1

        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
        def sumDebit = (barrows.sum {it.debit ?: 0})?:0
        def sumCredit = (barrows.sum {it.credit ?: 0})?:0


        def cur_toward=(masaref+mojavezSadere-sumDebit+sumCredit)/ (manabe)

        return cur_toward
    }

    def checkAvailable_numofdays_oldMonth(Branch branch){
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, -1 * sysParam.numofDays)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)

        def date = cal.getTime()
        def date2=cal.add(Calendar.DATE,-1* (sysParam.numofDays+30))

        def manabeGLGroup = GLGroup.findByGlGroupCode("02")
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glManabe, branch, date,date2).sum{it.glAmount })?:0 / (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween (glManabe, branch, date,date2).count{it.glAmount })?:1

        def masarefGLGroup = GLGroup.findByGlGroupCode("03")
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glMasaref, branch, date,date2).sum {it.glAmount })?:0 / (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glMasaref, branch, date,date2).count {it.glAmount })?:1

        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
        def sumDebit = (barrows.sum {it.debit ?: 0})?:0
        def sumCredit = (barrows.sum {it.credit ?: 0})?:0


        def old_toward=(masaref+mojavezSadere-sumDebit+sumCredit)/ (manabe)

        return old_toward
    }

    def getAvailable(Branch branch){

        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, -1)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def date = cal.getTime()

        def manabeGLGroup = GLGroup.findByGlGroupCode("02")
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDate(glManabe, branch, date).sum {it.glAmount * it.glCode.glFlag})?:0

        def masarefGLGroup = GLGroup.findByGlGroupCode("03")
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDate(glMasaref, branch, date).sum {it.glAmount * it.glCode.glFlag})?:0


        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
        def sumDebit = (barrows.sum {it.debit ?: 0})?:0
        def sumCredit = (barrows.sum {it.credit ?: 0})?:0

        SystemParameters sysParam = SystemParameters.findAll().first()

        def avail=(sysParam.permitToward * manabe)-(masaref+mojavezSadere-sumDebit+sumCredit)
        return avail
    }
}
