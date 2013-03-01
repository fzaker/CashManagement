package cashmanagement

import fi.joensuu.joyds1.calendar.JalaliCalendar

class LoanService {

    def generateLoanId(Branch branch, LoanType loanType, Date date, String loanNo) {
        def cal = Calendar.getInstance()
        cal.setTime(date)
        def jc = new JalaliCalendar(cal)
        def d = String.format("%04d%02d%02d", jc.getYear(), jc.getMonth(), jc.getDay())

        return "${branch.branchCode}-${loanType.loanGroup.loanGroupCode}-${d}-${loanNo}"
    }

    def checkResourceAvailabilityGH(Branch branch, double amt) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def jc = new JalaliCalendar()
        def year = jc.year
        jc.set(jc.year, jc.month, 1)
        def sumBranch = (LoanRequest_GH.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_GH.Confirm).sum {it.loanAmount}) ?: 0
        def sumBranchThisMonth = (LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateGreaterThanEquals(branch, LoanRequest_GH.Confirm, jc.toJavaUtilGregorianCalendar().time).sum {it.loanAmount}) ?: 0

        def permAmount = (PermissionAmount_GH.findByBranchAndYear(branch, year)?.permAmount) ?: 0
        if (permAmount < sumBranch + amt)
            return false
        if (sysParam.ghMonthlyPercent * permAmount < sumBranchThisMonth + amt)
            return false
        if (masarefBeManabeGharzolhasane() > sysParam.ghCentralBankPercent)
            return false
        return true
    }

    def masarefBeManabeGharzolhasane() {
        SystemParameters sysParam = SystemParameters.findAll().first()
        def gharzolhasane = sysParam.gharzolhasane
        def manabe = gharzolhasane.manabe
        def masaref = gharzolhasane.masaref
        def manabeGLCodes = GLCode.findAllByGlGroup(manabe)
        def masarefGLCodes = GLCode.findAllByGlGroup(masaref)
        def date = Calendar.getInstance()
        date.add(Calendar.DATE, -1)
        date.set(Calendar.HOUR_OF_DAY, 0)
        date.set(Calendar.MINUTE, 0)
        date.set(Calendar.SECOND, 0)
        date.set(Calendar.MILLISECOND, 0)
        double manabeAmt = GLTransaction.findAllByGlCodeInListAndTranDate(manabeGLCodes, date.time).sum {it.glAmount} ?: 1
        double masarefAmt = GLTransaction.findAllByGlCodeInListAndTranDate(masarefGLCodes, date.time).sum {it.glAmount} ?: 0
        return masarefAmt / manabeAmt
    }

    def checkResourceAvailabilityT(Branch branch, double amt) {
        def year = new JalaliCalendar().year
        def sumBranch = (LoanRequest_T.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_T.Confirm).sum {it.loanAmount}) ?: 0
        def permAmount = (PermissionAmount_T.findByBranchAndYear(branch, year)?.permAmount) ?: 0
        return permAmount >= (sumBranch + amt)
    }

    def checkResourceAvailability(Branch branch, double amt) {
        SystemParameters sysParam = SystemParameters.findAll().first()
        // def avail=getAvailable(branch)
        // return amt <= avail
        if (checkAvailable_numofdays_curMonth(branch) < sysParam.permitToward) {
            if (checkAvailable_numofdays_curMonth(branch) - checkAvailable_numofdays_oldMonth(branch) <= sysParam.maxGrowth)
                return true
            else
                return false ///inja bayad kollan cancel shavad ... ,, na pending
        }
        else {
            if (checkAvailable_numofdays_curMonth(branch) - checkAvailable_numofdays_oldMonth(branch) <= sysParam.minGrowth)
                return true
            else
                return false
        }

    }

    def checkAvailable_numofdays_curMonth(Branch branch) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, sysParam.numofDays * -1)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def date = cal.getTime()

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = ((GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glManabe, branch, date).sum {it.glAmount }) ?: 0) / ((GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glManabe, branch, date).count {it.glAmount }) ?: 1)

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glMasaref, branch, date).groupBy {it.glCode}.collect {it.value.sort {it.tranDate}.reverse().find {true}?.glAmount}.sum() ?: 0

        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
        def sumDebit = (barrows.sum {it.debit ?: 0}) ?: 0
        def sumCredit = (barrows.sum {it.credit ?: 0}) ?: 0


        def cur_toward = (masaref + mojavezSadere - sumDebit + sumCredit) / ((manabe) ?: 1)

        return cur_toward
    }

    def checkAvailable_numofdays_oldMonth(Branch branch) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = Calendar.getInstance()
        cal.add(Calendar.MONTH, -1)
        def toDate = cal.getTime()
        cal.add(Calendar.DATE, -1 * sysParam.numofDays)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def fromDate = cal.getTime()

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = (((GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glManabe, branch, fromDate, toDate).sum {it.glAmount }) ?: 0) /
                ((GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glManabe, branch, fromDate, toDate).count {it.glAmount }) ?: 1)) ?: 1

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glMasaref, branch, fromDate, toDate).groupBy {it.glCode}.collect {it.value.sort {it.tranDate}.reverse().find {true}?.glAmount}.sum() ?: 0

        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
        def sumDebit = (barrows.sum {it.debit ?: 0}) ?: 0
        def sumCredit = (barrows.sum {it.credit ?: 0}) ?: 0


        def old_toward = (masaref + mojavezSadere - sumDebit + sumCredit) / (manabe)

        return old_toward
    }

    def getAvailable(Branch branch) {

        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, -1 * sysParam.numofDays)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def date = cal.getTime()

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glManabe, branch, date).sum {it.glAmount * it.glCode.glFlag}) ?: 0

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = (GLTransaction.findAllByGlCodeInListAndBranchAndTranDateGreaterThan(glMasaref, branch, date).sum {it.glAmount * it.glCode.glFlag}) ?: 0


        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
        def sumDebit = (barrows.sum {it.debit ?: 0}) ?: 0
        def sumCredit = (barrows.sum {it.credit ?: 0}) ?: 0



        def avail = (sysParam.permitToward * manabe) - (masaref + mojavezSadere - sumDebit + sumCredit)
        return avail
    }

    def getVosooli(BranchHead bh) {

        SystemParameters sysParam = SystemParameters.findAll().first()
        def day_num = -1 * sysParam.permitReceiveDaysNum as Integer

        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, day_num)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def date = cal.getTime()

        //def bh=BranchHead.findByBranches(branch)

        def bch = Branch.findAllByBranchHead(bh)

        def vosooliGlGroup = sysParam.tabserei.manabe
        def VosooliGlCode = GLCode.findAllByGlGroup(vosooliGlGroup)
        def Vosooli = (GLTransaction.findAllByGlCodeInListAndBranchInListAndTranDateGreaterThan(VosooliGlCode, bch, date).sum {it.glAmount}) ?: 0

        def vosool = Vosooli * sysParam.permitReceivePercent

        return vosool
    }
}
