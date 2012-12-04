
<%@ page import="cashmanagement.Branch" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-branch" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-branch" ng-controller="branchController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.Branch}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="branch" title="Branch Dialog">
                <rg:fields bean="${new cashmanagement.Branch()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.Branch}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openBranchCreateDialog()" value="Create Branch"/>
            <input type="button" ng-click="openBranchEditDialog()" value="Edit Branch"/>
        </div>
    </body>
</html>
