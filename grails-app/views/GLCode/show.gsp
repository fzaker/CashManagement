
<%@ page import="cashmanagement.GLCode" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'GLCode.label', default: 'GLCode')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-GLCode" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-GLCode" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list GLCode">
			
				<g:if test="${GLCodeInstance?.glGroup}">
				<li class="fieldcontain">
					<span id="glGroup-label" class="property-label"><g:message code="GLCode.glGroup.label" default="Gl Group" /></span>
					
						<span class="property-value" aria-labelledby="glGroup-label"><g:link controller="GLGroup" action="show" id="${GLCodeInstance?.glGroup?.id}">${GLCodeInstance?.glGroup?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${GLCodeInstance?.glCode}">
				<li class="fieldcontain">
					<span id="glCode-label" class="property-label"><g:message code="GLCode.glCode.label" default="Gl Code" /></span>
					
						<span class="property-value" aria-labelledby="glCode-label"><g:fieldValue bean="${GLCodeInstance}" field="glCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${GLCodeInstance?.glFlag}">
				<li class="fieldcontain">
					<span id="glFlag-label" class="property-label"><g:message code="GLCode.glFlag.label" default="Gl Flag" /></span>
					
						<span class="property-value" aria-labelledby="glFlag-label"><g:fieldValue bean="${GLCodeInstance}" field="glFlag"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${GLCodeInstance?.id}" />
					<g:link class="edit" action="edit" id="${GLCodeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
