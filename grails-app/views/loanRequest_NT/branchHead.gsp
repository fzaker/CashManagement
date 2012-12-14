<%@ page import="cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-loanRequest_NT" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                     default="Skip to content&hellip;"/></a>

<div id="list-loanRequest_NT" ng-controller="loanRequest_NTController" class="content scaffold-list" role="main">

    <rg:grid domainClass="${cashmanagement.LoanRequestNT_BranchHead}">
        <rg:criteria>
            <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
        </rg:criteria>
    </rg:grid>

</div>
</body>
</html>
