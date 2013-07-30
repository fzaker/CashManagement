
<%@ page import="cashmanagement.EtayeeTBranchHead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-etayeeTBranchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-etayeeTBranchHead" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list etayeeTBranchHead">
			
				<g:if test="${etayeeTBranchHeadInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="etayeeTBranchHead.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${etayeeTBranchHeadInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${etayeeTBranchHeadInstance?.branchHead}">
				<li class="fieldcontain">
					<span id="branchHead-label" class="property-label"><g:message code="etayeeTBranchHead.branchHead.label" default="Branch Head" /></span>
					
						<span class="property-value" aria-labelledby="branchHead-label"><g:link controller="branchHead" action="show" id="${etayeeTBranchHeadInstance?.branchHead?.id}">${etayeeTBranchHeadInstance?.branchHead?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${etayeeTBranchHeadInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="etayeeTBranchHead.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${etayeeTBranchHeadInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${etayeeTBranchHeadInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="etayeeTBranchHead.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${etayeeTBranchHeadInstance?.user?.id}">${etayeeTBranchHeadInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${etayeeTBranchHeadInstance?.id}" />
					<g:link class="edit" action="edit" id="${etayeeTBranchHeadInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
