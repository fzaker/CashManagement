<%@ page import="cashmanagement.BranchHead; cashmanagement.Branch; cashmanagement.LoanDifference" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanDifference.label', default: 'LoanDifference')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>

<div id="list-loanDifference" class="content scaffold-list" role="main">
    <rg:criteria inline="true">
        <c:isBranchUser>
            <rg:eq name='branchCode' value="${branch.branchCode}" hidden='true'/>
        </c:isBranchUser>
        <c:isBranchHeadUser>
            <rg:inCrit name='branchCode'
                       value="${Branch.findAllByBranchHead(branchHead).collect { it.branchCode }}" hidden='true'/>
            <rg:eq name='branchCode'/>

        </c:isBranchHeadUser>
        <c:isBankRegionUser>
            <rg:inCrit name='branchCode'
                       value="${Branch.findAllByBranchHeadInList(BranchHead.findAllByBankRegion(bankRegion)).collect { it.branchCode }}"
                       hidden='true'/>
            <rg:eq name='branchCode'/>
        </c:isBankRegionUser>
        <rg:eq name='acctNo' label='loanDifference.acctNo'/>
        <rg:ilike name='firstName' label='loanDifference.firstName'/>
        <rg:ilike name='lastName' label='loanDifference.lastName'/>
        <rg:eq name='melliCode' label='loanDifference.melliCode'/>
        <rg:ge name='openDate' label='loanDifference.openDateFrom'/>
        <rg:le name='openDate' label='loanDifference.openDateTo'/>
        <rg:ge name='balance' label='loanDifference.balanceFrom'/>
        <rg:le name='balance' label='loanDifference.balanceTo'/>
        <rg:filterGrid grid="LoanDifferenceGrid"/>
    </rg:criteria>
    <rg:grid domainClass="${cashmanagement.LoanDifference}" showFirstColumn='false' maxColumns='7'>
        <rg:criteria>
            <c:isBranchUser>
                <rg:eq name='branchCode' value="${branch.branchCode}"/>
            </c:isBranchUser>
            <c:isBranchHeadUser>
                <rg:inCrit name='branchCode'
                           value="${Branch.findAllByBranchHead(branchHead).collect { it.branchCode }}"/>
            </c:isBranchHeadUser>
            <c:isBankRegionUser>
                <rg:inCrit name='branchCode'
                           value="${Branch.findAllByBranchHeadInList(BranchHead.findAllByBankRegion(bankRegion)).collect { it.branchCode }}"/>
            </c:isBankRegionUser>
        </rg:criteria>
    </rg:grid>

</div>
</body>
</html>
