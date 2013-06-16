package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(LoanTypeController)
@Mock(LoanType)
class LoanTypeControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/loanType/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loanTypeInstanceList.size() == 0
        assert model.loanTypeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loanTypeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loanTypeInstance != null
        assert view == '/loanType/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/loanType/show/1'
        assert controller.flash.message != null
        assert LoanType.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/loanType/list'


        populateValidParams(params)
        def loanType = new LoanType(params)

        assert loanType.save() != null

        params.id = loanType.id

        def model = controller.show()

        assert model.loanTypeInstance == loanType
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/loanType/list'


        populateValidParams(params)
        def loanType = new LoanType(params)

        assert loanType.save() != null

        params.id = loanType.id

        def model = controller.edit()

        assert model.loanTypeInstance == loanType
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/loanType/list'

        response.reset()


        populateValidParams(params)
        def loanType = new LoanType(params)

        assert loanType.save() != null

        // test invalid parameters in update
        params.id = loanType.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/loanType/edit"
        assert model.loanTypeInstance != null

        loanType.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/loanType/show/$loanType.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        loanType.clearErrors()

        populateValidParams(params)
        params.id = loanType.id
        params.version = -1
        controller.update()

        assert view == "/loanType/edit"
        assert model.loanTypeInstance != null
        assert model.loanTypeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/loanType/list'

        response.reset()

        populateValidParams(params)
        def loanType = new LoanType(params)

        assert loanType.save() != null
        assert LoanType.count() == 1

        params.id = loanType.id

        controller.delete()

        assert LoanType.count() == 0
        assert LoanType.get(loanType.id) == null
        assert response.redirectedUrl == '/loanType/list'
    }
}
