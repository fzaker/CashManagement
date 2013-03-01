
<%@ page import="cashmanagement.LoanRequest_T; fi.joensuu.joyds1.calendar.JalaliCalendar; cashmanagement.PermissionAmount_T" %>
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

    <g:set var="year" value="${new JalaliCalendar().getYear()}"/>
    <g:set var="startDate" value="${new JalaliCalendar(year, 1, 1).toJavaUtilGregorianCalendar().getTime()}"/>
    <g:set var="endDate" value="${new JalaliCalendar(year, 12, 29).toJavaUtilGregorianCalendar().getTime()}"/>
    <g:set var="branchs" value="${cashmanagement.Branch.findAllByBranchHead(branchHead)}"/>
    <g:set var="permissionAmountBranchHead"
           value="${resultParm}"/>

    <div id="list-permissionAmount_T" class="content scaffold-list" role="main">
        <div class="fieldcontain">
            <span><g:message code="assignedpermissionamountbranchhead"/> ${branchHead}: <g:formatNumber
                    number="${permissionAmountBranchHead}" type="number"/></span>
        </div>

        <div class="fieldcontain">
            <span><g:message code="usedpermissionamountbranchhead"/> ${branchHead}: <span id="usedAmount"></span></span>
        </div>
        <div class="fieldcontain">
            <span><g:message code="permitpermissionamountbranchhead"/> ${branchHead}: <span id="permitAmount"></span></span>
        </div>
        <g:form action="save">
            <g:each in="${branchs}">
                <div class="fieldcontain">
                    <g:set var="permissionAmount"
                           value="${cashmanagement.PermissionAmount_T.findByBranchAndYear(it, year)}"/>
                    <g:set var="usedAmount"
                           value="${cashmanagement.LoanRequest_T.findAllByBranchAndRequestDateBetweenAndLoanRequestStatus(it, startDate, endDate, LoanRequest_T.Confirm).sum {it.loanAmount} ?: 0}"/>
                    <span>${it}</span>: <g:textField class="branchPermission" name="branch_${it.id}"
                                                     value="${formatNumber([number: permissionAmount?.permAmount, type: "number"])}"></g:textField>
                    <span><g:message code="used.amount"/>: <g:formatNumber number="${usedAmount}" type="number"/></span>
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
