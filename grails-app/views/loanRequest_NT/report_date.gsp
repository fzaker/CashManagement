<%@ page import="cashmanagement.BranchHead; cashmanagement.Branch; cashmanagement.SystemParameters; cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_NT.report.label', default: 'LoanRequest_NT')}"/>
    <title>${entityName}</title>
</head>

<body>
<h2>${entityName}</h2>

<div id="list-loanRequest_NT" class="content scaffold-list" role="main">
    <g:form action="report_date">
        <rg:datePicker name="date" value="${date}"/>
        <g:submitButton name="submit" value="${message(code:"search")}"/>
    </g:form>
    <div class="fieldcontain bank-region-percent">
        <span class="property-label-my branch-head-name"><g:message code="branch" /></span>
        <span class="property-label-my min-growth"><g:message code="avg-manabe" /></span>
        <span class="property-label-my min-growth"><g:message code="masaref-rem" /></span>
        <span class="property-label-my manabe-percent"><g:message code="mojavezSadereNT" /></span>
        <span class="property-label-my manabe-percent"><g:message code="sumDebit" /></span>
        <span class="property-label-my manabe-percent"><g:message code="sumCredit" /></span>
        <span class="property-label-my min-growth"><g:message code="masarefBeManabe"/></span>
    </div>
    <g:each in="${branches}" var="br">
        <div class="fieldcontain bank-region-percent">
            <span class="property-label-my branch-head-name">${br.name}</span>
            <span class="property-label-my min-growth"><g:formatNumber number="${br.manabe}" type="number"/></span>
            <span class="property-label-my min-growth"><g:formatNumber number="${br.masaref}" type="number"/></span>
            <span class="property-label-my manabe-percent"><g:formatNumber number="${br.mojavezSadere}" type="number"/></span>
            <span class="property-label-my manabe-percent"><g:formatNumber number="${br.sumD}" type="number"/></span>
            <span class="property-label-my manabe-percent"><g:formatNumber number="${br.sumC}" type="number"/></span>
            <span class="property-label-my min-growth"><g:formatNumber number="${br.percent}" type="number" maxFractionDigits="2"/></span>
        </div>
    </g:each>

</div>

</body>
</html>
