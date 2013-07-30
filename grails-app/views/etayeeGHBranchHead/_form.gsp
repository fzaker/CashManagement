<%@ page import="cashmanagement.EtayeeGHBranchHead" %>



<div class="fieldcontain ${hasErrors(bean: etayeeGHBranchHeadInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="etayeeGHBranchHead.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" required="" value="${etayeeGHBranchHeadInstance.amount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: etayeeGHBranchHeadInstance, field: 'branchHead', 'error')} required">
	<label for="branchHead">
		<g:message code="etayeeGHBranchHead.branchHead.label" default="Branch Head" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="branchHead" name="branchHead.id" from="${cashmanagement.BranchHead.list()}" optionKey="id" required="" value="${etayeeGHBranchHeadInstance?.branchHead?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: etayeeGHBranchHeadInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="etayeeGHBranchHead.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${etayeeGHBranchHeadInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: etayeeGHBranchHeadInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="etayeeGHBranchHead.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${cashmanagement.User.list()}" optionKey="id" required="" value="${etayeeGHBranchHeadInstance?.user?.id}" class="many-to-one"/>
</div>

