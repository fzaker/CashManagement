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
    <g:set var="jsonurl" value="${createLink(controller: "rapidGrails",action: "jsonList",params: [domainClass:User.class.name,maxColumns:6])}"/>
    <g:set var="colCount" value="6"/>
    <c:isBranchHeadUser>
        <g:set var="jsonurl" value="${createLink(controller: "user",action: "jsonList")}"/>
        <g:set var="colCount" value="4"/>
    </c:isBranchHeadUser>
    <rg:grid url="${jsonurl}" domainClass="${cashmanagement.User}"
             showCommand="false"
             maxColumns="${colCount}"
             commands="[[handler: 'addToGrid(#id#)', icon: 'application_edit',title:message(code: 'edit')], [handler: 'changepass(#id#)', icon: 'application_key',title:message(code: 'changepass')]]"></rg:grid>
    <input type="button" onclick="addToGrid()" value="${message(code: "create")}"/>
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
        function changepass(id){
                var url='<g:createLink action="password"/>';
                    var save='<g:createLink action="savepass"/>'
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
