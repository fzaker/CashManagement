<sec:ifLoggedIn>
    <div id="menu" style="float: left;margin-top: -45px;margin-left:-40px ">

        <ul class="sf-menu Menu">
            <li class="MenuItem">
                <a href="<g:createLink uri="/"/>" class="sf-top-level-anchor toplevel"><g:message code="home"/></a>
            </li>
            <c:isAdminOrBasicInformation>

                <li class="MenuItem current">
                    <a href="#" class="sf-top-level-anchor toplevel"><g:message code="basic.information"/></a>
                    <ul>
                        <c:isBasicInformation>
                            <li>
                                <a href="<g:createLink controller="BankRegion"/>"><g:message
                                        code="bankRegion.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="BranchHead"/>"><g:message
                                        code="branchHead.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="Branch"/>"><g:message code="branch.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="LoanGroup"/>"><g:message
                                        code="loanGroup.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="LoanType"/>"><g:message
                                        code="loanType.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="GLGroup"/>"><g:message
                                        code="glGroup.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="GLCode"/>"><g:message code="glCode.definition"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="RejectReason"/>"><g:message code="rejectReason.definition"/></a>
                            </li>
                        </c:isBasicInformation>
                        <c:isAdmin>
                            <li>
                                <a href="<g:createLink controller="SystemParameters"/>"><g:message
                                        code="systemParameter.setting"/></a>
                            </li>
                        </c:isAdmin>
                    </ul>
                </li>
            </c:isAdminOrBasicInformation>
            <c:isBranchOrBranchHeadOrBankRegionOrAdmin>
                <li class="MenuItem">
                    <a href="#" class="sf-top-level-anchor toplevel"><g:message code="GheireTabsareh.loans"/></a>
                    <ul>
                        <c:isBranchUser>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_NT"/>"><g:message
                                        code="LoanRequest.register.nt"/></a>
                            </li>
                        </c:isBranchUser>
                        <c:isBranchHeadUser>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_NT" action="branchHead"/>"><g:message
                                        code="loanList.branchHead"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_NT" action="branchHeadPercents"/>"><g:message
                                        code="loanList.branchHeadPercents"/></a>
                            </li>
                        </c:isBranchHeadUser>
                        <c:isBankRegionUser>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_NT" action="bankRegion"/>"><g:message
                                        code="loanList.BankRegion"/></a>
                            </li>
                        </c:isBankRegionUser>
                        <c:isAdmin>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_NT" action="headOffice"/>"><g:message
                                        code="loanList.HeadOffice"/></a>
                            </li>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_NT" action="bankRegionPercents"/>"><g:message
                                        code="loanList.bankRegionPercents"/></a>
                            </li>
                        </c:isAdmin>
                    </ul>
                </li>

                <li class="MenuItem">
                    <a href="#" class="sf-top-level-anchor toplevel"><g:message code="Tabsareh.loans"/></a>
                    <ul>
                        <c:isBranchUser>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_T"/>"><g:message
                                        code="LoanRequest.register.t"/></a>
                            </li>
                        </c:isBranchUser>
                        <c:isBranchHeadUser>
                            <li>
                                <a href="<g:createLink controller="permissionAmount_T"/>"><g:message
                                        code="Branch.PermitAssign.t"/></a>
                            </li>
                        </c:isBranchHeadUser>
                        <c:isBankRegionOrAdmin>
                            <li>
                                <a href="<g:createLink controller="etayeeTBranchHead"/>"><g:message
                                        code="Branch.etayee.t"/></a>
                            </li>
                        </c:isBankRegionOrAdmin>
                    </ul>
                </li>

                <li class="MenuItem">
                    <a href="#" class="sf-top-level-anchor toplevel"><g:message code="Gharzolhasane.loans"/></a>
                    <ul>
                        <c:isBranchUser>
                            <li>
                                <a href="<g:createLink controller="LoanRequest_GH"/>"><g:message
                                        code="LoanRequest.register.gh"/></a>
                            </li>
                        </c:isBranchUser>
                        <c:isBranchHeadUser>
                            <li>
                                <a href="<g:createLink controller="permissionAmount_GH"/>"><g:message
                                        code="Branch.PermitAssign.gh.branch"/></a>
                            </li>
                        </c:isBranchHeadUser>
                        <c:isBankRegionOrAdmin>
                            <li>
                                <a href="<g:createLink controller="etayeeGHBranchHead"/>"><g:message
                                        code="Branch.etayee.gh"/></a>
                            </li>
                        </c:isBankRegionOrAdmin>

                    </ul>
                </li>
            </c:isBranchOrBranchHeadOrBankRegionOrAdmin>

            <li class="MenuItem">
                <a href="#" class="sf-top-level-anchor toplevel"><g:message code="Reports"/></a>
                <ul>
                    <li>
                        <a href="<g:createLink controller="loanRequest_NT" action="report"/>"><g:message code="loanRequest_NT.label"/></a>
                    </li>
                    <li>
                        <a href="<g:createLink controller="loanRequest_T" action="report"/>"><g:message code="loanRequest_T.label"/></a>
                    </li>
                    <li>
                        <a href="<g:createLink controller="loanRequest_GH" action="report"/>"><g:message code="loanRequest_GH.label"/></a>
                    </li>
                </ul>
            </li>

            <c:isAdmin>
                <li class="MenuItem">

                    <a href="#" class="sf-top-level-anchor toplevel"><g:message code="SystemManagement"/></a>
                    <ul>
                        <li>
                            <a href="<g:createLink controller="User"/>"><g:message code="User.definition"/></a>
                        </li>

                    </ul>
                </li>
            </c:isAdmin>
            <li class="MenuItem">

                <a href="#" class="sf-top-level-anchor toplevel"><g:message code="profile"/></a>
                <ul>
                    <li>
                        <a href="<g:createLink controller="logout" />"><g:message code="logout"/></a>
                    </li>
                    <li>
                        <a href="<g:createLink controller="user" action="changePasswordUser"/>"><g:message code="changepass"/></a>
                    </li>

                </ul>
            </li>

        </ul>
    </div>
</sec:ifLoggedIn>