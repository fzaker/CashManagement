<div id="menu" style="float: left;margin-top: -45px;">

    <ul class="sf-menu Menu">
        <li class="MenuItem current">
            <a href="#a" class="sf-top-level-anchor toplevel"><g:message code="basic.information"/></a>
            <ul>
                <li>
                    <a href="<g:createLink controller="Branch"/>"><g:message code="branch.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="BranchHead"/>"><g:message code="branchHead.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="BankRegion"/>"><g:message code="bankRegion.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="LoanType"/>"><g:message code="loanType.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="LoanGroup"/>"><g:message code="loanGroup.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="GLCode"/>"><g:message code="glCode.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="GLGroup"/>"><g:message code="glGroup.definition"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="SystemParametersController"/>"><g:message code="systemParameter.setting"/></a>
                </li>
            </ul>

        </li>
        <li class="MenuItem">
            <a href="#a" class="sf-top-level-anchor toplevel"><g:message code="GheireTabsareh.loans"/></a>
            <ul>
                <li>
                    <a href="<g:createLink controller="LoanRequest_NT"/>"><g:message code="LoanRequest.register.nt"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="LoanRequest_NT"  action="branchHead"/>"><g:message code="loanList.branchHead"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="LoanRequestNT_BankRegion" />"><g:message code="loanList.BankRegion"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="LoanRequestNT_HeadOffice" />"><g:message code="loanList.HeadOffice"/></a>
                </li>
            </ul>
        </li>

        <li class="MenuItem">
            <a href="#a" class="sf-top-level-anchor toplevel"><g:message code="Tabsareh.loans"/></a>
            <ul>
                <li>
                    <a href="<g:createLink controller="LoanRequest_T"/>"><g:message code="LoanRequest.register.t"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="AssignToBranch" />"><g:message code="Branch.PermitAssign.t"/></a>
                </li>

            </ul>
        </li>

        <li class="MenuItem">
            <a href="#a" class="sf-top-level-anchor toplevel"><g:message code="Gharzolhasane.loans"/></a>
            <ul>
                <li>
                    <a href="<g:createLink controller="LoanRequest_GH"/>"><g:message code="LoanRequest.register.gh"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="AssignToBranch" />"><g:message code="Branch.PermitAssign.gh"/></a>
                </li>

            </ul>
        </li>

        <li class="MenuItem">
            <a href="#a" class="sf-top-level-anchor toplevel"><g:message code="Reports"/></a>
            <ul>
                <li>
                    <a href="<g:createLink controller="ListResources"/>"><g:message code="Resources.List"/></a>
                </li>
                <li>
                    <a href="<g:createLink controller="Dashboard" />"><g:message code="Loan.Dashboard"/></a>
                </li>

            </ul>
        </li>

        <li class="MenuItem">
            <a href="#a" class="sf-top-level-anchor toplevel"><g:message code="SystemManagement"/></a>
            <ul>
                <li>
                    <a href="<g:createLink controller="UserDefinition"/>"><g:message code="User.definition"/></a>
                </li>

            </ul>
        </li>

    </ul>
</div>