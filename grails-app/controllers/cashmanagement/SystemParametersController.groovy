package cashmanagement

import org.springframework.dao.DataIntegrityViolationException

class SystemParametersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "edit", params: params)
    }


    def edit() {
        def systemParameters = SystemParameters.findAll()
        def systemParametersInstance
        if (systemParameters)
            systemParametersInstance = systemParameters.first()
        else
            systemParametersInstance = new SystemParameters()
        if (!systemParametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), params.id])
            redirect(action: "list")
            return
        }

        [systemParametersInstance: systemParametersInstance]
    }

    def update() {
        def systemParametersInstance = SystemParameters.get(params.id)
        if (!systemParametersInstance) {
            systemParametersInstance = new SystemParameters(params)
        }
        else
            systemParametersInstance.properties = params

        if (!systemParametersInstance.save(flush: true)) {
            render(view: "edit", model: [systemParametersInstance: systemParametersInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'systemParameters.label', default: 'SystemParameters'), systemParametersInstance.id])
        redirect(action: "edit", id: systemParametersInstance.id)
    }

}
