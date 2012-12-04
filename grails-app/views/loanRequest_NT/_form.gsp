<%@ page import="cashmanagement.LoanRequest_NT" %>



<div class="fieldcontain ${hasErrors(bean: loanRequest_NTInstance, field: 'loanNo', 'error')} ">
	<label for="loanNo">
		<g:message code="loanRequest_NT.loanNo.label" default="Loan No" />

	</label>
	<g:textField name="loanNo" value="${loanRequest_NTInstance?.loanNo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_NTInstance, field: 'loanType', 'error')} required">
	<label for="loanType">
		<g:message code="loanRequest_NT.loanType.label" default="Loan Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="loanType" name="loanType.id" from="${cashmanagement.LoanType.list()}" optionKey="id" required="" value="${loanRequest_NTInstance?.loanType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_NTInstance, field: 'loanAmount', 'error')} required">
	<label for="loanAmount">
		<g:message code="loanRequest_NT.loanAmount.label" default="Loan Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="loanAmount" step="any" required="" value="${loanRequest_NTInstance.loanAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_NTInstance, field: 'requestDate', 'error')} required">
	<label for="requestDate">
		<g:message code="loanRequest_NT.requestDate.label" default="Request Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="requestDate" precision="day"  value="${loanRequest_NTInstance?.requestDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_NTInstance, field: 'loanRequestStatus', 'error')} ">
	<label for="loanRequestStatus">
		<g:message code="loanRequest_NT.loanRequestStatus.label" default="Loan Request Status" />

	</label>
	<g:select name="loanRequestStatus" from="${loanRequest_NTInstance.constraints.loanRequestStatus.inList}" value="${loanRequest_NTInstance?.loanRequestStatus}" valueMessagePrefix="loanRequest_NT.loanRequestStatus" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_NTInstance, field: 'branch', 'error')} required">
	<label for="branch">
		<g:message code="loanRequest_NT.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branch" name="branch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${loanRequest_NTInstance?.branch?.id}" class="many-to-one"/>
</div>

