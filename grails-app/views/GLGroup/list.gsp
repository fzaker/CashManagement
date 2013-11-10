
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
            <rg:criteria inline="true">
                <rg:ilike name="glGroupCode"  label="code"/>
                <rg:ilike name="glGroupName"  label="title"/>
                <rg:filterGrid grid="GLGroupGrid"/>
            </rg:criteria>
            <rg:grid showCommand="false" domainClass="${cashmanagement.GLGroup}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="GLGroup" title="${entityName}">
                <rg:fields bean="${new cashmanagement.GLGroup()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.GLGroup}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openGLGroupCreateDialog()" value="${message(code: "create")}"/>
            <input type="button" ng-click="openGLGroupEditDialog()" value="${message(code: "edit")}"/>
        </div>
    </body>
</html>
