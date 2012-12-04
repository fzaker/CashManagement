package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(LoanRequest_GHController)
@Mock(LoanRequest_GH)
class LoanRequest_GHControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/loanRequest_GH/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loanRequest_GHInstanceList.size() == 0
        assert model.loanRequest_GHInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loanRequest_GHInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loanRequest_GHInstance != null
        assert view == '/loanRequest_GH/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/loanRequest_GH/show/1'
        assert controller.flash.message != null
        assert LoanRequest_GH.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_GH/list'


        populateValidParams(params)
        def loanRequest_GH = new LoanRequest_GH(params)

        assert loanRequest_GH.save() != null

        params.id = loanRequest_GH.id

        def model = controller.show()

        assert model.loanRequest_GHInstance == loanRequest_GH
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_GH/list'


        populateValidParams(params)
        def loanRequest_GH = new LoanRequest_GH(params)

        assert loanRequest_GH.save() != null

        params.id = loanRequest_GH.id

        def model = controller.edit()

        assert model.loanRequest_GHInstance == loanRequest_GH
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_GH/list'

        response.reset()


        populateValidParams(params)
        def loanRequest_GH = new LoanRequest_GH(params)

        assert loanRequest_GH.save() != null

        // test invalid parameters in update
        params.id = loanRequest_GH.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/loanRequest_GH/edit"
        assert model.loanRequest_GHInstance != null

        loanRequest_GH.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/loanRequest_GH/show/$loanRequest_GH.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        loanRequest_GH.clearErrors()

        populateValidParams(params)
        params.id = loanRequest_GH.id
        params.version = -1
        controller.update()

        assert view == "/loanRequest_GH/edit"
        assert model.loanRequest_GHInstance != null
        assert model.loanRequest_GHInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/loanRequest_GH/list'

        response.reset()

        populateValidParams(params)
        def loanRequest_GH = new LoanRequest_GH(params)

        assert loanRequest_GH.save() != null
        assert LoanRequest_GH.count() == 1

        params.id = loanRequest_GH.id

        controller.delete()

        assert LoanRequest_GH.count() == 0
        assert LoanRequest_GH.get(loanRequest_GH.id) == null
        assert response.redirectedUrl == '/loanRequest_GH/list'
    }
}
