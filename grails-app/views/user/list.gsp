<%@ page import="org.hibernate.criterion.CriteriaSpecification; cashmanagement.BranchHeadRole; cashmanagement.BranchHead; cashmanagement.BranchRole; cashmanagement.Role; cashmanagement.Branch; cashmanagement.User" %>
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
    <g:set var="colCount" value="6"/>
    <rg:criteria inline="true">
        <c:isBranchHeadUser>
            <rg:alias name='authorities' value='authorities'/>
            <rg:alias name='authorities.branch' value='branch' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='branch.branchHead' value='bbranchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:eq name="bbranchHead.id" value='${branchHead.id}' hidden='true'/>
            <rg:eq name="branch.id" from='${cashmanagement.Branch.findAllByBranchHead(branchHead)}' noSelection="['':'']" label='branch'/>
            <rg:eq name="branch.branchCode"/>
            <g:set var="colCount" value="4"/>
        </c:isBranchHeadUser>
        <c:isBankRegionUser>
            <rg:alias name='authorities' value='authorities'/>
            <rg:alias name='authorities.branch' value='branch' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='branch.branchHead' value='bbranchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='bbranchHead.bankRegion' value='bbankRegion' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='authorities.branchHead' value='branchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='branchHead.bankRegion' value='bankRegion' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:eq name="branchHead.id" from='${cashmanagement.BranchHead.findAllByBankRegion(bankRegion)}' noSelection="['':'']" label='branchHead'/>
            <rg:eq name="branch.id" from='${cashmanagement.Branch.findAllByBranchHeadInList(BranchHead.findAllByBankRegion(bankRegion))}' noSelection="['':'']" label='branch'/>
            <rg:eq name="branch.branchCode"/>
            <rg:or>
                <rg:eq name="bankRegion.id" value='${bankRegion.id}' hidden='true'/>
                <rg:eq name="bbankRegion.id" value='${bankRegion.id}' hidden='true'/>
            </rg:or>
            <g:set var="colCount" value="5"/>
        </c:isBankRegionUser>
        <c:isAdmin>
            <rg:alias name='authorities' value='authorities'/>
            <rg:alias name='authorities.branch' value='branch' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='authorities.branchHead' value='branchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:alias name='authorities.bankRegion' value='bankRegion' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
            <rg:eq name="bankRegion.id" from='${cashmanagement.BankRegion.list()}' noSelection="['':'']" label='bankRegion'/>
            <rg:eq name="branchHead.id" from='${cashmanagement.BranchHead.list()}' noSelection="['':'']" label='branchHead'/>
            <rg:eq name="branch.id" from='${cashmanagement.Branch.list()}' noSelection="['':'']" label='branch'/>
            <rg:eq name="branch.branchCode"/>
        </c:isAdmin>
        <rg:like name='name' label='user.name'/>
        <rg:like name='username' label='user.username'/>
        <rg:filterGrid grid="UserGrid"/>
    </rg:criteria>
    <rg:grid domainClass="${cashmanagement.User}"
             showCommand="false"
             maxColumns="${colCount}"
             commands="[[handler: 'addToGrid(#id#)', icon: 'application_edit', title: message(code: 'edit')], [handler: 'changepass(#id#)', icon: 'application_key', title: message(code: 'changepass')]]">
        <c:isBranchHeadUser>
            <rg:criteria>
                <rg:alias name='authorities' value='authorities'/>
                <rg:alias name='authorities.branch' value='branch' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:alias name='branch.branchHead' value='bbranchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:eq name="bbranchHead.id" value='${branchHead.id}' hidden='true'/>
            </rg:criteria>
        </c:isBranchHeadUser>
        <c:isBankRegionUser>
            <rg:criteria>
                <rg:alias name='authorities' value='authorities'/>
                <rg:alias name='authorities.branch' value='branch' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:alias name='branch.branchHead' value='bbranchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:alias name='bbranchHead.bankRegion' value='bbankRegion' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:alias name='authorities.branchHead' value='branchHead' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:alias name='branchHead.bankRegion' value='bankRegion' thirdParam='${CriteriaSpecification.LEFT_JOIN}'/>
                <rg:or>
                    <rg:eq name="bankRegion.id" value='${bankRegion.id}' hidden='true'/>
                    <rg:eq name="bbankRegion.id" value='${bankRegion.id}' hidden='true'/>
                </rg:or>
            </rg:criteria>
        </c:isBankRegionUser>
    </rg:grid>
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
