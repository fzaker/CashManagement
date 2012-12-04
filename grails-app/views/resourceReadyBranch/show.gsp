
<%@ page import="cashmanagement.ResourceReadyBranch" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'resourceReadyBranch.label', default: 'ResourceReadyBranch')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-resourceReadyBranch" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-resourceReadyBranch" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list resourceReadyBranch">
			
				<g:if test="${resourceReadyBranchInstance?.availableAmount}">
				<li class="fieldcontain">
					<span id="availableAmount-label" class="property-label"><g:message code="resourceReadyBranch.availableAmount.label" default="Available Amount" /></span>
					
						<span class="property-value" aria-labelledby="availableAmount-label"><g:fieldValue bean="${resourceReadyBranchInstance}" field="availableAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${resourceReadyBranchInstance?.branchCode}">
				<li class="fieldcontain">
					<span id="branchCode-label" class="property-label"><g:message code="resourceReadyBranch.branchCode.label" default="Branch Code" /></span>
					
						<span class="property-value" aria-labelledby="branchCode-label"><g:fieldValue bean="${resourceReadyBranchInstance}" field="branchCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${resourceReadyBranchInstance?.branchName}">
				<li class="fieldcontain">
					<span id="branchName-label" class="property-label"><g:message code="resourceReadyBranch.branchName.label" default="Branch Name" /></span>
					
						<span class="property-value" aria-labelledby="branchName-label"><g:fieldValue bean="${resourceReadyBranchInstance}" field="branchName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${resourceReadyBranchInstance?.selfUsed}">
				<li class="fieldcontain">
					<span id="selfUsed-label" class="property-label"><g:message code="resourceReadyBranch.selfUsed.label" default="Self Used" /></span>
					
						<span class="property-value" aria-labelledby="selfUsed-label"><g:fieldValue bean="${resourceReadyBranchInstance}" field="selfUsed"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${resourceReadyBranchInstance?.transfered}">
				<li class="fieldcontain">
					<span id="transfered-label" class="property-label"><g:message code="resourceReadyBranch.transfered.label" default="Transfered" /></span>
					
						<span class="property-value" aria-labelledby="transfered-label"><g:fieldValue bean="${resourceReadyBranchInstance}" field="transfered"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${resourceReadyBranchInstance?.id}" />
					<g:link class="edit" action="edit" id="${resourceReadyBranchInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
