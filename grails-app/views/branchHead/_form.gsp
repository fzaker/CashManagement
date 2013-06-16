<%@ page import="cashmanagement.BranchHead" %>



<div class="fieldcontain ${hasErrors(bean: branchHeadInstance, field: 'bankRegion', 'error')} required">
	<label for="bankRegion">
		<g:message code="branchHead.bankRegion.label" default="Bank Region" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="bankRegion" name="bankRegion.id" from="${cashmanagement.BankRegion.list()}" optionKey="id" required="" value="${branchHeadInstance?.bankRegion?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadInstance, field: 'branchHeadCode', 'error')} ">
	<label for="branchHeadCode">
		<g:message code="branchHead.branchHeadCode.label" default="Branch Head Code" />
		
	</label>
	<g:textField name="branchHeadCode" value="${branchHeadInstance?.branchHeadCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadInstance, field: 'branchHeadName', 'error')} ">
	<label for="branchHeadName">
		<g:message code="branchHead.branchHeadName.label" default="Branch Head Name" />
		
	</label>
	<g:textField name="branchHeadName" value="${branchHeadInstance?.branchHeadName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: branchHeadInstance, field: 'branches', 'error')} ">
	<label for="branches">
		<g:message code="branchHead.branches.label" default="Branches" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${branchHeadInstance?.branches?}" var="b">
    <li><g:link controller="branch" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="branch" action="create" params="['branchHead.id': branchHeadInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'branch.label', default: 'Branch')])}</g:link>
</li>
</ul>

</div>

