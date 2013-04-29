
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
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-loanRequest_NT" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list loanRequest_NT">
			
				<g:if test="${loanRequest_NTInstance?.loanNo}">
				<li class="fieldcontain">
					<span id="loanNo-label" class="property-label"><g:message code="loanRequest_NT.loanNo.label" default="Loan No" /></span>
					
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
					<span id="loanType-label" class="property-label"><g:message code="loanRequest_NT.loanType.label" default="Loan Type" /></span>
					
						<span class="property-value" aria-labelledby="loanType-label"><g:link controller="loanType" action="show" id="${loanRequest_NTInstance?.loanType?.id}">${loanRequest_NTInstance?.loanType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_NTInstance?.loanAmount}">
				<li class="fieldcontain">
					<span id="loanAmount-label" class="property-label"><g:message code="loanRequest_NT.loanAmount.label" default="Loan Amount" /></span>
					
						<span class="property-value" aria-labelledby="loanAmount-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_NTInstance?.requestDate}">
				<li class="fieldcontain">
					<span id="requestDate-label" class="property-label"><g:message code="loanRequest_NT.requestDate.label" default="Request Date" /></span>
					
						<span class="property-value" aria-labelledby="requestDate-label"><g:formatDate date="${loanRequest_NTInstance?.requestDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_NTInstance?.loanRequestStatus}">
				<li class="fieldcontain">
					<span id="loanRequestStatus-label" class="property-label"><g:message code="loanRequest_NT.loanRequestStatus.label" default="Loan Request Status" /></span>
					
						<span class="property-value" aria-labelledby="loanRequestStatus-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanRequestStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanRequest_NTInstance?.branch}">
				<li class="fieldcontain">
					<span id="branch-label" class="property-label"><g:message code="loanRequest_NT.branch.label" default="Branch" /></span>

						<span class="property-value" aria-labelledby="branch-label"><g:link controller="branch" action="show" id="${loanRequest_NTInstance?.branch?.id}">${loanRequest_NTInstance?.branch?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${loanRequest_NTInstance?.id}" />
					<g:link class="edit" action="edit" id="${loanRequest_NTInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
