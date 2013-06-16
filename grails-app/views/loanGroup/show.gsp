
<%@ page import="cashmanagement.LoanGroup" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanGroup.label', default: 'LoanGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-loanGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-loanGroup" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list loanGroup">
			
				<g:if test="${loanGroupInstance?.loanGroupCode}">
				<li class="fieldcontain">
					<span id="loanGroupCode-label" class="property-label"><g:message code="loanGroup.loanGroupCode.label" default="Loan Group Code" /></span>
					
						<span class="property-value" aria-labelledby="loanGroupCode-label"><g:fieldValue bean="${loanGroupInstance}" field="loanGroupCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanGroupInstance?.loanGroupName}">
				<li class="fieldcontain">
					<span id="loanGroupName-label" class="property-label"><g:message code="loanGroup.loanGroupName.label" default="Loan Group Name" /></span>
					
						<span class="property-value" aria-labelledby="loanGroupName-label"><g:fieldValue bean="${loanGroupInstance}" field="loanGroupName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loanGroupInstance?.loanTypes}">
				<li class="fieldcontain">
					<span id="loanTypes-label" class="property-label"><g:message code="loanGroup.loanTypes.label" default="Loan Types" /></span>
					
						<g:each in="${loanGroupInstance.loanTypes}" var="l">
						<span class="property-value" aria-labelledby="loanTypes-label"><g:link controller="loanType" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${loanGroupInstance?.id}" />
					<g:link class="edit" action="edit" id="${loanGroupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
