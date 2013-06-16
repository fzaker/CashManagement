
<%@ page import="cashmanagement.BranchHead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branchHead.label', default: 'BranchHead')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-branchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-branchHead" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list branchHead">
			
				<g:if test="${branchHeadInstance?.bankRegion}">
				<li class="fieldcontain">
					<span id="bankRegion-label" class="property-label"><g:message code="branchHead.bankRegion.label" default="Bank Region" /></span>
					
						<span class="property-value" aria-labelledby="bankRegion-label"><g:link controller="bankRegion" action="show" id="${branchHeadInstance?.bankRegion?.id}">${branchHeadInstance?.bankRegion?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadInstance?.branchHeadCode}">
				<li class="fieldcontain">
					<span id="branchHeadCode-label" class="property-label"><g:message code="branchHead.branchHeadCode.label" default="Branch Head Code" /></span>
					
						<span class="property-value" aria-labelledby="branchHeadCode-label"><g:fieldValue bean="${branchHeadInstance}" field="branchHeadCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadInstance?.branchHeadName}">
				<li class="fieldcontain">
					<span id="branchHeadName-label" class="property-label"><g:message code="branchHead.branchHeadName.label" default="Branch Head Name" /></span>
					
						<span class="property-value" aria-labelledby="branchHeadName-label"><g:fieldValue bean="${branchHeadInstance}" field="branchHeadName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${branchHeadInstance?.branches}">
				<li class="fieldcontain">
					<span id="branches-label" class="property-label"><g:message code="branchHead.branches.label" default="Branches" /></span>
					
						<g:each in="${branchHeadInstance.branches}" var="b">
						<span class="property-value" aria-labelledby="branches-label"><g:link controller="branch" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${branchHeadInstance?.id}" />
					<g:link class="edit" action="edit" id="${branchHeadInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
