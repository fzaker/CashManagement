
<%@ page import="cashmanagement.SystemParameters" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'systemParameters.label', default: 'SystemParameters')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-systemParameters" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-systemParameters" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list systemParameters">
			
				<g:if test="${systemParametersInstance?.maxGrowth}">
				<li class="fieldcontain">
					<span id="maxGrowth-label" class="property-label"><g:message code="systemParameters.maxGrowth.label" default="Max Growth" /></span>
					
						<span class="property-value" aria-labelledby="maxGrowth-label"><g:fieldValue bean="${systemParametersInstance}" field="maxGrowth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParametersInstance?.minGrowth}">
				<li class="fieldcontain">
					<span id="minGrowth-label" class="property-label"><g:message code="systemParameters.minGrowth.label" default="Min Growth" /></span>
					
						<span class="property-value" aria-labelledby="minGrowth-label"><g:fieldValue bean="${systemParametersInstance}" field="minGrowth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParametersInstance?.permitToward}">
				<li class="fieldcontain">
					<span id="permitToward-label" class="property-label"><g:message code="systemParameters.permitToward.label" default="Permit Toward" /></span>
					
						<span class="property-value" aria-labelledby="permitToward-label"><g:fieldValue bean="${systemParametersInstance}" field="permitToward"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParametersInstance?.permitReceivePercent}">
				<li class="fieldcontain">
					<span id="permitReceivePercent-label" class="property-label"><g:message code="systemParameters.permitReceivePercent.label" default="Permit Receive Percent" /></span>
					
						<span class="property-value" aria-labelledby="permitReceivePercent-label"><g:fieldValue bean="${systemParametersInstance}" field="permitReceivePercent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParametersInstance?.permitReceiveDaysNum}">
				<li class="fieldcontain">
					<span id="permitReceiveDaysNum-label" class="property-label"><g:message code="systemParameters.permitReceiveDaysNum.label" default="Permit Receive Days Num" /></span>
					
						<span class="property-value" aria-labelledby="permitReceiveDaysNum-label"><g:fieldValue bean="${systemParametersInstance}" field="permitReceiveDaysNum"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${systemParametersInstance?.id}" />
					<g:link class="edit" action="edit" id="${systemParametersInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
