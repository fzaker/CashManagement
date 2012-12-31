
<%@ page import="cashmanagement.PermissionAmount_T" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-permissionAmount_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-permissionAmount_T" ng-controller="permissionAmount_TController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.PermissionAmount_T}"></rg:grid>
            <rg:dialog id="permissionAmount_T" title="PermissionAmount_T Dialog">
                <rg:fields bean="${new cashmanagement.PermissionAmount_T()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.PermissionAmount_T}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openPermissionAmount_TCreateDialog()" value="Create PermissionAmount_T"/>
            <input type="button" ng-click="openPermissionAmount_TEditDialog()" value="Edit PermissionAmount_T"/>
        </div>
    </body>
</html>
