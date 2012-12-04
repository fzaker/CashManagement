package cashmanagement

class LoanService {

    def generateLoanId() {
        (new Random().nextInt() + 10000000).toString()
    }

    def checkResourceAvailability(Branch branch, long amt) {
        Math.random() > 0.5
    }
}
