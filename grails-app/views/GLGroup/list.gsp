
<%@ page import="cashmanagement.GLGroup" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'GLGroup.label', default: 'GLGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-GLGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-GLGroup" ng-controller="GLGroupController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.GLGroup}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="GLGroup" title="GLGroup Dialog">
                <rg:fields bean="${new cashmanagement.GLGroup()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.GLGroup}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openGLGroupCreateDialog()" value="Create GLGroup"/>
            <input type="button" ng-click="openGLGroupEditDialog()" value="Edit GLGroup"/>
        </div>
    </body>
</html>
