
<%@ page import="cashmanagement.EtayeeGHBranchHead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-etayeeGHBranchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-etayeeGHBranchHead" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list etayeeGHBranchHead">
			
				<g:if test="${etayeeGHBranchHeadInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="etayeeGHBranchHead.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${etayeeGHBranchHeadInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${etayeeGHBranchHeadInstance?.branchHead}">
				<li class="fieldcontain">
					<span id="branchHead-label" class="property-label"><g:message code="etayeeGHBranchHead.branchHead.label" default="Branch Head" /></span>
					
						<span class="property-value" aria-labelledby="branchHead-label"><g:link controller="branchHead" action="show" id="${etayeeGHBranchHeadInstance?.branchHead?.id}">${etayeeGHBranchHeadInstance?.branchHead?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${etayeeGHBranchHeadInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="etayeeGHBranchHead.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${etayeeGHBranchHeadInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${etayeeGHBranchHeadInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="etayeeGHBranchHead.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${etayeeGHBranchHeadInstance?.user?.id}">${etayeeGHBranchHeadInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${etayeeGHBranchHeadInstance?.id}" />
					<g:link class="edit" action="edit" id="${etayeeGHBranchHeadInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
