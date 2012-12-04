
<%@ page import="cashmanagement.ResourceReadyBranch" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'resourceReadyBranch.label', default: 'ResourceReadyBranch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-resourceReadyBranch" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-resourceReadyBranch" ng-controller="resourceReadyBranchController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.ResourceReadyBranch}"></rg:grid>
            <rg:dialog id="resourceReadyBranch" title="ResourceReadyBranch Dialog">
                <rg:fields bean="${new cashmanagement.ResourceReadyBranch()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.ResourceReadyBranch}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openResourceReadyBranchCreateDialog()" value="Create ResourceReadyBranch"/>
            <input type="button" ng-click="openResourceReadyBranchEditDialog()" value="Edit ResourceReadyBranch"/>
        </div>
    </body>
</html>
