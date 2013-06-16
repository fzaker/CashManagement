<%@ page import="cashmanagement.LoanType" %>



<div class="fieldcontain ${hasErrors(bean: loanTypeInstance, field: 'loanGroup', 'error')} required">
	<label for="loanGroup">
		<g:message code="loanType.loanGroup.label" default="Loan Group" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="loanGroup" name="loanGroup.id" from="${cashmanagement.LoanGroup.list()}" optionKey="id" required="" value="${loanTypeInstance?.loanGroup?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanTypeInstance, field: 'loanTypeCode', 'error')} ">
	<label for="loanTypeCode">
		<g:message code="loanType.loanTypeCode.label" default="Loan Type Code" />
		
	</label>
	<g:textField name="loanTypeCode" value="${loanTypeInstance?.loanTypeCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanTypeInstance, field: 'loanTypeName', 'error')} ">
	<label for="loanTypeName">
		<g:message code="loanType.loanTypeName.label" default="Loan Type Name" />
		
	</label>
	<g:textField name="loanTypeName" value="${loanTypeInstance?.loanTypeName}"/>
</div>

