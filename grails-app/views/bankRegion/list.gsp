
<%@ page import="cashmanagement.BankRegion" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bankRegion.label', default: 'BankRegion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-bankRegion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-bankRegion" ng-controller="bankRegionController" class="content scaffold-list" role="main">
            <rg:grid domainClass="${cashmanagement.BankRegion}">
                <rg:commands>
                    <rg:deleteCommand/>
                </rg:commands>
            </rg:grid>
            <rg:dialog id="bankRegion" title="BankRegion Dialog">
                <rg:fields bean="${new cashmanagement.BankRegion()}"></rg:fields>
                <rg:saveButton domainClass="${cashmanagement.BankRegion}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="openBankRegionCreateDialog()" value="Create BankRegion"/>
            <input type="button" ng-click="openBankRegionEditDialog()" value="Edit BankRegion"/>
        </div>
    </body>
</html>
