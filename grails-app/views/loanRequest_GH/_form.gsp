<%@ page import="cashmanagement.LoanRequest_GH" %>



<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'loanNo', 'error')} ">
	<label for="loanNo">
		<g:message code="loanRequest_GH.loanNo.label" default="Loan No" />
		
	</label>
	<g:textField name="loanNo" value="${loanRequest_GHInstance?.loanNo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'loanIDCode', 'error')} ">
	<label for="loanIDCode">
		<g:message code="loanRequest_GH.loanIDCode.label" default="Loan IDC ode" />
		
	</label>
	<g:textField name="loanIDCode" value="${loanRequest_GHInstance?.loanIDCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'loanType', 'error')} required">
	<label for="loanType">
		<g:message code="loanRequest_GH.loanType.label" default="Loan Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="loanType" name="loanType.id" from="${cashmanagement.LoanType.list()}" optionKey="id" required="" value="${loanRequest_GHInstance?.loanType?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'loanAmount', 'error')} required">
	<label for="loanAmount">
		<g:message code="loanRequest_GH.loanAmount.label" default="Loan Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="loanAmount" required="" value="${loanRequest_GHInstance.loanAmount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'requestDate', 'error')} required">
	<label for="requestDate">
		<g:message code="loanRequest_GH.requestDate.label" default="Request Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="requestDate" precision="day"  value="${loanRequest_GHInstance?.requestDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'loanRequestStatus', 'error')} required">
	<label for="loanRequestStatus">
		<g:message code="loanRequest_GH.loanRequestStatus.label" default="Loan Request Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="loanRequestStatus" from="${loanRequest_GHInstance.constraints.loanRequestStatus.inList}" required="" value="${fieldValue(bean: loanRequest_GHInstance, field: 'loanRequestStatus')}" valueMessagePrefix="loanRequest_GH.loanRequestStatus"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanRequest_GHInstance, field: 'branch', 'error')} required">
	<label for="branch">
		<g:message code="loanRequest_GH.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branch" name="branch.id" from="${cashmanagement.Branch.list()}" optionKey="id" required="" value="${loanRequest_GHInstance?.branch?.id}" class="many-to-one"/>
</div>

