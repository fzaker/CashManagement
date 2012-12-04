package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(BankRegionController)
@Mock(BankRegion)
class BankRegionControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/bankRegion/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.bankRegionInstanceList.size() == 0
        assert model.bankRegionInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.bankRegionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.bankRegionInstance != null
        assert view == '/bankRegion/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/bankRegion/show/1'
        assert controller.flash.message != null
        assert BankRegion.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/bankRegion/list'


        populateValidParams(params)
        def bankRegion = new BankRegion(params)

        assert bankRegion.save() != null

        params.id = bankRegion.id

        def model = controller.show()

        assert model.bankRegionInstance == bankRegion
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/bankRegion/list'


        populateValidParams(params)
        def bankRegion = new BankRegion(params)

        assert bankRegion.save() != null

        params.id = bankRegion.id

        def model = controller.edit()

        assert model.bankRegionInstance == bankRegion
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/bankRegion/list'

        response.reset()


        populateValidParams(params)
        def bankRegion = new BankRegion(params)

        assert bankRegion.save() != null

        // test invalid parameters in update
        params.id = bankRegion.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/bankRegion/edit"
        assert model.bankRegionInstance != null

        bankRegion.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/bankRegion/show/$bankRegion.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        bankRegion.clearErrors()

        populateValidParams(params)
        params.id = bankRegion.id
        params.version = -1
        controller.update()

        assert view == "/bankRegion/edit"
        assert model.bankRegionInstance != null
        assert model.bankRegionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/bankRegion/list'

        response.reset()

        populateValidParams(params)
        def bankRegion = new BankRegion(params)

        assert bankRegion.save() != null
        assert BankRegion.count() == 1

        params.id = bankRegion.id

        controller.delete()

        assert BankRegion.count() == 0
        assert BankRegion.get(bankRegion.id) == null
        assert response.redirectedUrl == '/bankRegion/list'
    }
}
