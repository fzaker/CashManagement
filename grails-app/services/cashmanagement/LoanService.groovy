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
//        try {
        def gt0 = GLTransaction.createCriteria().get {
            projections {
                sum("glAmount")
            }
            and {
                glCode {
                    gte("glFlag", 0L)
                }
                eq("branch", branch)
            }
        }
        def lt0 = GLTransaction.createCriteria().get {
            projections {
                sum("glAmount")
            }
            and {
                glCode {
                    lt("glFlag", 0L)
                }
                eq("branch", branch)
            }
        }
        def darsad = gt0 / lt0
        SystemParameters sysParam = SystemParameters.findAll().first()
        return (sysParam?.permitToward > darsad)
//        } catch (e) {
//
//            return false
//        }
    }
}
