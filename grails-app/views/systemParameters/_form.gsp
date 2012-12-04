<%@ page import="cashmanagement.SystemParameters" %>



<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'maxGrowth', 'error')} required">
	<label for="maxGrowth">
		<g:message code="systemParameters.maxGrowth.label" default="Max Growth" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="maxGrowth" step="any" required="" value="${systemParametersInstance.maxGrowth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'minGrowth', 'error')} required">
	<label for="minGrowth">
		<g:message code="systemParameters.minGrowth.label" default="Min Growth" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="minGrowth" step="any" required="" value="${systemParametersInstance.minGrowth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'permitToward', 'error')} required">
	<label for="permitToward">
		<g:message code="systemParameters.permitToward.label" default="Permit Toward" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="permitToward" step="any" required="" value="${systemParametersInstance.permitToward}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'permitReceivePercent', 'error')} required">
	<label for="permitReceivePercent">
		<g:message code="systemParameters.permitReceivePercent.label" default="Permit Receive Percent" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="permitReceivePercent" step="any" required="" value="${systemParametersInstance.permitReceivePercent}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'permitReceiveDaysNum', 'error')} required">
	<label for="permitReceiveDaysNum">
		<g:message code="systemParameters.permitReceiveDaysNum.label" default="Permit Receive Days Num" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="permitReceiveDaysNum" step="any" required="" value="${systemParametersInstance.permitReceiveDaysNum}"/>
</div>

