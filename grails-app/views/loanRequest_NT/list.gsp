
<%@ page import="cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-loanRequest_NT" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-loanRequest_NT" ng-controller="loanRequest_NTController" class="content scaffold-list" role="main">
            <input type="button" ng-click="openLoanRequest_NTCreateDialog()" value="Create LoanRequest_NT"/>
            %{--<input type="button" ng-click="openLoanRequest_NTEditDialog()" value="Edit LoanRequest_NT"/>--}%
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
                </rg:criteria>
            </rg:grid>
            <rg:dialog id="loanRequest_NT" title="LoanRequest_NT Dialog">
                <rg:fields bean="${new cashmanagement.LoanRequest_NT()}">
                    <rg:modify>
                        <rg:hiddenReference field="loanIDCode"/>
                        <rg:hiddenReference field="loanRequestStatus"/>
                        <rg:hiddenReference field="branch"/>
                        <rg:hiddenReference field="requestDate"/>
                    </rg:modify>
                </rg:fields>
                <rg:saveButton domainClass="${cashmanagement.LoanRequest_NT}" conroller="loanRequest_NT"/>
                <rg:cancelButton/>
            </rg:dialog>
        </div>
    </body>
</html>
