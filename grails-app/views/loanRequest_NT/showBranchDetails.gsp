
<%@ page import="cashmanagement.LoanRequestNTBarrow; cashmanagement.LoanRequest_NT; cashmanagement.Branch" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<a href="#show-branch" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="show-branch" class="content scaffold-show" role="main">

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list branch">

        <g:if test="${branchInstance?.branchHead}">
            <li class="fieldcontain">
                <span id="branchHead-label" class="property-label"><g:message code="branch.branchHead.label" default="Branch Head" /></span>

                <span class="property-value" aria-labelledby="branchHead-label">${branchInstance?.branchHead?.encodeAsHTML()}</span>

            </li>
        </g:if>

        <g:if test="${branchInstance?.branchCode}">
            <li class="fieldcontain">
                <span id="branchCode-label" class="property-label"><g:message code="branch.branchCode.label" default="Branch Code" /></span>

                <span class="property-value" aria-labelledby="branchCode-label"><g:fieldValue bean="${branchInstance}" field="branchCode"/></span>

            </li>
        </g:if>

        <g:if test="${branchInstance?.branchName}">
            <li class="fieldcontain">
                <span id="branchName-label" class="property-label"><g:message code="branch.branchName.label" default="Branch Name" /></span>

                <span class="property-value" aria-labelledby="branchName-label"><g:fieldValue bean="${branchInstance}" field="branchName"/></span>

            </li>
        </g:if>
        <li class="fieldcontain">
            <rg:grid caption="${message(code:"confirm-loans-label")}"
                     domainClass="${LoanRequest_NT}"
                     showCommand="false">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                    <rg:eq name="branch.id" value="${branchInstance?.id}"/>
                </rg:criteria>
            </rg:grid>
        </li>
        <li class="fieldcontain">
            <rg:grid caption="${message(code:"barrow-to-other-branchs")}"
                     domainClass="${LoanRequestNTBarrow}"
                     columns="[[name:'credit'],[name:'user'],[name:'branch',expression:'obj.request.branch.toString()'],[name:'request',expression:'obj.request.loanIDCode'],[name:'date']]"
                     showCommand="false">
                <rg:criteria>
                    <rg:eq name="branch.id" value="${branchInstance?.id}"/>
                    <rg:isNull name="debit"/>
                </rg:criteria>
            </rg:grid>
        </li>

    </ol>

</div>
</body>
</html>
