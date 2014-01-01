package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(LoanDifferenceController)
@Mock(LoanDifference)
class LoanDifferenceControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/loanDifference/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loanDifferenceInstanceList.size() == 0
        assert model.loanDifferenceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loanDifferenceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loanDifferenceInstance != null
        assert view == '/loanDifference/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/loanDifference/show/1'
        assert controller.flash.message != null
        assert LoanDifference.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/loanDifference/list'


        populateValidParams(params)
        def loanDifference = new LoanDifference(params)

        assert loanDifference.save() != null

        params.id = loanDifference.id

        def model = controller.show()

        assert model.loanDifferenceInstance == loanDifference
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/loanDifference/list'


        populateValidParams(params)
        def loanDifference = new LoanDifference(params)

        assert loanDifference.save() != null

        params.id = loanDifference.id

        def model = controller.edit()

        assert model.loanDifferenceInstance == loanDifference
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/loanDifference/list'

        response.reset()


        populateValidParams(params)
        def loanDifference = new LoanDifference(params)

        assert loanDifference.save() != null

        // test invalid parameters in update
        params.id = loanDifference.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/loanDifference/edit"
        assert model.loanDifferenceInstance != null

        loanDifference.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/loanDifference/show/$loanDifference.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        loanDifference.clearErrors()

        populateValidParams(params)
        params.id = loanDifference.id
        params.version = -1
        controller.update()

        assert view == "/loanDifference/edit"
        assert model.loanDifferenceInstance != null
        assert model.loanDifferenceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/loanDifference/list'

        response.reset()

        populateValidParams(params)
        def loanDifference = new LoanDifference(params)

        assert loanDifference.save() != null
        assert LoanDifference.count() == 1

        params.id = loanDifference.id

        controller.delete()

        assert LoanDifference.count() == 0
        assert LoanDifference.get(loanDifference.id) == null
        assert response.redirectedUrl == '/loanDifference/list'
    }
}
