<% import grails.persistence.Event %>
<%=packageName%>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-${domainClass.propertyName}" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-${domainClass.propertyName}" ng-controller="${domainClass.propertyName}Controller" class="content scaffold-list" role="main">
            <rg:grid domainClass="\${${domainClass.fullName}}"></rg:grid>
            <rg:dialog id="${domainClass.propertyName}" title="${domainClass.shortName} Dialog">
                <rg:fields bean="\${new ${domainClass.fullName}()}"></rg:fields>
                <rg:saveButton domainClass="\${${domainClass.fullName}}"/>
                <rg:cancelButton/>
            </rg:dialog>
            <input type="button" ng-click="open${domainClass.shortName}CreateDialog()" value="Create ${domainClass.shortName}"/>
            <input type="button" ng-click="open${domainClass.shortName}EditDialog()" value="Edit ${domainClass.shortName}"/>
        </div>
    </body>
</html>
