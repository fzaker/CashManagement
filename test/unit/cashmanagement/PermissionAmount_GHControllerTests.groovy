package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(PermissionAmount_GHController)
@Mock(PermissionAmount_GH)
class PermissionAmount_GHControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/permissionAmount_GH/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.permissionAmount_GHInstanceList.size() == 0
        assert model.permissionAmount_GHInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.permissionAmount_GHInstance != null
    }

    void testSave() {
        controller.save()

        assert model.permissionAmount_GHInstance != null
        assert view == '/permissionAmount_GH/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/permissionAmount_GH/show/1'
        assert controller.flash.message != null
        assert PermissionAmount_GH.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_GH/list'


        populateValidParams(params)
        def permissionAmount_GH = new PermissionAmount_GH(params)

        assert permissionAmount_GH.save() != null

        params.id = permissionAmount_GH.id

        def model = controller.show()

        assert model.permissionAmount_GHInstance == permissionAmount_GH
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_GH/list'


        populateValidParams(params)
        def permissionAmount_GH = new PermissionAmount_GH(params)

        assert permissionAmount_GH.save() != null

        params.id = permissionAmount_GH.id

        def model = controller.edit()

        assert model.permissionAmount_GHInstance == permissionAmount_GH
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_GH/list'

        response.reset()


        populateValidParams(params)
        def permissionAmount_GH = new PermissionAmount_GH(params)

        assert permissionAmount_GH.save() != null

        // test invalid parameters in update
        params.id = permissionAmount_GH.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/permissionAmount_GH/edit"
        assert model.permissionAmount_GHInstance != null

        permissionAmount_GH.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/permissionAmount_GH/show/$permissionAmount_GH.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        permissionAmount_GH.clearErrors()

        populateValidParams(params)
        params.id = permissionAmount_GH.id
        params.version = -1
        controller.update()

        assert view == "/permissionAmount_GH/edit"
        assert model.permissionAmount_GHInstance != null
        assert model.permissionAmount_GHInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/permissionAmount_GH/list'

        response.reset()

        populateValidParams(params)
        def permissionAmount_GH = new PermissionAmount_GH(params)

        assert permissionAmount_GH.save() != null
        assert PermissionAmount_GH.count() == 1

        params.id = permissionAmount_GH.id

        controller.delete()

        assert PermissionAmount_GH.count() == 0
        assert PermissionAmount_GH.get(permissionAmount_GH.id) == null
        assert response.redirectedUrl == '/permissionAmount_GH/list'
    }
}
