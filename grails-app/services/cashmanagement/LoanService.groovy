package cashmanagement

import fi.joensuu.joyds1.calendar.JalaliCalendar
import groovy.sql.Sql

class LoanService {
    def dataSource
    def sessionFactory

    def generateLoanId(Branch branch, LoanType loanType, Date date, String loanNo) {
        def cal = Calendar.getInstance()
        cal.setTime(date)
        def jc = new JalaliCalendar(cal)
        def d = String.format("%02d%02d%02d", jc.getYear() % 100, jc.getMonth(), jc.getDay())

        return "${branch.branchCode}-${loanType.loanGroup.loanGroupCode}-${d}-${loanNo}"
    }

    def checkResourceAvailabilityGH(Branch branch, double amt) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def jc = getCurrentDate(sysParam.today)
        def year = jc.year
        def month = jc.month
        jc.set(jc.year, jc.month, 1)
        def sumBranch = (LoanRequest_GH.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_GH.Confirm).sum {it.loanAmount}) ?: 0
        def sumBranchThisMonth = (LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateGreaterThanEquals(branch, LoanRequest_GH.Confirm, jc.toJavaUtilGregorianCalendar().time).sum {it.loanAmount}) ?: 0

        def permAmount = (PermissionAmount_GH.findByBranchAndYear(branch, year)?.permAmount) ?: 0

        def usedAmountPrevMonths = LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateLessThan(branch, LoanRequest_GH.Confirm, jc.toJavaUtilGregorianCalendar().time).sum {it.loanAmount} ?: 0
        def permitAmountPrevMonths = permAmount * (month - 1) * sysParam.ghMonthlyPercent - usedAmountPrevMonths


        if (permAmount < sumBranch + amt)
            return false
        if (sysParam.ghMonthlyPercent * permAmount + permitAmountPrevMonths < sumBranchThisMonth + amt)
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
//        def date = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
//        date.add(Calendar.DATE, -1)

        double manabeAmt = GLTransaction.findAllByGlCodeInListAndTranDate(manabeGLCodes, sysParam.today).sum {it.glAmount * it.glCode.glFlag} ?: 1
        double masarefAmt = GLTransaction.findAllByGlCodeInListAndTranDate(masarefGLCodes, sysParam.today).sum {it.glAmount * it.glCode.glFlag} ?: 0
        return masarefAmt / manabeAmt
    }

    def checkResourceAvailabilityT(Branch branch, double amt) {
        def sysParam = SystemParameters.findAll().first()
        def year = getCurrentDate(sysParam.today).year
        def sumBranch = (LoanRequest_T.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_T.Confirm).sum {it.loanAmount}) ?: 0
        def permAmount = (PermissionAmount_T.findByBranchAndYear(branch, year)?.permAmount) ?: 0
        return permAmount >= (sumBranch + amt)
    }

    def checkResourceAvailability(Branch branch, double amt) {
//        SystemParameters sysParam = SystemParameters.findAll().first()
//
//        if (checkAvailable_numofdays_curMonth(branch, amt) < sysParam.permitToward) {
//            if (checkAvailable_numofdays_curMonth(branch, amt) - checkAvailable_numofdays_oldMonth(branch) <= sysParam.maxGrowth)
//                return true
//            else
//                return false ///inja bayad kollan cancel shavad ... ,, na pending
//        }
//        else {
//            if (checkAvailable_numofdays_oldMonth(branch) - checkAvailable_numofdays_curMonth(branch, amt) >= sysParam.minGrowth)
//                return true
//            else
//                return false
//        }
        def avail = getAvailable(branch)
        return amt <= Math.ceil(avail)
    }

    def checkAvailable_numofdays_curMonth(Branch branch, Double amt) {
        def manabe = getManabeGT(branch)
        def masaref = getMasarefGT(branch)
        def mojavezSadere = getMojavezSadereGT(branch)
        def sumDebit = getEtebarDaryaftiGT(branch)
        def sumCredit = getEtebarEtayeeGT(branch)
        def cur_toward = (masaref + mojavezSadere - sumDebit + sumCredit + (amt ?: 0)) / ((manabe) ?: 1)

        return cur_toward
    }

    def checkAvailable_numofdays_curMonth(BranchHead branchHead, Double amt) {
        def manabe = getManabeGT(branchHead)
        def masaref = getMasarefGT(branchHead)
        def mojavezSadere = getMojavezSadereGT(branchHead)
        def sumDebit = getEtebarDaryaftiGT(branchHead)
        def sumCredit = getEtebarEtayeeGT(branchHead)
        def cur_toward = (masaref + mojavezSadere - sumDebit + sumCredit + (amt ?: 0)) / ((manabe) ?: 1)

        return cur_toward
    }

    def checkAvailable_numofdays_oldMonth(Branch branch) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        cal.add(Calendar.MONTH, -1)
        def pmjcal = new JalaliCalendar(cal)
        def toDate = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day
        def toDateD = cal.getTime()
        cal.add(Calendar.DATE, -1 * sysParam.numofDays)
        def tpmjcal = new JalaliCalendar(cal)
        def fromDate = tpmjcal.year * 10000 + tpmjcal.month * 100 + tpmjcal.day
        def fromDateD = cal.getTime()

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
//        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
//        def manabeTrans = GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glManabe, branch, fromDate, toDate)
//        def manabeDays = manabeTrans.collect {it.tranDate}.unique()
//        def manabe = (((manabeTrans.sum {it.glAmount * it.glCode.glFlag }) ?: 0) /
//                ((manabeDays.size()) ?: 1)) ?: 1
//
//        def masarefGLGroup = sysParam.gheyreTabserei.masaref
//        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
//        def masaref = GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glMasaref, branch, fromDate, toDate).groupBy {it.glCode}.collect {it.value.sort {it.tranDate}.reverse().find {true}}.sum {it?.glAmount * it?.glCode?.glFlag} ?: 0
        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.firstRow("""SELECT     ROUND(AVG(sumAmt), 0) AS avgAmt
FROM         (SELECT     SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS sumAmt
                       FROM          dbo.gltransaction JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
			where  (gl_group_id =:glgroup)
				and (branch_id=:branch)
				and (tran_date <= :todate) AND (tran_date >= :fromdate)
                       GROUP BY dbo.gltransaction.tran_date) AS derivedtbl_1""", [fromdate: fromDate, todate: toDate, branch: branch.id, glgroup: manabeGLGroup.id]);
        def manabe = x.avgAmt

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
        sql = new Sql(sessionFactory.currentSession.connection())
        x = sql.firstRow("""select SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS amt
                       FROM          dbo.gltransaction INNER JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
  where branch_id=:branch
  and tran_date=:today
  and gl_group_id=:glgroup""", [today: toDate, branch: branch.id, glgroup: masarefGLGroup.id]);

        //mande akharin rooz
        def masaref = x.amt

        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatusAndRequestDateLessThanEquals(branch, LoanRequest_NT.Confirm, toDateD).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranchAndDateLessThanEquals(branch, toDateD)
        def sumDebit = (barrows.sum {it.debit ?: 0}) ?: 0
        def sumCredit = (barrows.sum {it.credit ?: 0}) ?: 0


        def old_toward = (masaref + mojavezSadere - sumDebit + sumCredit) / (manabe)

        return old_toward
    }

    def checkAvailable_numofdays_oldMonth(BranchHead branchHead) {
        def branches = Branch.findAllByBranchHead(branchHead)
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        cal.add(Calendar.MONTH, -1)
        def pmjcal = new JalaliCalendar(cal)
        def toDate = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day
        def toDateD = cal.getTime()
        cal.add(Calendar.DATE, -1 * sysParam.numofDays)
        def tpmjcal = new JalaliCalendar(cal)
        def fromDate = tpmjcal.year * 10000 + tpmjcal.month * 100 + tpmjcal.day
        def fromDateD = cal.getTime()

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
//        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
//        def manabeTrans = GLTransaction.findAllByGlCodeInListAndBranchInListAndTranDateBetween(glManabe, branches, fromDate, toDate)
//        def manabeDays = manabeTrans.collect {it.tranDate}.unique()
//        def manabe = (((manabeTrans.sum {it.glAmount * it.glCode.glFlag }) ?: 0) /
//                ((manabeDays.size()) ?: 1)) ?: 1
        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.firstRow("""SELECT     ROUND(AVG(sumAmt), 0) AS avgAmt
FROM         (SELECT     SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS sumAmt
                       FROM          dbo.gltransaction JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
                                              JOIN dbo.branch on branch.id = branch_id
			where  (gl_group_id =:glgroup)
				and (branch_head_id=:branchhead)
				and (tran_date <= :todate) AND (tran_date >= :fromdate)
                       GROUP BY dbo.gltransaction.tran_date) AS derivedtbl_1""", [fromdate: fromDate, todate: toDate, branchhead: branchHead.id, glgroup: manabeGLGroup.id]);
        def manabe = x.avgAmt

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
//        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
//        def masaref = GLTransaction.findAllByGlCodeInListAndBranchInListAndTranDateBetween(glMasaref, branches, fromDate, toDate)
//                .groupBy {it.branch}
//                .collect {
//            it.value.groupBy {it.glCode}
//                    .collect {it.value.sort {it.tranDate}.reverse().find {true}}
//                    .sum {it?.glAmount * it?.glCode?.glFlag} ?: 0
//        }.sum()
        sql = new Sql(sessionFactory.currentSession.connection())
        x = sql.firstRow("""select SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS amt
                       FROM          dbo.gltransaction INNER JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
                                              INNER JOIN branch on branch.id=branch_id
  where branch_head_id=:branchhead
  and tran_date=:today
  and gl_group_id=:glgroup""", [today: toDate, branchhead: branchHead.id, glgroup: masarefGLGroup.id]);

        //mande akharin rooz
        def masaref = x.amt

        def mojavezSadere = (LoanRequest_NT.findAllByBranchInListAndLoanRequestStatusAndRequestDateLessThanEquals(branches, LoanRequest_NT.Confirm, toDateD).sum {it.loanAmount}) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranchInListAndDateLessThanEquals(branches, toDateD)
        def sumDebit = (barrows.sum {it.debit ?: 0}) ?: 0
        def sumCredit = (barrows.sum {it.credit ?: 0}) ?: 0


        def old_toward = (masaref + mojavezSadere - sumDebit + sumCredit) / (manabe)

        return old_toward
    }

    def getCurrentDate(dateInt) {
        int year = "${dateInt}".substring(0, 4) as Integer
        int month = "${dateInt}".substring(4, 6) as Integer
        int date = "${dateInt}".substring(6) as Integer
        def jalaliCalendar = new JalaliCalendar(year, month, date)
        jalaliCalendar
    }

    def getManabeGT(Branch branch) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        def pmjcalt = new JalaliCalendar(cal)
        def today = pmjcalt.year * 10000 + pmjcalt.month * 100 + pmjcalt.day
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
//        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
//        def glTrans = GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glManabe, branch, tendaysagno, today)
//        def manabeDays = glTrans.collect {it.tranDate}.unique()
//        def manabe = ((glTrans.sum {it.glAmount * it.glCode.glFlag }) ?: 0) /
//                ((manabeDays.size()) ?: 1)
        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.firstRow("""SELECT     ROUND(AVG(sumAmt), 0) AS avgAmt
FROM         (SELECT     SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS sumAmt
                       FROM          dbo.gltransaction JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
			where  (gl_group_id =:glgroup)
				and (branch_id=:branch)
				and (tran_date <= :todate) AND (tran_date >= :fromdate)
                       GROUP BY dbo.gltransaction.tran_date) AS derivedtbl_1""", [fromdate: tendaysagno, todate: today, branch: branch.id, glgroup: manabeGLGroup.id]);

        //miangin e 10 rooz e gozashte
        return x.avgAmt
    }

    def getManabeGT(BranchHead branchHead) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        def pmjcalt = new JalaliCalendar(cal)
        def today = pmjcalt.year * 10000 + pmjcalt.month * 100 + pmjcalt.day
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        def manabeGLGroup = sysParam.gheyreTabserei.manabe
        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.firstRow("""SELECT     ROUND(AVG(sumAmt), 0) AS avgAmt
FROM         (SELECT     SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS sumAmt
                       FROM          dbo.gltransaction JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
                                              JOIN dbo.branch on branch.id = branch_id
			where  (gl_group_id =:glgroup)
				and (branch_head_id=:branchhead)
				and (tran_date <= :todate) AND (tran_date >= :fromdate)
                       GROUP BY dbo.gltransaction.tran_date) AS derivedtbl_1""", [fromdate: tendaysagno, todate: today, branchhead: branchHead.id, glgroup: manabeGLGroup.id]);

//        def glManabe = GLCode.findAllByGlGroup(manabeGLGroup)
//        def glTrans = GLTransaction.findAllByGlCodeInListAndBranchInListAndTranDateBetween(glManabe, Branch.findAllByBranchHead(branchHead), tendaysagno, today)
//        def manabeDays = glTrans.collect {it.tranDate}.unique()
//        def manabe = ((glTrans.sum {it.glAmount * it.glCode.glFlag }) ?: 0) /
//                ((manabeDays.size()) ?: 1)
        //miangin e 10 rooz e gozashte
//        return manabe
        return x.avgAmt
    }

    def getMasarefGT(Branch branch) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        def pmjcalt = new JalaliCalendar(cal)
        def today = pmjcalt.year * 10000 + pmjcalt.month * 100 + pmjcalt.day
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
//        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
//        def masaref = GLTransaction.findAllByGlCodeInListAndBranchAndTranDateBetween(glMasaref, branch, tendaysagno, today).groupBy {it.glCode}.collect {it.value.sort {it.tranDate}.reverse().find {true}}.sum {it?.glAmount * it?.glCode?.glFlag} ?: 0

        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.firstRow("""select SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS amt
                       FROM          dbo.gltransaction INNER JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
  where branch_id=:branch
  and tran_date=:today
  and gl_group_id=:glgroup""", [today: today, branch: branch.id, glgroup: masarefGLGroup.id]);

        //mande akharin rooz
        return x.amt
    }

    def getMasarefGT(BranchHead branchHead) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
        def pmjcalt = new JalaliCalendar(cal)
        def today = pmjcalt.year * 10000 + pmjcalt.month * 100 + pmjcalt.day
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
//        def glMasaref = GLCode.findAllByGlGroup(masarefGLGroup)
//        def masaref = GLTransaction.findAllByGlCodeInListAndBranchInListAndTranDateBetween(glMasaref, Branch.findAllByBranchHead(branchHead), tendaysagno, today)
//                .groupBy {it.branch}
//                .collect {
//            it.value.groupBy {it.glCode}.collect {it.value.sort {it.tranDate}.reverse().find {true}}
//                    .sum {it?.glAmount * it?.glCode?.glFlag} ?: 0
//        }.sum()
//        //mande akharin rooz
//        return masaref

        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.firstRow("""select SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS amt
                       FROM          dbo.gltransaction INNER JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
                                              INNER JOIN branch on branch.id=branch_id
  where branch_head_id=:branchhead
  and tran_date=:today
  and gl_group_id=:glgroup""", [today: today, branchhead: branchHead.id, glgroup: masarefGLGroup.id]);

        //mande akharin rooz
        return x.amt
    }

    def getMojavezSadereGT(Branch branch) {
        def res = LoanRequest_NT.executeQuery("""select sum(loanAmount) from LoanRequest_NT where branch=:branch and loanRequestStatus=:status""",
                [branch: branch, status: LoanRequest_NT.Confirm]).first() ?: 0
        //return (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0
        return res
    }

    def getMojavezSadereGT(BranchHead branchHead) {
        def res = LoanRequest_NT.executeQuery("""select sum(loanAmount) from LoanRequest_NT where branch.branchHead=:branchhead and loanRequestStatus=:status""",
                [branchhead: branchHead, status: LoanRequest_NT.Confirm]).first() ?: 0
        return res;
//        return (LoanRequest_NT.findAllByBranchInListAndLoanRequestStatus(Branch.findAllByBranchHead(branchHead), LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0
    }

    def getEtebarEtayeeGT(Branch branch) {
        def res = LoanRequestNTBarrow.executeQuery("""select sum(credit) from LoanRequestNTBarrow where credit is not null and branch=:branch""",
                [branch: branch]).first() ?: 0
//        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
//        return (barrows.sum {it.credit ?: 0}) ?: 0
        return res
    }

    def getEtebarEtayeeGT(BranchHead branchHead) {
//        def barrows = LoanRequestNTBarrow.findAllByBranchInList(Branch.findAllByBranchHead(branchHead))
//        return (barrows.sum {it.credit ?: 0}) ?: 0
        def res = LoanRequestNTBarrow.executeQuery("""select sum(credit) from LoanRequestNTBarrow where credit is not null and branch.branchHead=:branchhead""",
                [branchhead: branchHead]).first() ?: 0
        return res
    }

    def getEtebarDaryaftiGT(Branch branch) {

        def res = LoanRequestNTBarrow.executeQuery("""select sum(debit) from LoanRequestNTBarrow where debit is not null and branch=:branch""",
                [branch: branch]).first() ?: 0
        return res
//        def barrows = LoanRequestNTBarrow.findAllByBranch(branch)
//        return (barrows.sum {it.debit ?: 0}) ?: 0
    }

    def getEtebarDaryaftiGT(BranchHead branchHead) {
//        def barrows = LoanRequestNTBarrow.findAllByBranchInList(Branch.findAllByBranchHead(branchHead))
//        return (barrows.sum {it.debit ?: 0}) ?: 0
        def res = LoanRequestNTBarrow.executeQuery("""select sum(debit) from LoanRequestNTBarrow where debit is not null and branch.branchHead=:branchhead""",
                [branchhead: branchHead]).first() ?: 0
        return res
    }

    def getPermitTowardGT(Branch branch) {
        def sysParam = getSystemParam(branch)
        def oldMonth = checkAvailable_numofdays_oldMonth(branch)
        if (oldMonth >= sysParam.permitToward + sysParam.minGrowth)
            return oldMonth - sysParam.minGrowth
        else
            return Math.max(0, Math.min(sysParam.permitToward, sysParam.maxGrowth + oldMonth))
    }

    def getPermitTowardGT(BranchHead branchHead) {

        def bhparam = getSystemParam(branchHead)
        def oldMonth = checkAvailable_numofdays_oldMonth(branchHead)
        if (oldMonth >= bhparam.permitToward + bhparam.minGrowth)
            return oldMonth - bhparam.minGrowth
        else
            return Math.max(0, Math.min(bhparam.permitToward, bhparam.maxGrowth + oldMonth))
    }

    def getAvailable(Branch branch) {
        def manabe = getManabeGT(branch)
        def masaref = getMasarefGT(branch)
        def mojavezSadere = getMojavezSadereGT(branch)
        def sumDebit = getEtebarDaryaftiGT(branch)
        def sumCredit = getEtebarEtayeeGT(branch)
        def permitToward = getPermitTowardGT(branch)

        def avail = Math.max((permitToward * manabe) - (masaref), 0) - (mojavezSadere - sumDebit + sumCredit)
        return Math.max(avail, 0)
    }

    def getAvailable(BranchHead branchHead) {
        def manabe = getManabeGT(branchHead)
        def masaref = getMasarefGT(branchHead)
        def mojavezSadere = getMojavezSadereGT(branchHead)
        def sumDebit = getEtebarDaryaftiGT(branchHead)
        def sumCredit = getEtebarEtayeeGT(branchHead)
        def permitToward = getPermitTowardGT(branchHead)

        def avail = Math.max((permitToward * manabe) - (masaref), 0) - (mojavezSadere - sumDebit + sumCredit)
        return Math.max(avail, 0)
    }

    def getVosooli(BranchHead bh) {

        SystemParameters sysParam = SystemParameters.findAll().first()
        def day_num = -1 * sysParam.permitReceiveDaysNum as Integer

        def cal = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()

        cal.add(Calendar.DATE, day_num)

        def pmjcal = new JalaliCalendar(cal)
        def date = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        //def bh=BranchHead.findByBranches(branch)

        def bch = Branch.findAllByBranchHead(bh)

        def vosooliGlGroup = sysParam.tabserei.manabe
        def VosooliGlCode = GLCode.findAllByGlGroup(vosooliGlGroup)
        def Vosooli = (GLTransaction.findAllByGlCodeInListAndBranchInListAndTranDateGreaterThanEquals(VosooliGlCode, bch, date).sum {it.glAmount * it.glCode.glFlag}) ?: 0

        def vosool = Vosooli * sysParam.permitReceivePercent

        return vosool
    }

    def getSystemParam(BranchHead branchHead) {
        SystemParameters sysParam = SystemParameters.findAll().first()
        BranchHeadNTParams.findByBranchHead(branchHead) ?: new BranchHeadNTParams(branchHead: branchHead,
                permitToward: sysParam.permitToward,
                maxGrowth: sysParam.maxGrowth, minGrowth: sysParam.minGrowth).save()
    }

    def getSystemParam(Branch branch) {
        def sysParam = getSystemParam(branch.branchHead)
        BranchNTParams.findByBranch(branch) ?: new BranchNTParams(branch: branch,
                permitToward: sysParam.permitToward,
                maxGrowth: sysParam.maxGrowth, minGrowth: sysParam.minGrowth).save()
    }

}
