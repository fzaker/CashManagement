
<%@ page import="cashmanagement.BankRegion" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bankRegion.label', default: 'BankRegion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-bankRegion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-bankRegion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list bankRegion">
			
				<g:if test="${bankRegionInstance?.bankRegionCode}">
				<li class="fieldcontain">
					<span id="bankRegionCode-label" class="property-label"><g:message code="bankRegion.bankRegionCode.label" default="Bank Region Code" /></span>
					
						<span class="property-value" aria-labelledby="bankRegionCode-label"><g:fieldValue bean="${bankRegionInstance}" field="bankRegionCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankRegionInstance?.bankRegionName}">
				<li class="fieldcontain">
					<span id="bankRegionName-label" class="property-label"><g:message code="bankRegion.bankRegionName.label" default="Bank Region Name" /></span>
					
						<span class="property-value" aria-labelledby="bankRegionName-label"><g:fieldValue bean="${bankRegionInstance}" field="bankRegionName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankRegionInstance?.branchHeads}">
				<li class="fieldcontain">
					<span id="branchHeads-label" class="property-label"><g:message code="bankRegion.branchHeads.label" default="Branch Heads" /></span>
					
						<g:each in="${bankRegionInstance.branchHeads}" var="b">
						<span class="property-value" aria-labelledby="branchHeads-label"><g:link controller="branchHead" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${bankRegionInstance?.id}" />
					<g:link class="edit" action="edit" id="${bankRegionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
