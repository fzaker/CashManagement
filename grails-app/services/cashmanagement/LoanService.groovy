package cashmanagement

import fi.joensuu.joyds1.calendar.JalaliCalendar
import groovy.sql.Sql

class LoanService {
    def dataSource
    def sessionFactory

    private def checkMelliCode(String melliCode,String customerType) {


        try {
            if(customerType=='corp')
                return checkCorpCode(melliCode)
            if(customerType=='frgn')
                return melliCode.length()==13
            if (!melliCode || melliCode.length() != 10)
                return false;
            def checkDigit = 0
            def orig = 0
            melliCode.eachWithIndex { String entry, int i ->
                if (i < 9)
                    checkDigit += (entry as int) * (10 - i)
                else
                    orig = entry as int
            }
            checkDigit = checkDigit % 11
            if (checkDigit < 2)
                return orig == checkDigit
            else
                return orig == (11 - checkDigit)
        } catch (x) {
            return false
        }
    }

    def checkCorpCode(String NationalCode){
        if (NationalCode.length() == 11)
        {
            //خواندن عدد 11 رقمی
            def FirstDigit = (NationalCode[0]as int);
            def SecoundDigit = (NationalCode[1]as int);
            def thirdDigit = (NationalCode[2]as int);
            def FourthDigit = (NationalCode[3]as int);
            def FivthDigit = (NationalCode[4]as int);
            def SixthDigit = (NationalCode[5]as int);
            def SeventhDigit = (NationalCode[6]as int);
            def eighthDigit = (NationalCode[7]as int);
            def NinethDigit = (NationalCode[8]as int);
            def tenthDigit = (NationalCode[9]as int);
            def EleventhDigit = (NationalCode[10].toString());
            //تجمیع رقم دهم با 10 رقم اول
            FirstDigit = FirstDigit + tenthDigit;
            SecoundDigit = SecoundDigit + tenthDigit;
            thirdDigit = thirdDigit + tenthDigit;
            FourthDigit = FourthDigit + tenthDigit;
            FivthDigit = FivthDigit + tenthDigit;
            SixthDigit = SixthDigit + tenthDigit;
            SeventhDigit = SeventhDigit + tenthDigit;
            eighthDigit = eighthDigit + tenthDigit;
            NinethDigit = NinethDigit + tenthDigit;
            tenthDigit = tenthDigit + tenthDigit;
            //جمع عدد 2 به ارقام حاصل از مرحله قبل
            FirstDigit += 2;
            SecoundDigit += 2;
            thirdDigit += 2;
            FourthDigit += 2;
            FivthDigit += 2;
            SixthDigit += 2;
            SeventhDigit += 2;
            eighthDigit += 2;
            NinethDigit += 2;
            tenthDigit += 2;
            //ارقام را در ضرایب تعیین شده ضرب می کنیم
            FirstDigit *= 29;
            SecoundDigit *= 27;
            thirdDigit *= 23;
            FourthDigit *= 19;
            FivthDigit *= 17;
            SixthDigit *= 29;
            SeventhDigit *= 27;
            eighthDigit *= 23;
            NinethDigit *= 19;
            tenthDigit *= 17;
            //جمع 10 رقم اول
            def SumTenDigits = FirstDigit + SecoundDigit + thirdDigit +
                    FourthDigit + FivthDigit + SixthDigit +
                    SeventhDigit + eighthDigit + NinethDigit +
                    tenthDigit;
            //باقیمانده مرحله قبل به عدد 11
            def Remain = SumTenDigits %11
            if (Remain.toString().length() == 2)
            {
                //اگر 2 رقمی است دهگانش باید با رقم یازدهم یکی باشد
                ////////////////////////////////////////////////////////
                /////////////باید یکان چک شود ////////////////////////
                //////////////به نظر می رسد الگوریتم ایراد دارد////
                //////////////////////////////////////////////////////
                String test = Remain.toString()[1].toString();
                if ((test) == EleventhDigit)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                //اگر 1 رقمی است خودش باید با رقم یازدهم برابر باشد
                if (Remain.toString() == EleventhDigit)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

    }
    
    def generateLoanId(Branch branch, LoanType loanType, Date date, String loanNo) {
        def cal = Calendar.getInstance()
        cal.setTime(date)
        def jc = new JalaliCalendar(cal)
        def d = String.format("%02d%02d%02d", jc.getYear() % 100, jc.getMonth(), jc.getDay())

        return "${branch.branchCode}-${loanType.loanGroup.loanGroupCode}-${d}-${loanNo}"
    }

    def checkResourceAvailabilityGHOld(Branch branch, double amt) {
        SystemParameters sysParam = SystemParameters.findAll().first()

//        def jc = getCurrentDate(sysParam.today)
//        def year = jc.year
//        def month = jc.month
//        jc.set(jc.year, jc.month, 1)
//        def sumBranch = (LoanRequest_GH.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_GH.Confirm).sum {it.loanAmount}) ?: 0
//        def sumBranchThisMonth = (LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateGreaterThanEquals(branch, LoanRequest_GH.Confirm, jc.toJavaUtilGregorianCalendar().time).sum {it.loanAmount}) ?: 0
//
//        def permAmount = (PermissionAmount_GH.findByBranchAndYear(branch, year)?.permAmount) ?: 0
//
//        def usedAmountPrevMonths = LoanRequest_GH.findAllByBranchAndLoanRequestStatusAndRequestDateLessThan(branch, LoanRequest_GH.Confirm, jc.toJavaUtilGregorianCalendar().time).sum {it.loanAmount} ?: 0
//        def permitAmountPrevMonths = permAmount * (month - 1) * sysParam.ghMonthlyPercent - usedAmountPrevMonths

//        if (permAmount < sumBranch + amt)
//            return false
//        if (sysParam.ghMonthlyPercent * permAmount + permitAmountPrevMonths < sumBranchThisMonth + amt)
//            return false
        if (masarefBeManabeGharzolhasane(amt) > sysParam.ghCentralBankPercent)
            return false
        return true
    }

    def checkResourceAvailabilityGH(Branch branch, double amt) {
        def sumBranch = (LoanRequest_GH.findAllByBranchAndLoanRequestStatusInList(branch, [LoanRequest_GH.Confirm, LoanRequest_GH.Paid]).sum { it.loanAmount }) ?: 0
        def permAmount = PermissionAmount_GH.findAllByBranch(branch).sum { it.permAmount } ?: 0
        if (permAmount >= (sumBranch + amt)) {
            return checkResourceAvailabilityGHOld(branch, amt)
        }
        return false
    }

    def masarefBeManabeGharzolhasane(double amt) {
        SystemParameters sysParam = SystemParameters.findAll().first()
        def gharzolhasane = sysParam.gharzolhasane
        def manabe = gharzolhasane.manabe
        def masaref = gharzolhasane.masaref
        def manabeGLCodes = GLCode.findAllByGlGroup(manabe)
        def masarefGLCodes = GLCode.findAllByGlGroup(masaref)
//        def date = getCurrentDate(sysParam.today).toJavaUtilGregorianCalendar()
//        date.add(Calendar.DATE, -1)

        double manabeAmt = GLTransaction.findAllByGlCodeInListAndTranDate(manabeGLCodes, sysParam.today).sum { it.glAmount * it.glCode.glFlag } ?: 1
        double masarefAmt = GLTransaction.findAllByGlCodeInListAndTranDate(masarefGLCodes, sysParam.today).sum { it.glAmount * it.glCode.glFlag } ?: 0
        return (masarefAmt + amt) / manabeAmt
    }

    def checkResourceAvailabilityT(Branch branch, double amt) {
        def sysParam = SystemParameters.findAll().first()

        def sumBranch = (LoanRequest_T.findAllByBranchAndLoanRequestStatusInList(branch, [LoanRequest_T.Confirm, LoanRequest_T.Paid]).sum { it.loanAmount }) ?: 0
        def permAmount = PermissionAmount_T.findAllByBranch(branch).sum { it.permAmount } ?: 0
        return permAmount >= (sumBranch + amt)
    }

    def checkResourceAvailability(Branch branch, double amt, LoanRequest_NT req) {
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
        if (amt > Math.ceil(avail)) {
            def barrows = LoanRequestNTBarrow.findAllByRequestAndBranch(req, branch).collect { it.debit }.sum() ?: 0
            return amt - barrows <= 0
        }
        return true
    }

    def getNTReport(Date date) {
        def manabe = getManabeGT(date)
        def masaref = getMasarefGT(date)
        def mojavezSadere = getMojavezSadereGT(date)
        def sumD = getEtebarDaryaftiGT(date)
        def sumC = getEtebarEtayeeGT(date)
        def res = Branch.list().collect { br ->
            def m = manabe.get("${br.id}") ?: 0
            def ms = masaref.get("${br.id}") ?: 0
            def mj = mojavezSadere.get("${br.id}") ?: 0
            def d = sumD.get("${br.id}") ?: 0
            def c = sumC.get("${br.id}") ?: 0
            [id: br.id, name: br.toString(), code: br.branchCode as int,
                    manabe: m,
                    masaref: ms,
                    mojavezSadere: mj,
                    sumD: d,
                    sumC: c,
                    percent: (ms + mj - d + c) / ((m) ?: 1) * 100]
        }
        return res.sort { it.code }
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
        def manabe = x.avgAmt ?: 1

        def masarefGLGroup = sysParam.gheyreTabserei.masaref
        sql = new Sql(sessionFactory.currentSession.connection())
        x = sql.firstRow("""select SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS amt
                       FROM          dbo.gltransaction INNER JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
  where branch_id=:branch
  and tran_date=:today
  and gl_group_id=:glgroup""", [today: toDate, branch: branch.id, glgroup: masarefGLGroup.id]);

        //mande akharin rooz
        def masaref = x.amt ?: 0

        def mojavezSadere = (LoanRequest_NT.findAllByBranchAndLoanRequestStatusAndRequestDateLessThanEquals(branch, LoanRequest_NT.Confirm, toDateD).sum { it.loanAmount }) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranchAndDateLessThanEquals(branch, toDateD)
        def sumDebit = (barrows.sum { it.debit ?: 0 }) ?: 0
        def sumCredit = (barrows.sum { it.credit ?: 0 }) ?: 0
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

        def mojavezSadere = (LoanRequest_NT.findAllByBranchInListAndLoanRequestStatusAndRequestDateLessThanEquals(branches, LoanRequest_NT.Confirm, toDateD).sum { it.loanAmount }) ?: 0

        def barrows = LoanRequestNTBarrow.findAllByBranchInListAndDateLessThanEquals(branches, toDateD)
        def sumDebit = (barrows.sum { it.debit ?: 0 }) ?: 0
        def sumCredit = (barrows.sum { it.credit ?: 0 }) ?: 0


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

    def getManabeGT(Date date) {
        SystemParameters sysParam = SystemParameters.findAll().first()
        def cal = Calendar.getInstance()
        cal.setTime(date)
        def pmjcalt = new JalaliCalendar(cal)
        def today = pmjcalt.year * 10000 + pmjcalt.month * 100 + pmjcalt.day
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        def manabeGLGroup = sysParam.gheyreTabserei.manabe

        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.rows("""SELECT ROUND(AVG(sumAmt), 0) AS avgAmt,branch_id
FROM         (SELECT     SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS sumAmt ,branch_id
                       FROM          dbo.gltransaction JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
			where  (gl_group_id =:glgroup)
				and (tran_date <= :todate) AND (tran_date >= :fromdate)
                       GROUP BY dbo.gltransaction.tran_date,branch_id) AS derivedtbl_1 group by branch_id""", [fromdate: tendaysagno, todate: today, glgroup: manabeGLGroup.id]);

        return x.collectEntries { ["${it.branch_id}": it.avgAmt] }
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
        return x.avgAmt ?: 0
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
        return x.avgAmt ?: 0
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
        return x.amt ?: 0
    }

    def getMasarefGT(Date date) {
        SystemParameters sysParam = SystemParameters.findAll().first()

        def cal = Calendar.getInstance()
        cal.setTime(date)
        def pmjcalt = new JalaliCalendar(cal)
        def today = pmjcalt.year * 10000 + pmjcalt.month * 100 + pmjcalt.day
        cal.add(Calendar.DATE, -1 * sysParam.numofDays + 1)
        def pmjcal = new JalaliCalendar(cal)

        def tendaysagno = pmjcal.year * 10000 + pmjcal.month * 100 + pmjcal.day

        def masarefGLGroup = sysParam.gheyreTabserei.masaref

        def sql = new Sql(sessionFactory.currentSession.connection())
        def x = sql.rows("""select SUM(dbo.gltransaction.gl_amount * dbo.glcode.gl_flag) AS amt,branch_id
                       FROM          dbo.gltransaction INNER JOIN
                                              dbo.glcode ON dbo.gltransaction.gl_code_id = dbo.glcode.id
                          where  tran_date=:today
                          and gl_group_id=:glgroup group by branch_id""", [today: today, glgroup: masarefGLGroup.id]);

        return x.collectEntries { ["${it.branch_id}": it.amt ?: 0] }
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
        return x.amt ?: 0
    }

    def getMojavezSadereGT(Branch branch) {
        def res = LoanRequest_NT.executeQuery("""select sum(loanAmount) from LoanRequest_NT where branch=:branch and loanRequestStatus=:status""",
                [branch: branch, status: LoanRequest_NT.Confirm]).first() ?: 0
        //return (LoanRequest_NT.findAllByBranchAndLoanRequestStatus(branch, LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0
        return res
    }

    def getMojavezSadereGT(Date date) {
        def res = LoanRequest_NT.executeQuery("""select sum(loanAmount)as amt ,branch.id from LoanRequest_NT where (loanRequestStatus=:statusConfirm or (loanRequestStatus=:statusPaid and payDate>=:date)) and requestDate<=:date group by branch""",
                [statusConfirm: LoanRequest_NT.Confirm, statusPaid: LoanRequest_NT.Paid, date: date])
        return res.collectEntries { ["${it[1]}": it[0]] }
    }

    def getMojavezSadereGT(BranchHead branchHead) {
        def res = LoanRequest_NT.executeQuery("""select sum(loanAmount) from LoanRequest_NT where branch.branchHead=:branchhead and loanRequestStatus=:status""",
                [branchhead: branchHead, status: LoanRequest_NT.Confirm]).first() ?: 0
        return res;
//        return (LoanRequest_NT.findAllByBranchInListAndLoanRequestStatus(Branch.findAllByBranchHead(branchHead), LoanRequest_NT.Confirm).sum {it.loanAmount}) ?: 0
    }

    def getEtebarEtayeeGT(Date date) {
        def res = LoanRequestNTBarrow.executeQuery("""select sum(credit) as amt,branch.id from LoanRequestNTBarrow where credit is not null and date<=:date group by branch""",
                [date: date])
        return res.collectEntries { ["${it[1]}": it[0]] }
    }

    def getEtebarEtayeeGT(Branch branch) {
        def res = LoanRequestNTBarrow.executeQuery("""select sum(credit) from LoanRequestNTBarrow where credit is not null and branch=:branch""",
                [branch: branch]).first() ?: 0
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

    def getEtebarDaryaftiGT(Date date) {

        def res = LoanRequestNTBarrow.executeQuery("""select sum(debit),branch.id from LoanRequestNTBarrow where debit is not null and date<=:date group by branch""",
                [date: date])
        return res.collectEntries { ["${it[1]}": it[0]] }
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

    def getAvailable(Branch branch, def max = 0) {
        def manabe = getManabeGT(branch)
        def masaref = getMasarefGT(branch)
        def mojavezSadere = getMojavezSadereGT(branch)
        def sumDebit = getEtebarDaryaftiGT(branch)
        def sumCredit = getEtebarEtayeeGT(branch)
        def permitToward = getPermitTowardGT(branch)

        def avail = Math.max((permitToward * manabe) - (masaref), max) - (mojavezSadere - sumDebit + sumCredit)
        return Math.max(avail, max)
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

//        def amts = VosooliT.createCriteria().list {
//            projections {
//                sum("amount")
//                groupProperty("date")
//            }
//            branch {
//                branchHead {
//                    eq('id', bh.id)
//                }
//            }
//            order("date", "desc")
//        }
        def sql = new Sql(sessionFactory.currentSession.connection())
        def amts = sql.rows("select sum(amount) as amt, date from vosoolit inner join branch on vosoolit.branch_code=branch.branch_code where branch.branch_head_id=:bhid group by date order by date desc", [bhid: bh?.id])
        def lastAmt = amts.find() ?: [:]
        def prevAmt = amts.findAll { it.date != lastAmt.date }.sum { it.amt } ?: 0
        def amt = lastAmt.amt ?: 0
        def date_ = lastAmt.date

        def date = new Date()
        if (date_)
            date = getCurrentDate(date_).toJavaUtilGregorianCalendar().getTime()
        def paidPerv = LoanRequest_T.createCriteria().get {
            projections {
                sum("loanAmount")
            }
            branch {
                branchHead {
                    eq('id', bh.id)
                }
            }
            'in'('loanRequestStatus', ['Confirm', 'Paid'])
            lt('requestDate', date)
        } ?: 0
        def paidLast = LoanRequest_T.createCriteria().get {
            projections {
                sum("loanAmount")
            }
            branch {
                branchHead {
                    eq('id', bh.id)
                }
            }
            'in'('loanRequestStatus', ['Confirm', 'Paid'])
            ge('requestDate', date)
        } ?: 0
        def etebarDaryafti = EtayeeTBranchHead.createCriteria().get {
            projections {
                sum('amount')
            }
            branchHead {
                eq('id', bh?.id)
            }
        } ?: 0
        def vosool = amt * sysParam.permitReceivePercent
        def haddeGhabli = prevAmt * sysParam.permitReceivePercent - paidPerv
        def haddeJari = vosool /*- paidLast */ + haddeGhabli + etebarDaryafti
        def res = [etebarDaryafti: etebarDaryafti, haddeGhabli: haddeGhabli, vosooli: amt, paidLast: paidLast, vosooliGhabeleEstefade: vosool, haddeJari: haddeJari, date: date]
        return res
    }

    def getVosooliGH(BranchHead bh) {

        SystemParameters sysParam = SystemParameters.findAll().first()

//        def amts = VosooliGH.createCriteria().list {
//            projections {
//                sum("amount")
//                groupProperty("date")
//            }
//            branch {
//                branchHead {
//                    eq('id', bh.id)
//                }
//            }
//            order("date", "desc")
//        }
//        def lastAmt = amts.find() ?: []
//        def prevAmt = amts.findAll {it[1] != lastAmt[1]}.sum {it[0]} ?: 0
//        def amt = lastAmt[0] ?: 0
//        def date = lastAmt[1] ?: new Date()
        def sql = new Sql(sessionFactory.currentSession.connection())
        def amts = sql.rows("select sum(amount) as amt, date from vosooligh inner join branch on vosooligh.branch_code=branch.branch_code where branch.branch_head_id=:bhid group by date order by date desc", [bhid: bh?.id])
        def lastAmt = amts.find() ?: [:]
        def prevAmt = amts.findAll { it.date != lastAmt.date }.sum { it.amt } ?: 0
        def amt = lastAmt.amt ?: 0
        def date_ = lastAmt.date

        def date = new Date()
        if (date_)
            date = getCurrentDate(date_).toJavaUtilGregorianCalendar().getTime()
        def paidPerv = LoanRequest_GH.createCriteria().get {
            projections {
                sum("loanAmount")
            }
            branch {
                branchHead {
                    eq('id', bh.id)
                }
            }
            'in'('loanRequestStatus', ['Confirm', 'Paid'])
            lt('requestDate', date)
        } ?: 0
        def paidLast = LoanRequest_GH.createCriteria().get {
            projections {
                sum("loanAmount")
            }
            branch {
                branchHead {
                    eq('id', bh.id)
                }
            }
            'in'('loanRequestStatus', ['Confirm', 'Paid'])
            ge('requestDate', date)
        } ?: 0
        def etebarDaryafti = EtayeeGHBranchHead.createCriteria().get {
            projections {
                sum('amount')
            }
            branchHead {
                eq('id', bh?.id)
            }
        } ?: 0
        def vosool = amt// * sysParam.ghCentralBankPercent
        def vosooliGhabeleEstefade = (vosool ?: 0) * (sysParam.ghMonthlyPercent ?: 1)
        def haddeGhabli = (prevAmt /** sysParam.ghCentralBankPercent*/ - paidPerv) * (sysParam.ghMonthlyPercent ?: 1)
        def haddeJari = vosooliGhabeleEstefade /*- paidLast*/ + haddeGhabli + etebarDaryafti
        def res = [etebarDaryafti: etebarDaryafti, haddeGhabli: haddeGhabli, percenteGhabeleEstefade: sysParam.ghMonthlyPercent ?: 1, vosooliGhabeleEstefade: vosooliGhabeleEstefade, vosooli: amt, paidLast: paidLast, haddeJari: haddeJari, date: date]
        return res
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
