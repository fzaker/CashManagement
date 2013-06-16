<%@ page import="cashmanagement.PermissionAmount_GH" %>



<div class="fieldcontain ${hasErrors(bean: permissionAmount_GHInstance, field: 'branch', 'error')} required">
	<label for="branch">
		<g:message code="permissionAmount_GH.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branch" name="branch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${permissionAmount_GHInstance?.branch?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: permissionAmount_GHInstance, field: 'permAmount', 'error')} required">
	<label for="permAmount">
		<g:message code="permissionAmount_GH.permAmount.label" default="Perm Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="permAmount" step="any" required="" value="${permissionAmount_GHInstance.permAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: permissionAmount_GHInstance, field: 'year', 'error')} required">
	<label for="year">
		<g:message code="permissionAmount_GH.year.label" default="Year" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="year" required="" value="${permissionAmount_GHInstance.year}"/>
</div>

