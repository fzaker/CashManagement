
<%@ page import="cashmanagement.LoanRequest_GH" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

		<div id="show-loanRequest_GH" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list loanRequest_GH">
			
				<g:if test="${loanRequest_GHInstance?.loanNo}">
				<li class="fieldcontain">
					<span id="loanNo-label" class="property-label"><g:message code="loanRequest_GH.loanNo.label" default="Loan No" /></span>
					
						<span class="property-value" aria-labelledby="loanNo-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="loanNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.loanIDCode}">
				<li class="fieldcontain">
					<span id="loanIDCode-label" class="property-label"><g:message code="loanRequest_T.loanIDCode.label" default="Loan IDC ode" /></span>
					
						<span class="property-value" aria-labelledby="loanIDCode-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="loanIDCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.loanType}">
				<li class="fieldcontain">
					<span id="loanType-label" class="property-label"><g:message code="loanRequest_GH.loanType.label" default="Loan Type" /></span>
					
						<span class="property-value" aria-labelledby="loanType-label"><g:link controller="loanType" action="show" id="${loanRequest_GHInstance?.loanType?.id}">${loanRequest_GHInstance?.loanType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="loanRequest_GH.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.family}">
				<li class="fieldcontain">
					<span id="family-label" class="property-label"><g:message code="loanRequest_GH.family.label" default="Family" /></span>
					
						<span class="property-value" aria-labelledby="family-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="family"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.melliCode}">
				<li class="fieldcontain">
					<span id="melliCode-label" class="property-label"><g:message code="loanRequest_GH.melliCode.label" default="Melli Code" /></span>
					
						<span class="property-value" aria-labelledby="melliCode-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="melliCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.loanAmount}">
				<li class="fieldcontain">
					<span id="loanAmount-label" class="property-label"><g:message code="loanRequest_GH.loanAmount.label" default="Loan Amount" /></span>
					
						<span class="property-value" aria-labelledby="loanAmount-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="loanAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.requestDate}">
				<li class="fieldcontain">
					<span id="requestDate-label" class="property-label"><g:message code="loanRequest_T.requestDate.label" default="Request Date" /></span>
					
						<span class="property-value" aria-labelledby="requestDate-label"><g:formatDate date="${loanRequest_GHInstance?.requestDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.loanRequestStatus}">
				<li class="fieldcontain">
					<span id="loanRequestStatus-label" class="property-label"><g:message code="loanRequest_T.loanRequestStatus.label" default="Loan Request Status" /></span>
					
						<span class="property-value" aria-labelledby="loanRequestStatus-label"><g:fieldValue bean="${loanRequest_GHInstance}" field="loanRequestStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.branch}">
				<li class="fieldcontain">
					<span id="branch-label" class="property-label"><g:message code="loanRequest_T.branch.label" default="Branch" /></span>
					
						<span class="property-value" aria-labelledby="branch-label"><g:link controller="branch" action="show" id="${loanRequest_GHInstance?.branch?.id}">${loanRequest_GHInstance?.branch?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.rejectReason}">
				<li class="fieldcontain">
					<span id="rejectReason-label" class="property-label"><g:message code="loanRequest_T.rejectReason.label" default="Reject Reason" /></span>
					
						<span class="property-value" aria-labelledby="rejectReason-label"><g:link controller="rejectReason" action="show" id="${loanRequest_GHInstance?.rejectReason?.id}">${loanRequest_GHInstance?.rejectReason?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.requestUser}">
				<li class="fieldcontain">
					<span id="requestUser-label" class="property-label"><g:message code="loanRequest_T.requestUser.label" default="Request User" /></span>
					
						<span class="property-value" aria-labelledby="requestUser-label"><g:link controller="user" action="show" id="${loanRequest_GHInstance?.requestUser?.id}">${loanRequest_GHInstance?.requestUser?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.confirmUser}">
				<li class="fieldcontain">
					<span id="confirmUser-label" class="property-label"><g:message code="loanRequest_T.confirmUser.label" default="Confirm User" /></span>
					
						<span class="property-value" aria-labelledby="confirmUser-label"><g:link controller="user" action="show" id="${loanRequest_GHInstance?.confirmUser?.id}">${loanRequest_GHInstance?.confirmUser?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.confirmedDate}">
				<li class="fieldcontain">
					<span id="confirmedDate-label" class="property-label"><g:message code="loanRequest_T.confirmedDate.label" default="Confirmed Date" /></span>
					
						<span class="property-value" aria-labelledby="confirmedDate-label"><g:formatDate date="${loanRequest_GHInstance?.confirmedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.rejectUser}">
				<li class="fieldcontain">
					<span id="rejectUser-label" class="property-label"><g:message code="loanRequest_T.rejectUser.label" default="Reject User" /></span>
					
						<span class="property-value" aria-labelledby="rejectUser-label"><g:link controller="user" action="show" id="${loanRequest_GHInstance?.rejectUser?.id}">${loanRequest_GHInstance?.rejectUser?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_GHInstance?.rejectDate}">
				<li class="fieldcontain">
					<span id="rejectDate-label" class="property-label"><g:message code="loanRequest_T.rejectDate.label" default="Reject Date" /></span>
					
						<span class="property-value" aria-labelledby="rejectDate-label"><g:formatDate date="${loanRequest_GHInstance?.rejectDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>

		</div>
    <fieldset class="buttons">
        <input type="button" class="print" value="${message(code: 'print')}" onclick="printEL()" />
    </fieldset>

    <g:javascript>
    function printEL(){
        var f=$('#show-loanRequest').clone()
        f.printElement({ printMode:'popup',overrideElementCSS:['${resource(dir: 'css',file: 'main.css')}']})
    }
    </g:javascript>
	</body>
</html>
