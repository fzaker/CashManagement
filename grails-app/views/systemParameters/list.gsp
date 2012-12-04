
<%@ page import="cashmanagement.SystemParameters" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'systemParameters.label', default: 'SystemParameters')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-systemParameters" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-systemParameters" ng-controller="systemParametersController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.SystemParameters}"></rg:grid>
            <rg:dialog id="systemParameters" title="SystemParameters Dialog">
                <rg:fields bean="${new cashmanagement.SystemParameters()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.SystemParameters}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openSystemParametersCreateDialog()" value="Create SystemParameters"/>
            <input type="button" ng-click="openSystemParametersEditDialog()" value="Edit SystemParameters"/>
        </div>
    </body>
</html>
