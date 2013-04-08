
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
            <rg:criteria inline="true">
                <rg:eq name="branchHead.id" label="${message(code: "branch.branchHead")}" from="${cashmanagement.BranchHead.list()}" noSelection="['':'']"/>
                <rg:ilike name="branchCode"  label="${message(code: "branch.branchCode")}"/>
                <rg:ilike name="branchName"  label="${message(code: "branch.branchName")}"/>
                <rg:filterGrid grid="BranchGrid" label="${message(code: "search")}"/>
            </rg:criteria>
            <rg:grid
                    columns="[[name:'branchHead'],[name:'branchCode'],[name:'branchName']]"
                    showCommand="false" domainClass="${cashmanagement.Branch}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="branch" title="${entityName}">
                <rg:fields bean="${new cashmanagement.Branch()}">
                    <rg:modify>
                        <rg:ignoreField field="available"/>
                        <rg:ignoreField field="percentCurMonth"/>
                        <rg:ignoreField field="percentOldMonth"/>
                    </rg:modify>
                </rg:fields>
                <rg:saveButton domainClass="${cashmanagement.Branch}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openBranchCreateDialog()" value="${message(code: "create")}"/>
            <input type="button" ng-click="openBranchEditDialog()" value="${message(code: "edit")}"/>
        </div>
    </body>
</html>
