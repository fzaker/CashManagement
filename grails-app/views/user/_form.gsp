<%@ page import="cashmanagement.User" %>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="user.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${userInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userInstance?.password}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branch', 'error')}">
	<label for="branch">
		<g:message code="user.branch.label" default="Branch" />
	</label>
	<g:select name="branchId" from="${cashmanagement.Branch.list()}" optionKey="id" value="${branch?.id}" class="many-to-one" noSelection="['':'']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branchHead', 'error')}">
    <label for="branchHead">
        <g:message code="user.branchHead.label" default="branchHead" />
    </label>
    <g:select name="branchHeadId" from="${cashmanagement.BranchHead.list()}" optionKey="id"  value="${branchHead?.id}" class="many-to-one" noSelection="['':'']"/>
</div>
<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'bankRegion', 'error')}">
    <label for="bankRegion">
        <g:message code="user.bankRegion.label" default="bankRegion" />
    </label>
    <g:select name="bankRegionId" from="${cashmanagement.BankRegion.list()}" optionKey="id" value="${bankRegion?.id}" class="many-to-one" noSelection="['':'']"/>
</div>

