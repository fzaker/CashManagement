<%@ page import="cashmanagement.PermissionAmount_T" %>



<div class="fieldcontain ${hasErrors(bean: permissionAmount_TInstance, field: 'branch', 'error')} required">
	<label for="branch">
		<g:message code="permissionAmount_T.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branch" name="branch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${permissionAmount_TInstance?.branch?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: permissionAmount_TInstance, field: 'permAmount', 'error')} required">
	<label for="permAmount">
		<g:message code="permissionAmount_T.permAmount.label" default="Perm Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="permAmount" step="any" required="" value="${permissionAmount_TInstance.permAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: permissionAmount_TInstance, field: 'year', 'error')} required">
	<label for="year">
		<g:message code="permissionAmount_T.year.label" default="Year" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="year" required="" value="${permissionAmount_TInstance.year}"/>
</div>

