<%@ page import="cashmanagement.BankRegion" %>



<div class="fieldcontain ${hasErrors(bean: bankRegionInstance, field: 'bankRegionCode', 'error')} ">
	<label for="bankRegionCode">
		<g:message code="bankRegion.bankRegionCode.label" default="Bank Region Code" />
		
	</label>
	<g:textField name="bankRegionCode" value="${bankRegionInstance?.bankRegionCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bankRegionInstance, field: 'bankRegionName', 'error')} ">
	<label for="bankRegionName">
		<g:message code="bankRegion.bankRegionName.label" default="Bank Region Name" />
		
	</label>
	<g:textField name="bankRegionName" value="${bankRegionInstance?.bankRegionName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bankRegionInstance, field: 'branchHeads', 'error')} ">
	<label for="branchHeads">
		<g:message code="bankRegion.branchHeads.label" default="Branch Heads" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${bankRegionInstance?.branchHeads?}" var="b">
    <li><g:link controller="branchHead" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="branchHead" action="create" params="['bankRegion.id': bankRegionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'branchHead.label', default: 'BranchHead')])}</g:link>
</li>
</ul>

</div>

