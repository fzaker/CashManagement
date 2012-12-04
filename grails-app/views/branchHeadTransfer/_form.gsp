<%@ page import="cashmanagement.BranchHeadTransfer" %>



<div class="fieldcontain ${hasErrors(bean: branchHeadTransferInstance, field: 'sourceBranch', 'error')} required">
	<label for="sourceBranch">
		<g:message code="branchHeadTransfer.sourceBranch.label" default="Source Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sourceBranch" name="sourceBranch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${branchHeadTransferInstance?.sourceBranch?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadTransferInstance, field: 'destinationBranch', 'error')} required">
	<label for="destinationBranch">
		<g:message code="branchHeadTransfer.destinationBranch.label" default="Destination Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="destinationBranch" name="destinationBranch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${branchHeadTransferInstance?.destinationBranch?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadTransferInstance, field: 'loanRequest', 'error')} required">
	<label for="loanRequest">
		<g:message code="branchHeadTransfer.loanRequest.label" default="Loan Request" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="loanRequest" name="loanRequest.id" from="${cashmanagement.LoanRequest_NT.list()}" optionKey="id" required="" value="${branchHeadTransferInstance?.loanRequest?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadTransferInstance, field: 'transferDate', 'error')} required">
	<label for="transferDate">
		<g:message code="branchHeadTransfer.transferDate.label" default="Transfer Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transferDate" precision="day"  value="${branchHeadTransferInstance?.transferDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadTransferInstance, field: 'transferAmount', 'error')} required">
	<label for="transferAmount">
		<g:message code="branchHeadTransfer.transferAmount.label" default="Transfer Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="transferAmount" step="any" required="" value="${branchHeadTransferInstance.transferAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadTransferInstance, field: 'transferStatus', 'error')} ">
	<label for="transferStatus">
		<g:message code="branchHeadTransfer.transferStatus.label" default="Transfer Status" />
		
	</label>
	<g:select name="transferStatus" from="${branchHeadTransferInstance.constraints.transferStatus.inList}" value="${branchHeadTransferInstance?.transferStatus}" valueMessagePrefix="branchHeadTransfer.transferStatus" noSelection="['': '']"/>
</div>

