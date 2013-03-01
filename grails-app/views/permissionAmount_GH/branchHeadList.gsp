<%@ page import="cashmanagement.LoanRequest_GH; fi.joensuu.joyds1.calendar.JalaliCalendar; cashmanagement.BranchHead; cashmanagement.PermissionAmount_GH" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'permissionAmount_BranchHead_GH.label', default: 'PermissionAmount_GH')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-loanRequest_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                    default="Skip to content&hellip;"/></a>
<g:set var="year" value="${new JalaliCalendar().getYear()}"/>
<g:set var="startDate" value="${new JalaliCalendar(year, 1, 1).toJavaUtilGregorianCalendar().getTime()}"/>
<g:set var="endDate" value="${new JalaliCalendar(year, 12, 29).toJavaUtilGregorianCalendar().getTime()}"/>
<g:set var="branchHeads" value="${cashmanagement.BranchHead.findAllByBankRegion(bankRegion)}"/>
<div id="list-permissionAmount_GH" class="content scaffold-list" role="main">
    <g:form action="saveBranchHeadPermissionAmount">
        <g:each in="${branchHeads}">
            <div class="fieldcontain">
                <g:set var="permissionAmount"
                       value="${cashmanagement.PermissionAmount_BranchHead_GH.findByBranchHeadAndYear(it, year)}"/>
                <g:set var="branchs" value="${cashmanagement.Branch.findAllByBranchHead(it)}"/>
                <g:set var="usedAmount"
                       value="${cashmanagement.LoanRequest_GH.findAllByBranchInListAndRequestDateBetweenAndLoanRequestStatus(branchs, startDate, endDate, LoanRequest_GH.Confirm).sum {it.loanAmount}?:0}"/>
                <span>${it}</span>: <g:textField name="branchHead_${it.id}"
                                                 value="${formatNumber([number:permissionAmount?.permAmount,type:"number"])}" ></g:textField>
                <span><g:message code="used.amount"/>: <g:formatNumber number="${usedAmount}" type="number" /></span>
            </div>
        </g:each>

        <g:submitButton name="submit" value="${message(code: "save.label")}"/>
    </g:form>
</div>
</body>
</html>
