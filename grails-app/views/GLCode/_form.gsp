<%@ page import="cashmanagement.GLCode" %>



<div class="fieldcontain ${hasErrors(bean: GLCodeInstance, field: 'glGroup', 'error')} required">
	<label for="glGroup">
		<g:message code="GLCode.glGroup.label" default="Gl Group" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="glGroup" name="glGroup.id" from="${cashmanagement.GLGroup.list()}" optionKey="id" required="" value="${GLCodeInstance?.glGroup?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: GLCodeInstance, field: 'glCode', 'error')} ">
	<label for="glCode">
		<g:message code="GLCode.glCode.label" default="Gl Code" />
		
	</label>
	<g:textField name="glCode" value="${GLCodeInstance?.glCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: GLCodeInstance, field: 'glFlag', 'error')} required">
	<label for="glFlag">
		<g:message code="GLCode.glFlag.label" default="Gl Flag" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="glFlag" from="${GLCodeInstance.constraints.glFlag.inList}" required="" value="${fieldValue(bean: GLCodeInstance, field: 'glFlag')}" valueMessagePrefix="GLCode.glFlag"/>
</div>

