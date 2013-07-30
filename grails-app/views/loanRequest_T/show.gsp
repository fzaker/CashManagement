
<%@ page import="cashmanagement.LoanRequest_T" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanRequest_T.label', default: 'LoanRequest_T')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript src="jquery.printelement.js"/>
	</head>
	<body>

		<div id="show-loanRequest" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list loanRequest_T">
			
				<g:if test="${loanRequest_TInstance?.loanNo}">
				<li class="fieldcontain">
					<span id="loanNo-label" class="property-label"><g:message code="loanRequest_T.loanNo.label" default="Loan No" /></span>
					
						<span class="property-value" aria-labelledby="loanNo-label"><g:fieldValue bean="${loanRequest_TInstance}" field="loanNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.loanIDCode}">
				<li class="fieldcontain">
					<span id="loanIDCode-label" class="property-label"><g:message code="loanRequest_T.loanIDCode.label" default="Loan IDC ode" /></span>
					
						<span class="property-value" aria-labelledby="loanIDCode-label"><g:fieldValue bean="${loanRequest_TInstance}" field="loanIDCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.loanType}">
				<li class="fieldcontain">
					<span id="loanType-label" class="property-label"><g:message code="loanRequest_T.loanType.label" default="Loan Type" /></span>
					
						<span class="property-value" aria-labelledby="loanType-label">${loanRequest_TInstance?.loanType?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="loanRequest_T.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${loanRequest_TInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.family}">
				<li class="fieldcontain">
					<span id="family-label" class="property-label"><g:message code="loanRequest_T.family.label" default="Family" /></span>
					
						<span class="property-value" aria-labelledby="family-label"><g:fieldValue bean="${loanRequest_TInstance}" field="family"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.melliCode}">
				<li class="fieldcontain">
					<span id="melliCode-label" class="property-label"><g:message code="loanRequest_T.melliCode.label" default="Melli Code" /></span>
					
						<span class="property-value" aria-labelledby="melliCode-label"><g:fieldValue bean="${loanRequest_TInstance}" field="melliCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.loanAmount}">
				<li class="fieldcontain">
					<span id="loanAmount-label" class="property-label"><g:message code="loanRequest_T.loanAmount.label" default="Loan Amount" /></span>
					
						<span class="property-value" aria-labelledby="loanAmount-label"><g:fieldValue bean="${loanRequest_TInstance}" field="loanAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.requestDate}">
				<li class="fieldcontain">
					<span id="requestDate-label" class="property-label"><g:message code="loanRequest_T.requestDate.label" default="Request Date" /></span>
					
						<span class="property-value" aria-labelledby="requestDate-label"><rg:formatJalaliDate date="${loanRequest_TInstance?.requestDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.loanRequestStatus}">
				<li class="fieldcontain">
					<span id="loanRequestStatus-label" class="property-label"><g:message code="loanRequest_T.loanRequestStatus.label" default="Loan Request Status" /></span>
					
						<span class="property-value" aria-labelledby="loanRequestStatus-label"><g:message code="loanRequest_NT.loanRequestStatus.${loanRequest_TInstance?.loanRequestStatus}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.branch}">
				<li class="fieldcontain">
					<span id="branch-label" class="property-label"><g:message code="loanRequest_T.branch.label" default="Branch" /></span>
					
						<span class="property-value" aria-labelledby="branch-label">${loanRequest_TInstance?.branch?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.rejectReason}">
				<li class="fieldcontain">
					<span id="rejectReason-label" class="property-label"><g:message code="loanRequest_T.rejectReason.label" default="Reject Reason" /></span>
					
						<span class="property-value" aria-labelledby="rejectReason-label">${loanRequest_TInstance?.rejectReason?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.requestUser}">
				<li class="fieldcontain">
					<span id="requestUser-label" class="property-label"><g:message code="loanRequest_T.requestUser.label" default="Request User" /></span>
					
						<span class="property-value" aria-labelledby="requestUser-label">${loanRequest_TInstance?.requestUser?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.confirmUser}">
				<li class="fieldcontain">
					<span id="confirmUser-label" class="property-label"><g:message code="loanRequest_T.confirmUser.label" default="Confirm User" /></span>
					
						<span class="property-value" aria-labelledby="confirmUser-label">${loanRequest_TInstance?.confirmUser?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.confirmedDate}">
				<li class="fieldcontain">
					<span id="confirmedDate-label" class="property-label"><g:message code="loanRequest_T.confirmedDate.label" default="Confirmed Date" /></span>
					
						<span class="property-value" aria-labelledby="confirmedDate-label"><rg:formatJalaliDate date="${loanRequest_TInstance?.confirmedDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.rejectUser}">
				<li class="fieldcontain">
					<span id="rejectUser-label" class="property-label"><g:message code="loanRequest_T.rejectUser.label" default="Reject User" /></span>
					
						<span class="property-value" aria-labelledby="rejectUser-label">${loanRequest_TInstance?.rejectUser?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_TInstance?.rejectDate}">
				<li class="fieldcontain">
					<span id="rejectDate-label" class="property-label"><g:message code="loanRequest_T.rejectDate.label" default="Reject Date" /></span>
					
						<span class="property-value" aria-labelledby="rejectDate-label"><rg:formatJalaliDate date="${loanRequest_TInstance?.rejectDate}" /></span>
					
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
