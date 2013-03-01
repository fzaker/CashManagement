<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title><g:message code="cashmanagementsystem"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: (setting ? setting.siteColor : 'blue') + 'Style.css')}"/>

</head>

<body>
<h2></h2>

<div style="margin-top: 60px;">
<g:javascript src="jquerymenu-min.js"/>
<script type="text/javascript">
    $(document).ready(function () {
        jQuery().jqueryMenu();
    });
</script>

<g:set var="vehicle" value="${(user && (user.region.code == '7')) ? 'taxi' : 'bus'}"/>

<div style="direction:ltr;font-size:16px;margin:auto;" id="jquerymenu">
    <ul>
        <c:isAdminOrBasicInformation>
            <li>
                <a href="" rel="basicInformation">
                    <g:message code="basic.information"/>
                    <span><g:message code="basic.information.description"/></span>
                </a>
            </li>
        </c:isAdminOrBasicInformation>
        <c:isBranchOrBranchHeadOrBankRegion>
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
        </c:isBranchOrBranchHeadOrBankRegion>

        <li>
            <a href="" rel="Reports">
                <g:message code="Reports"/>
                <span><g:message code="Reports.description"/></span>
            </a>
        </li>
        <c:isAdmin>
            <li>
                <a href="" rel="SystemManagement">
                    <g:message code="SystemManagement"/>
                    <span><g:message code="SystemManagement.description"/></span>
                </a>
            </li>
        </c:isAdmin>
    </ul>

</div>

<div style="direction:ltr;" id="jquerymenububble">
    <div class="slider">
        <c:isAdminOrBasicInformation>

            <div class="set basicInformation">
                <ul>
                    <c:isBasicInformation>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'branch.png')}"/>
                            </span>
                            <a href="<g:createLink controller="Branch"/>"><g:message code="branches"/></a>
                        </li>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'branchHead.png')}"/>
                            </span>
                            <a href="<g:createLink controller="BranchHead"/>"><g:message code="branchHead"/></a>
                        </li>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'bankRegion.png')}"/>
                            </span>
                            <a href="<g:createLink controller="BankRegion"/>"><g:message code="bankRegion"/></a>
                        </li>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'loanGroup.png')}"/>
                            </span>
                            <a href="<g:createLink controller="LoanGroup"/>"><g:message code="loanGroup"/></a>
                        </li>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'loanType.png')}"/>
                            </span>
                            <a href="<g:createLink controller="LoanType"/>"><g:message code="loanType"/></a>
                        </li>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'earning.png')}"/>
                            </span>
                            <a href="<g:createLink controller="GLCode"/>"><g:message code="glCode"/></a>
                        </li>
                    </c:isBasicInformation>
                    <c:isAdmin>
                        <li>
                            <a href="<g:createLink controller="SystemParametersController"/>"><g:message
                                    code="systemParameter"/></a>
                        </li>
                    </c:isAdmin>
                </ul>
            </div>

        </c:isAdminOrBasicInformation>
        <c:isBranchOrBranchHeadOrBankRegion>
            <div class="set GheireTabsareh">
                <ul>
                    <c:isBranchUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'loanType.png')}"/>
                            </span>
                            <a href="<g:createLink controller="LoanRequest_NT"/>"><g:message
                                    code="LoanRequest.register.nt"/></a>
                        </li>
                    </c:isBranchUser>
                    <c:isBranchHeadUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'branchHead.png')}"/>
                            </span>
                            <a href="<g:createLink controller="ListForBranchHead"/>"><g:message
                                    code="loanList.branchHead"/></a>
                        </li>
                    </c:isBranchHeadUser>
                    <c:isBankRegionUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'bankRegion.png')}"/>
                            </span>
                            <a href="<g:createLink controller="ListForBankRegion"/>"><g:message
                                    code="loanList.BankRegion"/></a>
                        </li>
                    </c:isBankRegionUser>
                %{--<li>--}%
                %{--<a href="<g:createLink controller="ListForHeadOffice" />"><g:message code="ListForHeadOffice"/></a>--}%
                %{--</li>--}%
                </ul>
            </div>
        </c:isBranchOrBranchHeadOrBankRegion>
        <c:isBranchOrBranchHeadOrBankRegion>
            <div class="set Tabsareh">
                <ul>
                    <c:isBranchUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'loanType.png')}"/>
                            </span>
                            <a href="<g:createLink controller="LoanRequest_T"/>"><g:message code="LoanRequest"/></a>
                        </li>
                    </c:isBranchUser>
                    <c:isBranchHeadUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'sum.png')}"/>
                            </span>
                            <a href="<g:createLink controller="AssignToBranch"/>"><g:message
                                    code="Branch.PermitAssign.t"/></a>
                        </li>
                    </c:isBranchHeadUser>
                </ul>
            </div>
        </c:isBranchOrBranchHeadOrBankRegion>
        <c:isBranchOrBranchHeadOrBankRegion>
            <div class="set Gharzolhasane">
                <ul>
                    <c:isBranchUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'loanType.png')}"/>
                            </span>
                            <a href="<g:createLink controller="LoanRequest_GH"/>"><g:message code="LoanRequest"/></a>
                        </li>
                    </c:isBranchUser>
                    <c:isBankRegionUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'sum.png')}"/>
                            </span>
                            <a href="<g:createLink controller="permissionAmount_GH"
                                                   action="branchHeadList"/>"><g:message
                                    code="Branch.PermitAssign.gh.branchHead"/></a>
                        </li>
                    </c:isBankRegionUser>
                    <c:isBranchHeadUser>
                        <li>
                            <span>
                                <img src="${resource(dir: 'images/reportMenuImages', file: 'sum.png')}"/>
                            </span>
                            <a href="<g:createLink controller="permissionAmount_GH"/>"><g:message
                                    code="Branch.PermitAssign.gh"/></a>
                        </li>
                    </c:isBranchHeadUser>
                </ul>
            </div>
        </c:isBranchOrBranchHeadOrBankRegion>
        <div class="set Reports">
            <ul>
                <li>
                    <a href="<g:createLink controller="ListResources"/>"><g:message code="Resources.List"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="Dashboard"/>"><g:message code="Loan.Dashboard"/></a>
                </li>
            </ul>
        </div>
        <c:isAdmin>
            <div class="set SystemManagement">
                <ul>
                    <li>
                        <span>
                            <img src="${resource(dir: 'images/reportMenuImages', file: 'user.png')}"/>
                        </span>
                        <a href="<g:createLink controller="UserDefinition"/>"><g:message code="User.definition"/></a>
                    </li>

                </ul>
            </div>
        </c:isAdmin>
    </div>
</div>
</div>
</body>
</html>