package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(GLGroupController)
@Mock(GLGroup)
class GLGroupControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/GLGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.GLGroupInstanceList.size() == 0
        assert model.GLGroupInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.GLGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.GLGroupInstance != null
        assert view == '/GLGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/GLGroup/show/1'
        assert controller.flash.message != null
        assert GLGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/GLGroup/list'


        populateValidParams(params)
        def GLGroup = new GLGroup(params)

        assert GLGroup.save() != null

        params.id = GLGroup.id

        def model = controller.show()

        assert model.GLGroupInstance == GLGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/GLGroup/list'


        populateValidParams(params)
        def GLGroup = new GLGroup(params)

        assert GLGroup.save() != null

        params.id = GLGroup.id

        def model = controller.edit()

        assert model.GLGroupInstance == GLGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/GLGroup/list'

        response.reset()


        populateValidParams(params)
        def GLGroup = new GLGroup(params)

        assert GLGroup.save() != null

        // test invalid parameters in update
        params.id = GLGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/GLGroup/edit"
        assert model.GLGroupInstance != null

        GLGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/GLGroup/show/$GLGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        GLGroup.clearErrors()

        populateValidParams(params)
        params.id = GLGroup.id
        params.version = -1
        controller.update()

        assert view == "/GLGroup/edit"
        assert model.GLGroupInstance != null
        assert model.GLGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/GLGroup/list'

        response.reset()

        populateValidParams(params)
        def GLGroup = new GLGroup(params)

        assert GLGroup.save() != null
        assert GLGroup.count() == 1

        params.id = GLGroup.id

        controller.delete()

        assert GLGroup.count() == 0
        assert GLGroup.get(GLGroup.id) == null
        assert response.redirectedUrl == '/GLGroup/list'
    }
}
