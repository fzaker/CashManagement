<%@ page import="cashmanagement.ResourceReadyBranch" %>



<div class="fieldcontain ${hasErrors(bean: resourceReadyBranchInstance, field: 'availableAmount', 'error')} required">
	<label for="availableAmount">
		<g:message code="resourceReadyBranch.availableAmount.label" default="Available Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="availableAmount" step="any" required="" value="${resourceReadyBranchInstance.availableAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceReadyBranchInstance, field: 'branchCode', 'error')} ">
	<label for="branchCode">
		<g:message code="resourceReadyBranch.branchCode.label" default="Branch Code" />
		
	</label>
	<g:textField name="branchCode" value="${resourceReadyBranchInstance?.branchCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceReadyBranchInstance, field: 'branchName', 'error')} ">
	<label for="branchName">
		<g:message code="resourceReadyBranch.branchName.label" default="Branch Name" />
		
	</label>
	<g:textField name="branchName" value="${resourceReadyBranchInstance?.branchName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceReadyBranchInstance, field: 'selfUsed', 'error')} required">
	<label for="selfUsed">
		<g:message code="resourceReadyBranch.selfUsed.label" default="Self Used" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="selfUsed" step="any" required="" value="${resourceReadyBranchInstance.selfUsed}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resourceReadyBranchInstance, field: 'transfered', 'error')} required">
	<label for="transfered">
		<g:message code="resourceReadyBranch.transfered.label" default="Transfered" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="transfered" step="any" required="" value="${resourceReadyBranchInstance.transfered}"/>
</div>

