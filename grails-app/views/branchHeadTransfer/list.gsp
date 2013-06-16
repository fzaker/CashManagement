
<%@ page import="cashmanagement.BranchHeadTransfer" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branchHeadTransfer.label', default: 'BranchHeadTransfer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-branchHeadTransfer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-branchHeadTransfer" ng-controller="branchHeadTransferController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.BranchHeadTransfer}"></rg:grid>
            <rg:dialog id="branchHeadTransfer" title="BranchHeadTransfer Dialog">
                <rg:fields bean="${new cashmanagement.BranchHeadTransfer()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.BranchHeadTransfer}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openBranchHeadTransferCreateDialog()" value="Create BranchHeadTransfer"/>
            <input type="button" ng-click="openBranchHeadTransferEditDialog()" value="Edit BranchHeadTransfer"/>
        </div>
    </body>
</html>
