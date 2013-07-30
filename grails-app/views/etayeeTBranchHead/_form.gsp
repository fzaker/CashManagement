<%@ page import="cashmanagement.EtayeeTBranchHead" %>



<div class="fieldcontain ${hasErrors(bean: etayeeTBranchHeadInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="etayeeTBranchHead.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" required="" value="${etayeeTBranchHeadInstance.amount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: etayeeTBranchHeadInstance, field: 'branchHead', 'error')} required">
	<label for="branchHead">
		<g:message code="etayeeTBranchHead.branchHead.label" default="Branch Head" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branchHead" name="branchHead.id" from="${cashmanagement.BranchHead.list()}" optionKey="id" required="" value="${etayeeTBranchHeadInstance?.branchHead?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: etayeeTBranchHeadInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="etayeeTBranchHead.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${etayeeTBranchHeadInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: etayeeTBranchHeadInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="etayeeTBranchHead.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${cashmanagement.User.list()}" optionKey="id" required="" value="${etayeeTBranchHeadInstance?.user?.id}" class="many-to-one"/>
</div>

