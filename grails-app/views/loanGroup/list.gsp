
<%@ page import="cashmanagement.LoanGroup" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanGroup.label', default: 'LoanGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-loanGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-loanGroup" ng-controller="loanGroupController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.LoanGroup}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="loanGroup" title="LoanGroup Dialog">
                <rg:fields bean="${new cashmanagement.LoanGroup()}">
                    <rg:modify>
                        <rg:ignoreField field="loanTypes"/>
                    </rg:modify>
                </rg:fields>
                <rg:saveButton domainClass="${cashmanagement.LoanGroup}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openLoanGroupCreateDialog()" value="Create LoanGroup"/>
            <input type="button" ng-click="openLoanGroupEditDialog()" value="Edit LoanGroup"/>
        </div>
    </body>
</html>
