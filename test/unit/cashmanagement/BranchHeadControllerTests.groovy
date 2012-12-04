package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(BranchHeadController)
@Mock(BranchHead)
class BranchHeadControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/branchHead/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.branchHeadInstanceList.size() == 0
        assert model.branchHeadInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.branchHeadInstance != null
    }

    void testSave() {
        controller.save()

        assert model.branchHeadInstance != null
        assert view == '/branchHead/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/branchHead/show/1'
        assert controller.flash.message != null
        assert BranchHead.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/branchHead/list'


        populateValidParams(params)
        def branchHead = new BranchHead(params)

        assert branchHead.save() != null

        params.id = branchHead.id

        def model = controller.show()

        assert model.branchHeadInstance == branchHead
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/branchHead/list'


        populateValidParams(params)
        def branchHead = new BranchHead(params)

        assert branchHead.save() != null

        params.id = branchHead.id

        def model = controller.edit()

        assert model.branchHeadInstance == branchHead
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/branchHead/list'

        response.reset()


        populateValidParams(params)
        def branchHead = new BranchHead(params)

        assert branchHead.save() != null

        // test invalid parameters in update
        params.id = branchHead.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/branchHead/edit"
        assert model.branchHeadInstance != null

        branchHead.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/branchHead/show/$branchHead.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        branchHead.clearErrors()

        populateValidParams(params)
        params.id = branchHead.id
        params.version = -1
        controller.update()

        assert view == "/branchHead/edit"
        assert model.branchHeadInstance != null
        assert model.branchHeadInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/branchHead/list'

        response.reset()

        populateValidParams(params)
        def branchHead = new BranchHead(params)

        assert branchHead.save() != null
        assert BranchHead.count() == 1

        params.id = branchHead.id

        controller.delete()

        assert BranchHead.count() == 0
        assert BranchHead.get(branchHead.id) == null
        assert response.redirectedUrl == '/branchHead/list'
    }
}
