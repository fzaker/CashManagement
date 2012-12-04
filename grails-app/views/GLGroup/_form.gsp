<%@ page import="cashmanagement.GLGroup" %>



<div class="fieldcontain ${hasErrors(bean: GLGroupInstance, field: 'glGroupCode', 'error')} ">
	<label for="glGroupCode">
		<g:message code="GLGroup.glGroupCode.label" default="Gl Group Code" />
		
	</label>
	<g:textField name="glGroupCode" value="${GLGroupInstance?.glGroupCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: GLGroupInstance, field: 'glGroupName', 'error')} ">
	<label for="glGroupName">
		<g:message code="GLGroup.glGroupName.label" default="Gl Group Name" />
		
	</label>
	<g:textField name="glGroupName" value="${GLGroupInstance?.glGroupName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: GLGroupInstance, field: 'glCodes', 'error')} ">
	<label for="glCodes">
		<g:message code="GLGroup.glCodes.label" default="Gl Codes" />
		
	</label>
	<g:select name="glCodes" from="${cashmanagement.GLCode.list()}" multiple="multiple" optionKey="id" size="5" value="${GLGroupInstance?.glCodes*.id}" class="many-to-many"/>
</div>

