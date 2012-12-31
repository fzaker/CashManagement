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

    def checkResourceAvailability(Branch branch, double amt) {
        def cal = Calendar.getInstance()
        cal.add(Calendar.DATE, -1)
        cal.set(Calendar.MILLISECOND, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        def date = cal.getTime()

        def manabeGLGroup = GLGroup.findByGlGroupCode("02")
        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
        def manabe = GLTransaction.findAllByGlCodeInListAndBranchAndTranDate(glManabe, branch, date).sum {it.glAmount * it.glCode.glFlag}

        def masarefGLGroup = GLGroup.findByGlGroupCode("03")
        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
        def masaref = GLTransaction.findAllByGlCodeInListAndBranchAndTranDate(glMasaref, branch, date).sum {it.glAmount * it.glCode.glFlag}


        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0

        def darsad = (masaref + amt + mojavezSadere) / manabe

        SystemParameters sysParam = SystemParameters.findAll().first()
        return (sysParam?.permitToward > darsad)

    }
}
