<%@ page import="cashmanagement.LoanGroup" %>



<div class="fieldcontain ${hasErrors(bean: loanGroupInstance, field: 'loanGroupCode', 'error')} ">
	<label for="loanGroupCode">
		<g:message code="loanGroup.loanGroupCode.label" default="Loan Group Code" />
		
	</label>
	<g:textField name="loanGroupCode" value="${loanGroupInstance?.loanGroupCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanGroupInstance, field: 'loanGroupName', 'error')} ">
	<label for="loanGroupName">
		<g:message code="loanGroup.loanGroupName.label" default="Loan Group Name" />
		
	</label>
	<g:textField name="loanGroupName" value="${loanGroupInstance?.loanGroupName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loanGroupInstance, field: 'loanTypes', 'error')} ">
	<label for="loanTypes">
		<g:message code="loanGroup.loanTypes.label" default="Loan Types" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${loanGroupInstance?.loanTypes?}" var="l">
    <li><g:link controller="loanType" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="loanType" action="create" params="['loanGroup.id': loanGroupInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'loanType.label', default: 'LoanType')])}</g:link>
</li>
</ul>

</div>

