
<%@ page import="cashmanagement.LoanType" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanType.label', default: 'LoanType')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-loanType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-loanType" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list loanType">
			
				<g:if test="${loanTypeInstance?.loanGroup}">
				<li class="fieldcontain">
					<span id="loanGroup-label" class="property-label"><g:message code="loanType.loanGroup.label" default="Loan Group" /></span>
					
						<span class="property-value" aria-labelledby="loanGroup-label"><g:link controller="loanGroup" action="show" id="${loanTypeInstance?.loanGroup?.id}">${loanTypeInstance?.loanGroup?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanTypeInstance?.loanTypeCode}">
				<li class="fieldcontain">
					<span id="loanTypeCode-label" class="property-label"><g:message code="loanType.loanTypeCode.label" default="Loan Type Code" /></span>
					
						<span class="property-value" aria-labelledby="loanTypeCode-label"><g:fieldValue bean="${loanTypeInstance}" field="loanTypeCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanTypeInstance?.loanTypeName}">
				<li class="fieldcontain">
					<span id="loanTypeName-label" class="property-label"><g:message code="loanType.loanTypeName.label" default="Loan Type Name" /></span>
					
						<span class="property-value" aria-labelledby="loanTypeName-label"><g:fieldValue bean="${loanTypeInstance}" field="loanTypeName"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${loanTypeInstance?.id}" />
					<g:link class="edit" action="edit" id="${loanTypeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
