
<%@ page import="cashmanagement.PermissionAmount_GH" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'permissionAmount_GH.label', default: 'PermissionAmount_GH')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-permissionAmount_GH" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-permissionAmount_GH" ng-controller="permissionAmount_GHController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.PermissionAmount_GH}"></rg:grid>
            <rg:dialog id="permissionAmount_GH" title="PermissionAmount_GH Dialog">
                <rg:fields bean="${new cashmanagement.PermissionAmount_GH()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.PermissionAmount_GH}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openPermissionAmount_GHCreateDialog()" value="Create PermissionAmount_GH"/>
            <input type="button" ng-click="openPermissionAmount_GHEditDialog()" value="Edit PermissionAmount_GH"/>
        </div>
    </body>
</html>
