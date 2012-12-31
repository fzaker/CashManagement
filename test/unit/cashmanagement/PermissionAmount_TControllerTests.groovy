package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(PermissionAmount_TController)
@Mock(PermissionAmount_T)
class PermissionAmount_TControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/permissionAmount_T/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.permissionAmount_TInstanceList.size() == 0
        assert model.permissionAmount_TInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.permissionAmount_TInstance != null
    }

    void testSave() {
        controller.save()

        assert model.permissionAmount_TInstance != null
        assert view == '/permissionAmount_T/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/permissionAmount_T/show/1'
        assert controller.flash.message != null
        assert PermissionAmount_T.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_T/list'


        populateValidParams(params)
        def permissionAmount_T = new PermissionAmount_T(params)

        assert permissionAmount_T.save() != null

        params.id = permissionAmount_T.id

        def model = controller.show()

        assert model.permissionAmount_TInstance == permissionAmount_T
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_T/list'


        populateValidParams(params)
        def permissionAmount_T = new PermissionAmount_T(params)

        assert permissionAmount_T.save() != null

        params.id = permissionAmount_T.id

        def model = controller.edit()

        assert model.permissionAmount_TInstance == permissionAmount_T
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_T/list'

        response.reset()


        populateValidParams(params)
        def permissionAmount_T = new PermissionAmount_T(params)

        assert permissionAmount_T.save() != null

        // test invalid parameters in update
        params.id = permissionAmount_T.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/permissionAmount_T/edit"
        assert model.permissionAmount_TInstance != null

        permissionAmount_T.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/permissionAmount_T/show/$permissionAmount_T.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        permissionAmount_T.clearErrors()

        populateValidParams(params)
        params.id = permissionAmount_T.id
        params.version = -1
        controller.update()

        assert view == "/permissionAmount_T/edit"
        assert model.permissionAmount_TInstance != null
        assert model.permissionAmount_TInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_T/list'

        response.reset()

        populateValidParams(params)
        def permissionAmount_T = new PermissionAmount_T(params)

        assert permissionAmount_T.save() != null
        assert PermissionAmount_T.count() == 1

        params.id = permissionAmount_T.id

        controller.delete()

        assert PermissionAmount_T.count() == 0
        assert PermissionAmount_T.get(permissionAmount_T.id) == null
        assert response.redirectedUrl == '/permissionAmount_T/list'
    }
}
