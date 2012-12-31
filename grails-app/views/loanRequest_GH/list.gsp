
<%@ page import="cashmanagement.LoanRequest_GH" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-loanRequest_GH" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-loanRequest_GH" ng-controller="loanRequest_GHController" class="content scaffold-list" role="main">
            <input type="button" ng-click="openLoanRequest_GHCreateDialog()" value="Create LoanRequest_GH"/>
            <rg:grid domainClass="${cashmanagement.LoanRequest_GH}" caption="ApprovedList" idPostfix="ApprovedList">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                </rg:criteria>
            </rg:grid>
            <br>
            <rg:grid domainClass="${cashmanagement.LoanRequest_GH}" caption="RejectedList" idPostfix="RejectedList">>
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
                </rg:criteria>
            </rg:grid>
            <rg:dialog id="loanRequest_GH" title="LoanRequest_GH Dialog">
                <rg:fields bean="${new cashmanagement.LoanRequest_GH()}">
                    <rg:modify>
                        <rg:hiddenReference field="loanIDCode"/>
                        <rg:hiddenReference field="loanRequestStatus"/>
                        <rg:hiddenReference field="branch"/>
                        <rg:hiddenReference field="requestDate"/>
                    </rg:modify>
                </rg:fields>
                <rg:saveButton domainClass="${cashmanagement.LoanRequest_GH}" conroller="loanRequest_GH" params="[saveCallback:'saveGridCallback']"/>
                <rg:cancelButton/>
            </rg:dialog>
            <g:javascript>
                function saveGridCallback(resp){
                    $("#LoanRequest_GHRejectedListGrid").trigger("reloadGrid")
                    $("#LoanRequest_GHApprovedListGrid").trigger("reloadGrid")
                }
            </g:javascript>

            %{--<input type="button" ng-click="openLoanRequest_GHEditDialog()" value="Edit LoanRequest_GH"/>--}%
        </div>
    </body>
</html>
