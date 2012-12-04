package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(LoanRequest_TController)
@Mock(LoanRequest_T)
class LoanRequest_TControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/loanRequest_T/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loanRequest_TInstanceList.size() == 0
        assert model.loanRequest_TInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loanRequest_TInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loanRequest_TInstance != null
        assert view == '/loanRequest_T/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/loanRequest_T/show/1'
        assert controller.flash.message != null
        assert LoanRequest_T.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_T/list'


        populateValidParams(params)
        def loanRequest_T = new LoanRequest_T(params)

        assert loanRequest_T.save() != null

        params.id = loanRequest_T.id

        def model = controller.show()

        assert model.loanRequest_TInstance == loanRequest_T
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_T/list'


        populateValidParams(params)
        def loanRequest_T = new LoanRequest_T(params)

        assert loanRequest_T.save() != null

        params.id = loanRequest_T.id

        def model = controller.edit()

        assert model.loanRequest_TInstance == loanRequest_T
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_T/list'

        response.reset()


        populateValidParams(params)
        def loanRequest_T = new LoanRequest_T(params)

        assert loanRequest_T.save() != null

        // test invalid parameters in update
        params.id = loanRequest_T.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/loanRequest_T/edit"
        assert model.loanRequest_TInstance != null

        loanRequest_T.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/loanRequest_T/show/$loanRequest_T.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        loanRequest_T.clearErrors()

        populateValidParams(params)
        params.id = loanRequest_T.id
        params.version = -1
        controller.update()

        assert view == "/loanRequest_T/edit"
        assert model.loanRequest_TInstance != null
        assert model.loanRequest_TInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_T/list'

        response.reset()

        populateValidParams(params)
        def loanRequest_T = new LoanRequest_T(params)

        assert loanRequest_T.save() != null
        assert LoanRequest_T.count() == 1

        params.id = loanRequest_T.id

        controller.delete()

        assert LoanRequest_T.count() == 0
        assert LoanRequest_T.get(loanRequest_T.id) == null
        assert response.redirectedUrl == '/loanRequest_T/list'
    }
}
