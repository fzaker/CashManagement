<%@ page import="cashmanagement.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<a href="#edit-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="edit-user" class="content scaffold-edit" role="main">
    <h1><g:message code="changepass"  /></h1>
    <div class="message" role="status">${flash.message}</div>
    <g:form method="post" >
        <fieldset class="form">
            <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
                <label for="password">
                    <g:message code="user.password.label" default="Username"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:passwordField name="password" required="" />
            </div>
            <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
                <label for="repassword">
                    <g:message code="user.repassword.label" default="Username"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:passwordField name="repassword" required="" />
            </div>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="save" action="savepassuser" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </fieldset>
    </g:form>
</div>
</body>
</html>
