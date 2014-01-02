
<%@ page import="java.text.SimpleDateFormat; java.math.RoundingMode; cashmanagement.LoanRequest_T; fi.joensuu.joyds1.calendar.JalaliCalendar; cashmanagement.PermissionAmount_T" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-permissionAmount_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>


    <g:set var="branchs" value="${cashmanagement.Branch.findAllByBranchHead(branchHead)}"/>
    <g:set var="permissionAmountBranchHead"
           value="${resultParm.haddeJari}"/>

    <div id="list-permissionAmount_T" class="content scaffold-list" role="main">

        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="left" style="width: 50%">
            <div class="fieldcontain">
                <span class="property-label"><g:message code="haddeGhabli"/></span>
                <span class="property-value"><g:formatNumber
                        number="${resultParm.haddeGhabli}" maxFractionDigits="0" roundingMode="${RoundingMode.DOWN}" type="number"/> <g:message code="rial" /></span>
            </div>

            <div class="fieldcontain">
                <span class="property-label"><g:message code="vosooli"/></span>
                <span class="property-value"><span id="vosooli"><g:formatNumber
                        number="${resultParm.vosooli}" maxFractionDigits="2" type="number"/></span> <g:message code="rial" /></span>
            </div>

            <div class="fieldcontain">
                <span class="property-label"><g:message code="vosooliDate" /></span>
                <span class="property-value"><span id="vosooliDate"><rg:formatJalaliDate date="${resultParm.date}"/></span></span>
            </div>
            <div class="fieldcontain">
                <span class="property-label"><g:message code="etebarDaryafti"/></span>
                <span class="property-value"><g:formatNumber
                        number="${resultParm.etebarDaryafti}" maxFractionDigits="0" roundingMode="${RoundingMode.DOWN}" type="number"/> <g:message code="rial" /></span>
            </div>
        </div>
        <div class="right" style="width: 50%">
            <div class="fieldcontain">
                <span class="property-label"><g:message code="vosooluGhabeleEstefade"/></span>
                <span class="property-value"><g:formatNumber
                        number="${resultParm.vosooliGhabeleEstefade}" maxFractionDigits="0" roundingMode="${RoundingMode.DOWN}" type="number"/> <g:message code="rial" /></span>
            </div>

            <div class="fieldcontain">
                <span class="property-label"><g:message code="mojavezSadere"/></span>
                <span class="property-value"><span id="mojavezSadere"><g:formatNumber
                        number="${resultParm.paidLast}" maxFractionDigits="2" type="number"/></span> <g:message code="rial" /></span>
            </div>

            <div class="fieldcontain">
                <span class="property-label"><g:message code="haddeJari" /></span>
                <span class="property-value"><span id="haddeJari"><g:formatNumber
                        number="${resultParm.haddeJari}" maxFractionDigits="2" type="number"/> </span><g:message code="rial" /></span>
            </div>
            <div class="fieldcontain">
                <span class="property-label"><g:message code="usedpermissionamountbranchhead"/></span>
                <span class="property-value"><span id="usedAmount"></span> <g:message code="rial" /></span>
            </div>
            <div class="fieldcontain">
                <span class="property-label"><g:message code="permitpermissionamountbranchhead"/></span>
                <span class="property-value"><span id="permitAmount"></span> <g:message code="rial" /></span>
            </div>
        </div>

       <div>&nbsp;</div>

        <g:form action="save">
            <g:hiddenField name="date" value="${new SimpleDateFormat("yyyyMMdd").format(resultParm.date)}"/>
            <div class="fieldcontain bank-region-percent fix-at-top">
                <span class="property-label-my branch-head-name"><g:message code="branch" /></span>
                <span class="property-label-my max-growth"><g:message code="permissionAmount_T.permAmountCurrent" /></span>
                <span class="property-label-my max-growth"><g:message code="permissionAmount_T.permAmountCurrent" /></span>
                <span class="property-label-my min-growth"><g:message code="used.amount"/></span>
                <span class="property-label-my max-growth"><g:message code="permissionAmount_T.permAmountCurrent.last" /></span>
                <span class="property-label-my min-growth"><g:message code="used.amount.last"/></span>
            </div>
            <g:each in="${branchs}">
                <div class="fieldcontain bank-region-percent">
                    <g:set var="permissionAmount"
                           value="${cashmanagement.PermissionAmount_T.findByBranchAndPermissionDate(it, resultParm.date)}"/>
                    <g:set var="usedAmount"
                           value="${cashmanagement.LoanRequest_T.findAllByBranchAndRequestDateGreaterThanEqualsAndLoanRequestStatusInList(it, resultParm.date, [LoanRequest_T.Confirm,LoanRequest_T.Paid]).sum {it.loanAmount} ?: 0}"/>
                    <g:set var="permissionAmounts"
                           value="${cashmanagement.PermissionAmount_T.findAllByBranchAndPermissionDateLessThan(it, resultParm.date).sort {it.permissionDate}}"/>
                    <g:set var="permissionAmountLast"
                           value="${permissionAmounts?permissionAmounts.last():null}"/>
                    <g:set var="usedAmountLast"
                           value="${cashmanagement.LoanRequest_T.findAllByBranchAndRequestDateLessThanAndRequestDateGreaterThanEqualsAndLoanRequestStatusInList(it, resultParm.date,(permissionAmountLast?.permissionDate)?:new Date(), [LoanRequest_T.Confirm,LoanRequest_T.Paid]).sum {it.loanAmount} ?: 0}"/>
                    <span class="property-value-my branch-head-name">${it}</span>
                    <g:textField class="max-growth branchPermission" name="branch_${it.id}"
                           value="${formatNumber([number: permissionAmount?.permAmount])}"></g:textField>
                    <span class="property-value-my max-growth"><g:formatNumber number="${permissionAmount?.permAmount}" type="number"/></span>
                    <span class="property-value-my min-growth"><g:formatNumber number="${usedAmount}" type="number"/></span>

                    <span class="property-value-my max-growth"><g:formatNumber number="${permissionAmountLast?.permAmount?:0}" type="number"/></span>
                    <span class="property-value-my min-growth"><g:formatNumber number="${usedAmountLast}" type="number"/></span>

                </div>
            </g:each>

            <g:submitButton name="submit" value="${message(code: "save.label")}"/>
        </g:form>
        <g:javascript>
        $(function () {
            $(".branchPermission").keyup(function () {
                var sum = 0;
                $(".branchPermission").each(function () {
                    var s = parseFloat($(this).val().replace(/,/g, ""))
                    sum += isNaN(s) ? 0 : s
                })
                $("#usedAmount").html(addCommas(sum))
                $(this).next().html(addCommas($(this).val()))
                $("#permitAmount").html(addCommas(${permissionAmountBranchHead}-sum))
            }).keyup()
        })
        function addCommas(nStr)
        {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }
        </g:javascript>
    </div>
    </body>
</html>
