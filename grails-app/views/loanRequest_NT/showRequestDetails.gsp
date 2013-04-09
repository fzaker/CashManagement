
<%@ page import="cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-loanRequest_NT" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="show-loanRequest_NT" class="content scaffold-show" role="main">

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list loanRequest_NT">

        <g:if test="${loanRequest_NTInstance?.loanNo}">
            <li class="fieldcontain">
                <span id="loanNo-label" class="property-label"><g:message code="loanRequest_NT.loanNo" default="Loan No" /></span>

                <span class="property-value" aria-labelledby="loanNo-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanNo"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanIDCode}">
            <li class="fieldcontain">
                <span id="loanIDCode-label" class="property-label"><g:message code="loanRequest_NT.loanIDCode.label" default="Loan IDC ode" /></span>

                <span class="property-value" aria-labelledby="loanIDCode-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanIDCode"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanType}">
            <li class="fieldcontain">
                <span id="loanType-label" class="property-label"><g:message code="loanRequest_NT.loanType" default="Loan Type" /></span>

                <span class="property-value" aria-labelledby="loanType-label">${loanRequest_NTInstance?.loanType?.encodeAsHTML()}</span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanAmount}">
            <li class="fieldcontain">
                <span id="loanAmount-label" class="property-label"><g:message code="loanRequest_NT.loanAmount" default="Loan Amount" /></span>

                <span class="property-value" aria-labelledby="loanAmount-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanAmount"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.requestDate}">
            <li class="fieldcontain">
                <span id="requestDate-label" class="property-label"><g:message code="loanRequest_NT.requestDate" default="Request Date" /></span>

                <span class="property-value" aria-labelledby="requestDate-label"><rg:formatJalaliDate date="${loanRequest_NTInstance?.requestDate}" /></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanRequestStatus}">
            <li class="fieldcontain">
                <span id="loanRequestStatus-label" class="property-label"><g:message code="loanRequest_NT.loanRequestStatus" default="Loan Request Status" /></span>

                <span class="property-value" aria-labelledby="loanRequestStatus-label"><g:message code="${loanRequest_NTInstance.loanRequestStatus}"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.branch}">
            <li class="fieldcontain">
                <span id="branch-label" class="property-label"><g:message code="branch" default="Branch" /></span>

                <span class="property-value" aria-labelledby="branch-label">${loanRequest_NTInstance?.branch?.encodeAsHTML()}</span>

            </li>
        </g:if>

    </ol>

</div>
</body>
</html>
