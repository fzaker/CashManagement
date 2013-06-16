
<%@ page import="cashmanagement.LoanType" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanType.label', default: 'LoanType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-loanType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-loanType" ng-controller="loanTypeController" class="content scaffold-list" role="main">
            <rg:grid showCommand="false" domainClass="${cashmanagement.LoanType}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="loanType" title="${entityName}">
                <rg:fields bean="${new cashmanagement.LoanType()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.LoanType}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openLoanTypeCreateDialog()" value="${message(code: "create")}"/>
            <input type="button" ng-click="openLoanTypeEditDialog()" value="${message(code: "edit")}"/>
        </div>
    </body>
</html>
