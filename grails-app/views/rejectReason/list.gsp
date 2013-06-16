
<%@ page import="cashmanagement.RejectReason" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'rejectReason.label', default: 'RejectReason')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-rejectReason" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-rejectReason" ng-controller="rejectReasonController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.RejectReason}" showCommand="false">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="rejectReason" title="${entityName}">
                <rg:fields bean="${new cashmanagement.RejectReason()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.RejectReason}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openRejectReasonCreateDialog()" value="${message(code: "create")}"/>
            <input type="button" ng-click="openRejectReasonEditDialog()" value="${message(code: "edit")}"/>
        </div>
    </body>
</html>
