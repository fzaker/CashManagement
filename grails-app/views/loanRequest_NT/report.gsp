<%@ page import="cashmanagement.BranchHead; cashmanagement.Branch; cashmanagement.SystemParameters; cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>

<div id="list-loanRequest_NT" class="content scaffold-list" role="main">
    <rg:criteria inline="true">
        <g:if test="${branch}">
            <rg:eq name="branch.id" value="${branch.id}" hidden="true"/>
        </g:if>
        <g:elseif test="${branchHead}">
            <rg:eq name="branch.id" from="${Branch.findAllByBranchHead(branchHead)}" optionKey="id"
                   noSelection="${["": ""]}" label="${message(code: "branch")}"/>
        </g:elseif>
        <g:elseif test="${bankRegion}">
            <rg:eq name="branch.id"
                   from="${Branch.findAllByBranchHeadInList(BranchHead.findAllByBankRegion(bankRegion))}" optionKey="id"
                   noSelection="${["": ""]}" label="${message(code: "branch")}"/>
        </g:elseif>
        <rg:gt name="requestDate" datePicker="true" label="${message(code:'date-from')}"/>
        <rg:lt name="requestDate" idPrefix="to" datePicker="true" label="${message(code:'date-to')}"/>
        <rg:eq name="loanRequestStatus" valueMessagePrefix="loanRequest_NT.loanRequestStatus" label="${message(code:'loanRequest_NT.loanRequestStatus')}" optionkey="nill" from="${new cashmanagement.LoanRequest_NT().constraints.loanRequestStatus.inList}" noSelection="['':'']"/>
        <rg:like name="loanNo" label="${message(code:'loanRequest_NT.loanNo')}"/>
        <rg:like name="name" label="${message(code:'loanRequest_NT.name')}"/>
        <rg:like name="family" label="${message(code:'loanRequest_NT.family')}"/>
        <rg:like name="melliCode" label="${message(code:'loanRequest_NT.melliCode')}"/>
        <rg:nest name="user">
            <rg:like name="name" label="${message(code:'loanRequest_NT.user')}"/>
        </rg:nest>
        <rg:nest name="sendUser">
            <rg:like name="name" label="${message(code:'loanRequest_NT.sendUser')}"/>
        </rg:nest>
        <rg:gt name="loanAmount" label="${message(code:'loanAmount-from')}"/>
        <rg:lt name="loanAmount" label="${message(code:'loanAmount-to')}"/>
        <rg:filterGrid grid="LoanRequest_NTGrid" label="${message(code:'search')}"/>
        <rg:exportGrid grid="LoanRequest_NTGrid" label="${message(code:'export-excel')}"/>
    </rg:criteria>
    <div class="fieldcontain">
        <g:message code="selected-columns"/>:
        <g:form action="report">
            <rg:checkBoxList from="${columns}" inline="true" optionKey="name" name="columns" value="${selColumnsNames}"/>
            <g:submitButton name="submit" value="${message(code: "update-fields")}"/>
        </g:form>
    </div>
    <br>
    <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
             columns="${selColumns}"
             caption=""
             showCommand="false"
             commands="${[[controller: 'loanRequest_NT', action: 'showRequestDetails', param: 'id=#id#', icon: 'magnifier']]}">
        <rg:criteria>
            <g:if test="${branch}">
                <rg:eq name="branch.id" value="${branch.id}" hidden="true"/>
            </g:if>
            <g:elseif test="${branchHead}">
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:eq name="id" value="${branchHead.id}"/>
                    </rg:nest>
                </rg:nest>
            </g:elseif>
            <g:elseif test="${bankRegion}">
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:nest name="bankRegion">
                            <rg:eq name="id" value="${bankRegion.id}"/>
                        </rg:nest>
                    </rg:nest>
                </rg:nest>
            </g:elseif>
        </rg:criteria>
    </rg:grid>

</div>

</body>
</html>
