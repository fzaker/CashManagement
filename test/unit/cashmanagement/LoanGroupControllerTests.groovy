package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(LoanGroupController)
@Mock(LoanGroup)
class LoanGroupControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/loanGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.loanGroupInstanceList.size() == 0
        assert model.loanGroupInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.loanGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.loanGroupInstance != null
        assert view == '/loanGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/loanGroup/show/1'
        assert controller.flash.message != null
        assert LoanGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/loanGroup/list'


        populateValidParams(params)
        def loanGroup = new LoanGroup(params)

        assert loanGroup.save() != null

        params.id = loanGroup.id

        def model = controller.show()

        assert model.loanGroupInstance == loanGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/loanGroup/list'


        populateValidParams(params)
        def loanGroup = new LoanGroup(params)

        assert loanGroup.save() != null

        params.id = loanGroup.id

        def model = controller.edit()

        assert model.loanGroupInstance == loanGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/loanGroup/list'

        response.reset()


        populateValidParams(params)
        def loanGroup = new LoanGroup(params)

        assert loanGroup.save() != null

        // test invalid parameters in update
        params.id = loanGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/loanGroup/edit"
        assert model.loanGroupInstance != null

        loanGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/loanGroup/show/$loanGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        loanGroup.clearErrors()

        populateValidParams(params)
        params.id = loanGroup.id
        params.version = -1
        controller.update()

        assert view == "/loanGroup/edit"
        assert model.loanGroupInstance != null
        assert model.loanGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/loanGroup/list'

        response.reset()

        populateValidParams(params)
        def loanGroup = new LoanGroup(params)

        assert loanGroup.save() != null
        assert LoanGroup.count() == 1

        params.id = loanGroup.id

        controller.delete()

        assert LoanGroup.count() == 0
        assert LoanGroup.get(loanGroup.id) == null
        assert response.redirectedUrl == '/loanGroup/list'
    }
}
