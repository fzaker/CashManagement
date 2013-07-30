package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(EtayeeTBranchHeadController)
@Mock(EtayeeTBranchHead)
class EtayeeTBranchHeadControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/etayeeTBranchHead/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.etayeeTBranchHeadInstanceList.size() == 0
        assert model.etayeeTBranchHeadInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.etayeeTBranchHeadInstance != null
    }

    void testSave() {
        controller.save()

        assert model.etayeeTBranchHeadInstance != null
        assert view == '/etayeeTBranchHead/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/etayeeTBranchHead/show/1'
        assert controller.flash.message != null
        assert EtayeeTBranchHead.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/etayeeTBranchHead/list'


        populateValidParams(params)
        def etayeeTBranchHead = new EtayeeTBranchHead(params)

        assert etayeeTBranchHead.save() != null

        params.id = etayeeTBranchHead.id

        def model = controller.show()

        assert model.etayeeTBranchHeadInstance == etayeeTBranchHead
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/etayeeTBranchHead/list'


        populateValidParams(params)
        def etayeeTBranchHead = new EtayeeTBranchHead(params)

        assert etayeeTBranchHead.save() != null

        params.id = etayeeTBranchHead.id

        def model = controller.edit()

        assert model.etayeeTBranchHeadInstance == etayeeTBranchHead
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/etayeeTBranchHead/list'

        response.reset()


        populateValidParams(params)
        def etayeeTBranchHead = new EtayeeTBranchHead(params)

        assert etayeeTBranchHead.save() != null

        // test invalid parameters in update
        params.id = etayeeTBranchHead.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/etayeeTBranchHead/edit"
        assert model.etayeeTBranchHeadInstance != null

        etayeeTBranchHead.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/etayeeTBranchHead/show/$etayeeTBranchHead.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        etayeeTBranchHead.clearErrors()

        populateValidParams(params)
        params.id = etayeeTBranchHead.id
        params.version = -1
        controller.update()

        assert view == "/etayeeTBranchHead/edit"
        assert model.etayeeTBranchHeadInstance != null
        assert model.etayeeTBranchHeadInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/etayeeTBranchHead/list'

        response.reset()

        populateValidParams(params)
        def etayeeTBranchHead = new EtayeeTBranchHead(params)

        assert etayeeTBranchHead.save() != null
        assert EtayeeTBranchHead.count() == 1

        params.id = etayeeTBranchHead.id

        controller.delete()

        assert EtayeeTBranchHead.count() == 0
        assert EtayeeTBranchHead.get(etayeeTBranchHead.id) == null
        assert response.redirectedUrl == '/etayeeTBranchHead/list'
    }
}
