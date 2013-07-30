package cashmanagement



import org.junit.*
import grails.test.mixin.*

@TestFor(EtayeeGHBranchHeadController)
@Mock(EtayeeGHBranchHead)
class EtayeeGHBranchHeadControllerTests {


    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/etayeeGHBranchHead/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.etayeeGHBranchHeadInstanceList.size() == 0
        assert model.etayeeGHBranchHeadInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.etayeeGHBranchHeadInstance != null
    }

    void testSave() {
        controller.save()

        assert model.etayeeGHBranchHeadInstance != null
        assert view == '/etayeeGHBranchHead/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/etayeeGHBranchHead/show/1'
        assert controller.flash.message != null
        assert EtayeeGHBranchHead.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/etayeeGHBranchHead/list'


        populateValidParams(params)
        def etayeeGHBranchHead = new EtayeeGHBranchHead(params)

        assert etayeeGHBranchHead.save() != null

        params.id = etayeeGHBranchHead.id

        def model = controller.show()

        assert model.etayeeGHBranchHeadInstance == etayeeGHBranchHead
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/etayeeGHBranchHead/list'


        populateValidParams(params)
        def etayeeGHBranchHead = new EtayeeGHBranchHead(params)

        assert etayeeGHBranchHead.save() != null

        params.id = etayeeGHBranchHead.id

        def model = controller.edit()

        assert model.etayeeGHBranchHeadInstance == etayeeGHBranchHead
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/etayeeGHBranchHead/list'

        response.reset()


        populateValidParams(params)
        def etayeeGHBranchHead = new EtayeeGHBranchHead(params)

        assert etayeeGHBranchHead.save() != null

        // test invalid parameters in update
        params.id = etayeeGHBranchHead.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/etayeeGHBranchHead/edit"
        assert model.etayeeGHBranchHeadInstance != null

        etayeeGHBranchHead.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/etayeeGHBranchHead/show/$etayeeGHBranchHead.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        etayeeGHBranchHead.clearErrors()

        populateValidParams(params)
        params.id = etayeeGHBranchHead.id
        params.version = -1
        controller.update()

        assert view == "/etayeeGHBranchHead/edit"
        assert model.etayeeGHBranchHeadInstance != null
        assert model.etayeeGHBranchHeadInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/etayeeGHBranchHead/list'

        response.reset()

        populateValidParams(params)
        def etayeeGHBranchHead = new EtayeeGHBranchHead(params)

        assert etayeeGHBranchHead.save() != null
        assert EtayeeGHBranchHead.count() == 1

        params.id = etayeeGHBranchHead.id

        controller.delete()

        assert EtayeeGHBranchHead.count() == 0
        assert EtayeeGHBranchHead.get(etayeeGHBranchHead.id) == null
        assert response.redirectedUrl == '/etayeeGHBranchHead/list'
    }
}
