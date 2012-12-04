
<%@ page import="cashmanagement.BranchHeadTransfer" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branchHeadTransfer.label', default: 'BranchHeadTransfer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-branchHeadTransfer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-branchHeadTransfer" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list branchHeadTransfer">
			
				<g:if test="${branchHeadTransferInstance?.sourceBranch}">
				<li class="fieldcontain">
					<span id="sourceBranch-label" class="property-label"><g:message code="branchHeadTransfer.sourceBranch.label" default="Source Branch" /></span>
					
						<span class="property-value" aria-labelledby="sourceBranch-label"><g:link controller="branch" action="show" id="${branchHeadTransferInstance?.sourceBranch?.id}">${branchHeadTransferInstance?.sourceBranch?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadTransferInstance?.destinationBranch}">
				<li class="fieldcontain">
					<span id="destinationBranch-label" class="property-label"><g:message code="branchHeadTransfer.destinationBranch.label" default="Destination Branch" /></span>
					
						<span class="property-value" aria-labelledby="destinationBranch-label"><g:link controller="branch" action="show" id="${branchHeadTransferInstance?.destinationBranch?.id}">${branchHeadTransferInstance?.destinationBranch?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadTransferInstance?.loanRequest}">
				<li class="fieldcontain">
					<span id="loanRequest-label" class="property-label"><g:message code="branchHeadTransfer.loanRequest.label" default="Loan Request" /></span>
					
						<span class="property-value" aria-labelledby="loanRequest-label"><g:link controller="loanRequest_NT" action="show" id="${branchHeadTransferInstance?.loanRequest?.id}">${branchHeadTransferInstance?.loanRequest?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadTransferInstance?.transferDate}">
				<li class="fieldcontain">
					<span id="transferDate-label" class="property-label"><g:message code="branchHeadTransfer.transferDate.label" default="Transfer Date" /></span>
					
						<span class="property-value" aria-labelledby="transferDate-label"><g:formatDate date="${branchHeadTransferInstance?.transferDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadTransferInstance?.transferAmount}">
				<li class="fieldcontain">
					<span id="transferAmount-label" class="property-label"><g:message code="branchHeadTransfer.transferAmount.label" default="Transfer Amount" /></span>
					
						<span class="property-value" aria-labelledby="transferAmount-label"><g:fieldValue bean="${branchHeadTransferInstance}" field="transferAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadTransferInstance?.transferStatus}">
				<li class="fieldcontain">
					<span id="transferStatus-label" class="property-label"><g:message code="branchHeadTransfer.transferStatus.label" default="Transfer Status" /></span>
					
						<span class="property-value" aria-labelledby="transferStatus-label"><g:fieldValue bean="${branchHeadTransferInstance}" field="transferStatus"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${branchHeadTransferInstance?.id}" />
					<g:link class="edit" action="edit" id="${branchHeadTransferInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
