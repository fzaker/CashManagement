
<%@ page import="cashmanagement.LoanRequest_T; fi.joensuu.joyds1.calendar.JalaliCalendar; cashmanagement.PermissionAmount_T" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'nt_branchHEad_percents.label', default: 'NT BranchHead Percents')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<h2><g:message code="default.list.label" args="[entityName]" /></h2>
<a href="#list-permissionAmount_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>


<div id="list-bank-region-params" class="content scaffold-list" role="main">
    <div class="fieldcontain">
        <span class="property-label"><g:message code="permitTowardPercent"/></span>
        <span class="property-value"><g:formatNumber
                number="${permitToward}" type="number" maxFractionDigits="4"/></span>
    </div>
    <div class="fieldcontain">
         <span class="property-label"><g:message code="cur-masarefBeManabe"/></span>
         <span class="property-value"><g:formatNumber number="${curManabeBeMasaref}" type="number" /></span>
    </div>
    <div class="fieldcontain">
        <span class="property-label"><g:message code="sum-manabe"/></span>
        <span class="property-value"><g:formatNumber
                number="${sumManabe}" type="number" /></span>
    </div>
    <g:form action="savePermitPercents">
        <div class="fieldcontain bank-region-percent">
            <span class="property-label-my branch-head-name"><g:message code="branchHead" /></span>
            <span class="property-label-my max-growth"><g:message code="max-growth" /></span>
            <span class="property-label-my min-growth"><g:message code="min-growth" /></span>
            <span class="property-label-my permit-toward"><g:message code="permitTowardPercent" /></span>
            <span class="property-label-my max-permit-toward"><g:message code="max-permit-toward"/></span>
            <span class="property-label-my manabe-percent"><g:message code="manabe-percent"/></span>
            <span class="property-label-my manabe"><g:message code="manabe"/></span>
        </div>
        <g:each in="${branchHeadsParams}">
            <div class="fieldcontain bank-region-percent">

                <span class="property-value-my branch-head-name">${it.branchHead}</span>
                <g:textField class=" max-growth" name="maxGrowth_${it.ntParam.id}"
                             value="${formatNumber([number: it.ntParam.maxGrowth, type: "number"])}"></g:textField>

                <g:textField class=" min-growth" name="minGrowth_${it.ntParam.id}"
                             value="${formatNumber([number: it.ntParam.minGrowth, type: "number"])}"></g:textField>


                <g:textField class=" permit-toward" name="permitToward_${it.ntParam.id}"
                                                 value="${formatNumber([number: it.ntParam.permitToward, type: "number"])}"></g:textField>

                <span class="property-value-my max-permit-toward"><g:formatNumber number="${it.maxPermitToward}" type="number"/></span>
                <span class="property-value-my manabe-percent"><g:formatNumber number="${it.manabePercent*100}" maxFractionDigits="2" type="number"/>%</span>
                <span class="property-value-my manabe"><g:formatNumber number="${it.manabe}" type="number"/> <g:message code="rial" /></span>
            </div>
        </g:each>

        <g:submitButton name="submit" value="${message(code: "save.label")}"/>
    </g:form>
</div>
</body>
</html>
