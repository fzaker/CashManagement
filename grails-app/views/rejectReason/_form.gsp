<%@ page import="cashmanagement.RejectReason" %>



<div class="fieldcontain ${hasErrors(bean: rejectReasonInstance, field: 'code', 'error')} ">
	<label for="code">
		<g:message code="rejectReason.code.label" default="Code" />
		
	</label>
	<g:textField name="code" value="${rejectReasonInstance?.code}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rejectReasonInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="rejectReason.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${rejectReasonInstance?.title}"/>
</div>

