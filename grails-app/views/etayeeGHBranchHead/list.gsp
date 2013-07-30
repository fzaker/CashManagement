
<%@ page import="cashmanagement.EtayeeGHBranchHead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-etayeeGHBranchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-etayeeGHBranchHead" ng-controller="etayeeGHBranchHeadController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.EtayeeGHBranchHead}"></rg:grid>
            <rg:dialog id="etayeeGHBranchHead" title="EtayeeGHBranchHead Dialog">
                <rg:fields bean="${new cashmanagement.EtayeeGHBranchHead()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.EtayeeGHBranchHead}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openEtayeeGHBranchHeadCreateDialog()" value="Create EtayeeGHBranchHead"/>
            <input type="button" ng-click="openEtayeeGHBranchHeadEditDialog()" value="Edit EtayeeGHBranchHead"/>
        </div>
    </body>
</html>
