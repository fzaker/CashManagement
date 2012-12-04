
<%@ page import="cashmanagement.GLGroup" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'GLGroup.label', default: 'GLGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-GLGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-GLGroup" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list GLGroup">
			
				<g:if test="${GLGroupInstance?.glGroupCode}">
				<li class="fieldcontain">
					<span id="glGroupCode-label" class="property-label"><g:message code="GLGroup.glGroupCode.label" default="Gl Group Code" /></span>
					
						<span class="property-value" aria-labelledby="glGroupCode-label"><g:fieldValue bean="${GLGroupInstance}" field="glGroupCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${GLGroupInstance?.glGroupName}">
				<li class="fieldcontain">
					<span id="glGroupName-label" class="property-label"><g:message code="GLGroup.glGroupName.label" default="Gl Group Name" /></span>
					
						<span class="property-value" aria-labelledby="glGroupName-label"><g:fieldValue bean="${GLGroupInstance}" field="glGroupName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${GLGroupInstance?.glCodes}">
				<li class="fieldcontain">
					<span id="glCodes-label" class="property-label"><g:message code="GLGroup.glCodes.label" default="Gl Codes" /></span>
					
						<g:each in="${GLGroupInstance.glCodes}" var="g">
						<span class="property-value" aria-labelledby="glCodes-label"><g:link controller="GLCode" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${GLGroupInstance?.id}" />
					<g:link class="edit" action="edit" id="${GLGroupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
