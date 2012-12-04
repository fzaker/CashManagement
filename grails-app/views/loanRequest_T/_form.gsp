<%@ page import="cashmanagement.LoanRequest_T" %>



<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'loanNo', 'error')} ">
	<label for="loanNo">
		<g:message code="loanRequest_T.loanNo.label" default="Loan No" />
		
	</label>
	<g:textField name="loanNo" value="${loanRequest_TInstance?.loanNo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'loanIDCode', 'error')} ">
	<label for="loanIDCode">
		<g:message code="loanRequest_T.loanIDCode.label" default="Loan IDC ode" />
		
	</label>
	<g:textField name="loanIDCode" value="${loanRequest_TInstance?.loanIDCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'loanType', 'error')} required">
	<label for="loanType">
		<g:message code="loanRequest_T.loanType.label" default="Loan Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="loanType" name="loanType.id" from="${cashmanagement.LoanType.list()}" optionKey="id" required="" value="${loanRequest_TInstance?.loanType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'loanAmount', 'error')} required">
	<label for="loanAmount">
		<g:message code="loanRequest_T.loanAmount.label" default="Loan Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="loanAmount" required="" value="${loanRequest_TInstance.loanAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'requestDate', 'error')} required">
	<label for="requestDate">
		<g:message code="loanRequest_T.requestDate.label" default="Request Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="requestDate" precision="day"  value="${loanRequest_TInstance?.requestDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'loanRequestStatus', 'error')} required">
	<label for="loanRequestStatus">
		<g:message code="loanRequest_T.loanRequestStatus.label" default="Loan Request Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="loanRequestStatus" from="${loanRequest_TInstance.constraints.loanRequestStatus.inList}" required="" value="${fieldValue(bean: loanRequest_TInstance, field: 'loanRequestStatus')}" valueMessagePrefix="loanRequest_T.loanRequestStatus"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_TInstance, field: 'branch', 'error')} required">
	<label for="branch">
		<g:message code="loanRequest_T.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branch" name="branch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${loanRequest_TInstance?.branch?.id}" class="many-to-one"/>
</div>

