package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(LoanRequest_NTController)
@Mock(LoanRequest_NT)
class LoanRequest_NTControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/loanRequest_NT/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loanRequest_NTInstanceList.size() == 0
        assert model.loanRequest_NTInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loanRequest_NTInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loanRequest_NTInstance != null
        assert view == '/loanRequest_NT/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/loanRequest_NT/show/1'
        assert controller.flash.message != null
        assert LoanRequest_NT.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_NT/list'


        populateValidParams(params)
        def loanRequest_NT = new LoanRequest_NT(params)

        assert loanRequest_NT.save() != null

        params.id = loanRequest_NT.id

        def model = controller.show()

        assert model.loanRequest_NTInstance == loanRequest_NT
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_NT/list'


        populateValidParams(params)
        def loanRequest_NT = new LoanRequest_NT(params)

        assert loanRequest_NT.save() != null

        params.id = loanRequest_NT.id

        def model = controller.edit()

        assert model.loanRequest_NTInstance == loanRequest_NT
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_NT/list'

        response.reset()


        populateValidParams(params)
        def loanRequest_NT = new LoanRequest_NT(params)

        assert loanRequest_NT.save() != null

        // test invalid parameters in update
        params.id = loanRequest_NT.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/loanRequest_NT/edit"
        assert model.loanRequest_NTInstance != null

        loanRequest_NT.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/loanRequest_NT/show/$loanRequest_NT.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        loanRequest_NT.clearErrors()

        populateValidParams(params)
        params.id = loanRequest_NT.id
        params.version = -1
        controller.update()

        assert view == "/loanRequest_NT/edit"
        assert model.loanRequest_NTInstance != null
        assert model.loanRequest_NTInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_NT/list'

        response.reset()

        populateValidParams(params)
        def loanRequest_NT = new LoanRequest_NT(params)

        assert loanRequest_NT.save() != null
        assert LoanRequest_NT.count() == 1

        params.id = loanRequest_NT.id

        controller.delete()

        assert LoanRequest_NT.count() == 0
        assert LoanRequest_NT.get(loanRequest_NT.id) == null
        assert response.redirectedUrl == '/loanRequest_NT/list'
    }
}
