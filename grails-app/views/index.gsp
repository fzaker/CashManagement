<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Report Menu</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: (setting?setting.siteColor:'blue') + 'Style.css')}"/>

</head>
<body>
<h2></h2>
<div style="margin-top: 60px;">
<g:javascript src="jquerymenu-min.js"/>
<script type="text/javascript">
    $(document).ready(function() {
        jQuery().jqueryMenu();
    });
</script>

<g:set var="vehicle" value="${(user && (user.region.code=='7'))? 'taxi' : 'bus'}"/>

<div style="direction:ltr;font-size:16px;margin:auto;" id="jquerymenu">
    <ul>
        <li>
            <a href="" rel="basicInformation">
                <g:message code="basic.information"/>
                <span><g:message code="basic.information.description"/></span>
            </a>
        </li>
        <li>
            <a href="" rel="GheireTabsareh">
                <g:message code="GheireTabsareh"/>
                <span><g:message code="GheireTabsareh.description"/></span>
            </a>
        </li>

        <li>
            <a href="" rel="Tabsareh">
                <g:message code="Tabsareh"/>
                <span><g:message code="Tabsareh.description"/></span>
            </a>
        </li>
        <li>
            <a href="" rel="Gharzolhasane">
                <g:message code="Gharzolhasane"/>
                <span><g:message code="Gharzolhasane.description"/></span>
            </a>

        </li>
        <li>
            <a href="" rel="Reports">
                <g:message code="Reports"/>
                <span><g:message code="Reports.description"/></span>
            </a>
        </li>
        <li>
            <a href="" rel="SystemManagement">
                <g:message code="SystemManagement"/>
                <span><g:message code="SystemManagement.description"/></span>
            </a>
        </li>
    </ul>

</div>
<div style="direction:ltr;" id="jquerymenububble">
<div class="slider">
<div class="set basicInformation">
    <ul>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'branch.png')}" />
            </span>
            <a href="<g:createLink controller="Branch"/>"><g:message code="branches"/></a>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'branchHead.png')}" />
            </span>
            <a href="<g:createLink controller="BranchHead"/>"><g:message code="branchHead"/></a>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'bankRegion.png')}" />
            </span>
            <a href="<g:createLink controller="BankRegion"/>"><g:message code="bankRegion"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="LoanType"/>"><g:message code="loanType"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="LoanGroup"/>"><g:message code="loanGroup"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="GLCode"/>"><g:message code="glCode"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="SystemParametersController"/>"><g:message code="systemParameter"/></a>
        </li>
    </ul>
</div>
<div class="set GheireTabsareh">
    <ul>
        <li>
            <a href="<g:createLink controller="LoanRequest_NT"/>"><g:message code="LoanRequest"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="ListForBranchHead" />"><g:message code="ListForBranchHead"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="ListForBankRegion" />"><g:message code="ListForBankRegion"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="ListForHeadOffice" />"><g:message code="ListForHeadOffice"/></a>
        </li>
    </ul>
</div>
<div class="set Tabsareh">
    <ul>
        <li>
            <a href="<g:createLink controller="LoanRequest_T"/>"><g:message code="LoanRequest"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="AssignToBranch" />"><g:message code="AssignToBranch"/></a>
        </li>

    </ul>
</div>
<div class="set Gharzolhasane">
    <ul>
        <li>
            <a href="<g:createLink controller="LoanRequest_GH"/>"><g:message code="LoanRequest"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="AssignToBranch" />"><g:message code="AssignToBranch"/></a>
        </li>

    </ul>
</div>
<div class="set Reports">
    <ul>
        <li>
            <a href="<g:createLink controller="ListResources"/>"><g:message code="ListResources"/></a>
        </li>
        <li>
            <a href="<g:createLink controller="Dashboard" />"><g:message code="Dashboard"/></a>
        </li>
    </ul>
</div>
<div class="set SystemManagement">
    <ul>
        <li>
            <a href="<g:createLink controller="UserDefinition"/>"><g:message code="UserDefinition"/></a>
        </li>

    </ul>
</div>
</div>
</div>
</div>
</body>
</html>