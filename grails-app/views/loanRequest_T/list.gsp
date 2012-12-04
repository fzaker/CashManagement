
<%@ page import="cashmanagement.LoanRequest_T" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanRequest_T.label', default: 'LoanRequest_T')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-loanRequest_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-loanRequest_T" ng-controller="loanRequest_TController" class="content scaffold-list" role="main">
            <input type="button" ng-click="openLoanRequest_TCreateDialog()" value="Create LoanRequest_T"/>
            <rg:grid domainClass="${cashmanagement.LoanRequest_T}" caption="ApprovedList" idPostfix="ApprovedList">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                </rg:criteria>
            </rg:grid>
            <br>
            <rg:grid domainClass="${cashmanagement.LoanRequest_T}" caption="RejectedList" idPostfix="RejectedList">>
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
                </rg:criteria>
            </rg:grid>
            <rg:dialog id="loanRequest_T" title="LoanRequest_T Dialog">
                <rg:fields bean="${new cashmanagement.LoanRequest_T()}">
                    <rg:modify>
                        <rg:hiddenReference field="loanIDCode"/>
                        <rg:hiddenReference field="loanRequestStatus"/>
                        <rg:hiddenReference field="branch"/>
                        <rg:hiddenReference field="requestDate"/>
                    </rg:modify>
                </rg:fields>
                <rg:saveButton domainClass="${cashmanagement.LoanRequest_T}" conroller="loanRequest_T"/>
                <rg:cancelButton/>
            </rg:dialog>

            %{--<input type="button" ng-click="openLoanRequest_TEditDialog()" value="Edit LoanRequest_T"/>--}%
        </div>
    </body>
</html>
