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
        <rg:filterGrid grid="BranchGrid"/>
    </rg:criteria>
    <rg:grid domainClass="${cashmanagement.Branch}"
             showCommand="false"
             showFirstColumn='false'
             caption="${message(code: "available_report")}">
        <rg:criteria>
            <c:isBranchUser>
                <rg:eq name='id' value="${user?.branch?.id}"/>
            </c:isBranchUser>
            <c:isBranchHeadUser>
                <rg:nest name="branchHead">
                    <rg:eq name='id' value="${user?.branchHead?.id}"/>
                </rg:nest>
            </c:isBranchHeadUser>
            <c:isBankRegionUser>
                <rg:nest name="branchHead">
                    <rg:nest name="bankRegion">
                        <rg:eq name='id' value="${user?.bankRegion?.id}"/>
                    </rg:nest>
                </rg:nest>
            </c:isBankRegionUser>
        </rg:criteria>
        <rg:columns>
            <rg:column name="branchCode" width="30"/>
            <rg:column name="branchName" width="50"/>
            <rg:column name="percentCurMonth" width="30"/>
            <rg:column name="mazadP" width="30" expression="obj.percentCurMonth <=  obj.permitTowardGT * 100 ? obj.permitTowardGT * 100-obj.percentCurMonth :\\'\\' "/>
            <rg:column name="kasriP" width="30" expression="!(obj.percentCurMonth <= obj.permitTowardGT * 100) ? obj.percentCurMonth - obj.permitTowardGT* 100 :\\'\\' "/>
            <rg:column name="available" width="60"/>
            <rg:column name="kasri" width="60"/>
            <rg:column name="sood" width="60" expression="g.formatNumber(number:obj.available * ${sysParam.soodeMazad?:0} as Long,type:\\'currency\\',maxFractionDigits:0,currencySymbol:\\'\\')"/>
            <rg:column name="jarime" width="60" expression="g.formatNumber(number:obj.kasri * ${sysParam.soodeMazad?:0} as Long,type:\\'currency\\',maxFractionDigits:0,currencySymbol:\\'\\')"/>

        </rg:columns>
    </rg:grid>

</div>

</body>
</html>
