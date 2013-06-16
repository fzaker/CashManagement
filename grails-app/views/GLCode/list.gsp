<%@ page import="cashmanagement.GLCode" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'GLCode.label', default: 'GLCode')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-GLCode" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div id="list-GLCode" ng-controller="GLCodeController" class="content scaffold-list" role="main">
    <rg:grid showCommand="false"
             domainClass="${cashmanagement.GLCode}"
             columns="[[name:'glGroup'],[name:'glCode'],[name:'glFlag',formatter:'string']]">
        <rg:commands>
            <rg:deleteCommand/>
        </rg:commands>
    </rg:grid>
    <rg:dialog id="GLCode" title="${entityName}">
        <rg:fields bean="${new cashmanagement.GLCode()}">
            <rg:modify>
                %{--<rg:ignoreField field="glFlag"/>--}%
            </rg:modify>
            %{--<g:select name="glFlag" optionKey="key" optionValue="value" noSelection="['': '']"--}%
                      %{--ng-model="GLCodeInstance.glFlag"--}%
                      %{--from="[[key: 1, value: message(code: 'GLCode.glFlag.manabe')], [key: -1, value: message(code: 'GLCode.glFlag.masaref')]]"/>--}%
        </rg:fields>
        <rg:saveButton domainClass="${cashmanagement.GLCode}"/>
        <rg:cancelButton/>
    </rg:dialog>
    <input type="button" ng-click="openGLCodeCreateDialog()" value="${message(code: "create")}"/>
    <input type="button" ng-click="openGLCodeEditDialog()" value="${message(code: "edit")}"/>
</div>
</body>
</html>
