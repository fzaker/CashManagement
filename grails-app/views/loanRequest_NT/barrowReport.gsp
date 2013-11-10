<%@ page import="java.math.RoundingMode; cashmanagement.SystemParameters; cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'barrow.label', default: 'LoanRequest_NT')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>

<div class="content scaffold-list" role="main">

    <rg:criteria inline="true">
        <rg:nest name="request">
            <rg:ilike name='loanNo'/>
        </rg:nest>
        <rg:nest name="branch">
            <rg:ilike name='branchCode'/>
            <c:isBranchUser>
                <rg:eq name='id' hidden="true" value="${user?.branch?.id}"/>
            </c:isBranchUser>
            <c:isBranchHeadUser>
                <rg:nest name="branchHead">
                    <rg:eq name='id' hidden="true" value="${user?.branchHead?.id}"/>
                </rg:nest>
            </c:isBranchHeadUser>
            <c:isBankRegionUser>
                <rg:nest name="branchHead">
                    <rg:nest name="bankRegion">
                        <rg:eq name='id' hidden="true" value="${user?.bankRegion?.id}"/>
                    </rg:nest>
                </rg:nest>
            </c:isBankRegionUser>
        </rg:nest>

        <rg:ge name='date' idPrefix='from' datePicker='true' label='from-date'/>
        <rg:le name='date' idPrefix='to' datePicker='true' label='to-date'/>
        <rg:filterGrid grid="LoanRequestNTBarrowGrid"/>
    </rg:criteria>
    <rg:grid domainClass="${cashmanagement.LoanRequestNTBarrow}"
             showCommand="false"
             caption="${message(code: "request_barrows")}">
        <rg:criteria>
            <c:isBranchUser>
                <rg:eq name='branch.id' value="${user?.branch?.id}"/>
            </c:isBranchUser>
            <c:isBranchHeadUser>
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:eq name='id' value="${user?.branchHead?.id}"/>
                    </rg:nest>
                </rg:nest>
            </c:isBranchHeadUser>
            <c:isBankRegionUser>
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:nest name="bankRegion">
                            <rg:eq name='id' value="${user?.bankRegion?.id}"/>
                        </rg:nest>
                    </rg:nest>
                </rg:nest>
            </c:isBankRegionUser>
        </rg:criteria>
        <rg:columns>
            <rg:column name="debit"/>
            <rg:column name="credit"/>
            <rg:column name="user"/>
            <rg:column name="branch"/>
            <rg:column name="otherSide" expression="obj.otherSide.branch.toString()"/>
            <rg:column name="date"/>
            <rg:column name="request" expression="obj.request.loanNo"/>
        </rg:columns>
    </rg:grid>

</div>

</body>
</html>
