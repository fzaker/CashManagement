<%@ page import="cashmanagement.User" %>


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

%{--<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">--}%
%{--<label for="password">--}%
%{--<g:message code="user.password.label" default="Password" />--}%
%{--<span class="required-indicator">*</span>--}%
%{--</label>--}%
%{--<g:textField name="password" required="" value=""/>--}%
%{--</div>--}%


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branch', 'error')}">
    <label for="branch">
        <g:message code="user.branch.label" default="Branch"/>
    </label>
    <g:select name="branchId" from="${cashmanagement.Branch.list()}" optionKey="id" value="${branch?.id}"
              class="many-to-one" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branchHead', 'error')}">
    <label for="branchHead">
        <g:message code="user.branchHead.label" default="branchHead"/>
    </label>
    <g:select name="branchHeadId" from="${cashmanagement.BranchHead.list()}" optionKey="id" value="${branchHead?.id}"
              class="many-to-one" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'bankRegion', 'error')}">
    <label for="bankRegion">
        <g:message code="user.bankRegion.label" default="bankRegion"/>
    </label>
    <g:select name="bankRegionId" from="${cashmanagement.BankRegion.list()}" optionKey="id" value="${bankRegion?.id}"
              class="many-to-one" noSelection="['': '']"/>
</div>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'isAdmin', 'error')} required">
    <label for="isAdmin">
        <g:message code="user.isAdmin.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="isAdmin" required="" value="${userInstance?.isAdmin}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'basicInformation', 'error')} required">
    <label for="basicInformation">
        <g:message code="user.basicInformation.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="basicInformation" required="" value="${userInstance?.basicInformation}"/>
</div>

<div class="fieldcontain required">
    <label for="basicInformation">
        <g:message code="user.nt.label"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="ntabsare" required="" value="${userInstance?.ntabsare}"/>
</div>


<div class="fieldcontain required">
    <label for="basicInformation">
        <g:message code="user.t.label"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="tabsare" required="" value="${userInstance?.tabsare}"/>
</div>


<div class="fieldcontain required">
    <label for="basicInformation">
        <g:message code="user.gh.label"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="gharzolhasane" required="" value="${userInstance?.gharzolhasane}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'basicInformation', 'error')} required">
    <label for="enabled">
        <g:message code="user.enabled.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>
    <g:checkBox name="enabled" required="" value="${userInstance?.enabled}"/>
</div>
