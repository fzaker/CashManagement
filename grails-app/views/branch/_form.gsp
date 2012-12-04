<%@ page import="cashmanagement.Branch" %>



<div class="fieldcontain ${hasErrors(bean: branchInstance, field: 'branchHead', 'error')} required">
	<label for="branchHead">
		<g:message code="branch.branchHead.label" default="Branch Head" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branchHead" name="branchHead.id" from="${cashmanagement.BranchHead.list()}" optionKey="id" required="" value="${branchInstance?.branchHead?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchInstance, field: 'branchCode', 'error')} ">
	<label for="branchCode">
		<g:message code="branch.branchCode.label" default="Branch Code" />
		
	</label>
	<g:textField name="branchCode" value="${branchInstance?.branchCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchInstance, field: 'branchName', 'error')} ">
	<label for="branchName">
		<g:message code="branch.branchName.label" default="Branch Name" />
		
	</label>
	<g:textField name="branchName" value="${branchInstance?.branchName}"/>
</div>

