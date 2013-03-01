<%@ page import="cashmanagement.SystemParameters" %>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'gheyreTabserei', 'error')} ">
    <label for="gheyreTabserei">
        <g:message code="systemParameters.gheyreTabserei.label" default="Gheyre Tabserei" />

    </label>
    <g:select id="gheyreTabserei" name="gheyreTabserei.id" from="${cashmanagement.LoanGroup.list()}" optionKey="id" value="${systemParametersInstance?.gheyreTabserei?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'tabserei', 'error')} ">
    <label for="tabserei">
        <g:message code="systemParameters.tabserei.label" default="Tabserei" />

    </label>
    <g:select id="tabserei" name="tabserei.id" from="${cashmanagement.LoanGroup.list()}" optionKey="id" value="${systemParametersInstance?.tabserei?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'gharzolhasane', 'error')} ">
    <label for="gharzolhasane">
        <g:message code="systemParameters.gharzolhasane.label" default="Gharzolhasane" />

    </label>
    <g:select id="gharzolhasane" name="gharzolhasane.id" from="${cashmanagement.LoanGroup.list()}" optionKey="id" value="${systemParametersInstance?.gharzolhasane?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

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

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'numofDays', 'error')} required">
	<label for="numofDays">
		<g:message code="systemParameters.numofDays.label" default="Numof Days" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numofDays" required="" value="${systemParametersInstance.numofDays}"/>
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

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'gharzolHasaneCentralBankPercent', 'error')} required">
	<label for="ghCentralBankPercent">
		<g:message code="systemParameters.gharzolHasaneCentralBankPercent.label" default="Gharzol Hasane Central Bank Percent" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ghCentralBankPercent" step="any" required="" value="${systemParametersInstance.ghCentralBankPercent}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: systemParametersInstance, field: 'gharzolHasaneMonthlyPercent', 'error')} required">
	<label for="ghMonthlyPercent">
		<g:message code="systemParameters.gharzolHasaneMonthlyPercent.label" default="Gharzol Hasane Monthly Percent" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ghMonthlyPercent" step="any" required="" value="${systemParametersInstance.ghMonthlyPercent}"/>
</div>



