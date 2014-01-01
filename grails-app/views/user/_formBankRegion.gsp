<%@ page import="cashmanagement.BranchHead; cashmanagement.User" %>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="user.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${userInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
    <label for="username">
        <g:message code="user.username.label" default="Username"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="username" required="" value="${userInstance?.username}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branch', 'error')}">
    <label for="branch">
        <g:message code="user.branch.label" default="Branch"/>
    </label>
    <g:select name="branchId" from="${cashmanagement.Branch.findAllByBranchHeadInList(BranchHead.findAllByBankRegion(bankRegion))}" optionKey="id" value="${branch?.id}"
              class="many-to-one" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branchHead', 'error')}">
    <label for="branchHead">
        <g:message code="user.branchHead.label" default="BranchHead"/>
    </label>
    <g:select name="branchHeadId" from="${cashmanagement.BranchHead.findAllByBankRegion(bankRegion)}" optionKey="id" value="${branchHead?.id}"
              class="many-to-one" noSelection="['': '']"/>
</div>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'basicInformation', 'error')} required">
    <label for="enabled">
        <g:message code="user.enabled.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="enabled" required="" value="${userInstance?.enabled}"/>
</div>
