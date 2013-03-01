
<%@ page import="cashmanagement.BranchHead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branchHead.label', default: 'BranchHead')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-branchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-branchHead" ng-controller="branchHeadController" class="content scaffold-list" role="main">
            <rg:grid showCommand="false" domainClass="${cashmanagement.BranchHead}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="branchHead" title="${entityName}">
                <rg:fields bean="${new cashmanagement.BranchHead()}">
                    <rg:modify>
                        <rg:ignoreField field="branches"/>
                    </rg:modify>
                </rg:fields>
                <rg:saveButton domainClass="${cashmanagement.BranchHead}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openBranchHeadCreateDialog()" value="${message(code: "create")}"/>
            <input type="button" ng-click="openBranchHeadEditDialog()" value="${message(code: "edit")}"/>
        </div>
    </body>
</html>
