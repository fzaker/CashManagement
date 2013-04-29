package cashmanagement

import fi.joensuu.joyds1.calendar.JalaliCalendar

class LoanRequest_NTService {
    def principalService
    def loanService
    def messageSource

    def report(params) {
        if (params.chart?.title == 'sumLoanBranch') {
            def list = LoanRequest_NT.findAllByBranchAndLoanRequestStatus(principalService.branch, LoanRequest_NT.Confirm).groupBy {
                def cal = Calendar.getInstance()
                cal.setTime(it.requestDate)
                new JalaliCalendar(cal)
            }.collect {
                [requestDate: it.key.toString(), loanAmount: it.value.collect {it.loanAmount}.sum()]
            }
            return [list: list, userdata: [:]]
        }
        else if(params.chart?.title== 'masarefbemanabe'){
            def local=new Locale("fa_IR")
            def branch=principalService.branch
            def manabe = loanService.getManabeGT(branch)
            def masaref = loanService.getMasarefGT(branch)
            def mojavezSadere = loanService.getMojavezSadereGT(branch)
            def sumDebit = loanService.getEtebarDaryaftiGT(branch)
            def sumCredit = loanService.getEtebarEtayeeGT(branch)
            def masarefBeManabe=(masaref + mojavezSadere - sumDebit + sumCredit)/manabe
            def list=[
                    [title:messageSource.getMessage("masarefBeManabe",null,local),amount:masarefBeManabe],
                    [title:'',amount:1-masarefBeManabe]
            ]
            return [list: list, userdata: [:]]
        }
        else if(params.chart?.title== 'availableBranches'){
            def branchHead=principalService.branchHead
            def list = Branch.findAllByBranchHead(branchHead).collect {
                [branch:it.toString(),value:Math.round(it.available)]
            }
            return [list: list, userdata: [:]]
        }
        else if(params.chart?.title== 'masarefbemanabeBranches'){
            def branchHead=principalService.branchHead
            def list = Branch.findAllByBranchHead(branchHead).collect {
                [branch:it.toString(),value:Math.round(loanService.checkAvailable_numofdays_curMonth(it, 0) * 100)]
            }
            return [list: list, userdata: [:]]
        }
        else if(params.chart?.title== 'availableBrancheHeads'){
            def bankRegion=principalService.bankRegion
            def list = BranchHead.findAllByBankRegion(bankRegion).collect {
                def available=Branch.findAllByBranchHead(it).collect {it.available}.sum()
                [branchHead:it.toString(),value:Math.round(available)]
            }
            return [list: list, userdata: [:]]
        }
        else if(params.chart?.title== 'masarefbemanabeBrancheHeads'){
            def bankRegion=principalService.bankRegion
            def list = BranchHead.findAllByBankRegion(bankRegion).collect {
                def masarefbemanabeBranches=Branch.findAllByBranchHead(it).collect{loanService.checkAvailable_numofdays_curMonth(it, 0) * 100}
                def masarefBemanabe=masarefbemanabeBranches.sum()/masarefbemanabeBranches.size()
                [branchHead:it.toString(),value:Math.round(masarefBemanabe)]
            }
            return [list: list, userdata: [:]]
        }

    }
}
