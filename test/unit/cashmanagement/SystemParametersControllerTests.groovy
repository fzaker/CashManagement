package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(SystemParametersController)
@Mock(SystemParameters)
class SystemParametersControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/systemParameters/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.systemParametersInstanceList.size() == 0
        assert model.systemParametersInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.systemParametersInstance != null
    }

    void testSave() {
        controller.save()

        assert model.systemParametersInstance != null
        assert view == '/systemParameters/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/systemParameters/show/1'
        assert controller.flash.message != null
        assert SystemParameters.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/systemParameters/list'


        populateValidParams(params)
        def systemParameters = new SystemParameters(params)

        assert systemParameters.save() != null

        params.id = systemParameters.id

        def model = controller.show()

        assert model.systemParametersInstance == systemParameters
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/systemParameters/list'


        populateValidParams(params)
        def systemParameters = new SystemParameters(params)

        assert systemParameters.save() != null

        params.id = systemParameters.id

        def model = controller.edit()

        assert model.systemParametersInstance == systemParameters
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/systemParameters/list'

        response.reset()


        populateValidParams(params)
        def systemParameters = new SystemParameters(params)

        assert systemParameters.save() != null

        // test invalid parameters in update
        params.id = systemParameters.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/systemParameters/edit"
        assert model.systemParametersInstance != null

        systemParameters.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/systemParameters/show/$systemParameters.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        systemParameters.clearErrors()

        populateValidParams(params)
        params.id = systemParameters.id
        params.version = -1
        controller.update()

        assert view == "/systemParameters/edit"
        assert model.systemParametersInstance != null
        assert model.systemParametersInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/systemParameters/list'

        response.reset()

        populateValidParams(params)
        def systemParameters = new SystemParameters(params)

        assert systemParameters.save() != null
        assert SystemParameters.count() == 1

        params.id = systemParameters.id

        controller.delete()

        assert SystemParameters.count() == 0
        assert SystemParameters.get(systemParameters.id) == null
        assert response.redirectedUrl == '/systemParameters/list'
    }
}
