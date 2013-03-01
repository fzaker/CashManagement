<%@ page import="cashmanagement.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                           default="Skip to content&hellip;"/></a>
<g:javascript plugin="rapid-grails" src="jquery.form.js"></g:javascript>
<div id="list-user" class="content scaffold-list" role="main">
    <rg:grid domainClass="${cashmanagement.User}"
             showCommand="false"
             commands="[[handler: 'addToGrid(#id#)', icon: 'application_edit']]"
             toolbarCommands="[[icon: 'plus', caption: message(code:'create'), function: 'addToGrid']]"></rg:grid>
    <g:javascript>
                function addToGrid(id){
                var url='<g:createLink action="form"/>';
                    var save='<g:createLink action="save"/>'
                if(id){
                    url+="/"+id
                    save+="/"+id
                    }
                    loadOverlay(url,save,function(){
                        $("#UserGrid").trigger("reloadGrid")
                    })
                }
    </g:javascript>
</div>
</body>
</html>
