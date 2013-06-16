
<%@ page import="cashmanagement.PermissionAmount_T" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'permissionAmount_T.label', default: 'PermissionAmount_T')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-permissionAmount_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-permissionAmount_T" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list permissionAmount_T">
			
				<g:if test="${permissionAmount_TInstance?.branch}">
				<li class="fieldcontain">
					<span id="branch-label" class="property-label"><g:message code="permissionAmount_T.branch.label" default="Branch" /></span>
					
						<span class="property-value" aria-labelledby="branch-label"><g:link controller="branch" action="show" id="${permissionAmount_TInstance?.branch?.id}">${permissionAmount_TInstance?.branch?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${permissionAmount_TInstance?.permAmount}">
				<li class="fieldcontain">
					<span id="permAmount-label" class="property-label"><g:message code="permissionAmount_T.permAmount.label" default="Perm Amount" /></span>
					
						<span class="property-value" aria-labelledby="permAmount-label"><g:fieldValue bean="${permissionAmount_TInstance}" field="permAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${permissionAmount_TInstance?.year}">
				<li class="fieldcontain">
					<span id="year-label" class="property-label"><g:message code="permissionAmount_T.year.label" default="Year" /></span>
					
						<span class="property-value" aria-labelledby="year-label"><g:fieldValue bean="${permissionAmount_TInstance}" field="year"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${permissionAmount_TInstance?.id}" />
					<g:link class="edit" action="edit" id="${permissionAmount_TInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
