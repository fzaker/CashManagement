<%@ page import="cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-loanRequest_NT" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                     default="Skip to content&hellip;"/></a>

<div id="list-loanRequest_NT" class="content scaffold-list" role="main">

    <rg:grid domainClass="${cashmanagement.LoanRequestNT_BankRegion}"
             showCommand="false"
             firstColumnWidth="30"
             commands="${[[handler: 'reject(#id#)', icon: 'cancel'], [handler: 'accept(#id#)', icon: 'arrow_turn_left']]}">
        <rg:criteria>
            <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
            <rg:nest name="loanRequest_nt">
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:nest name="bankRegion">
                            <rg:eq name="id" value="${bankRegion?.id}"/>
                        </rg:nest>
                    </rg:nest>
                </rg:nest>
            </rg:nest>
        </rg:criteria>
    </rg:grid>

    <rg:grid domainClass="${cashmanagement.Branch}"
             showCommand="false">
        <rg:criteria>
            <rg:nest name="branchHead">
                <rg:nest name="bankRegion">
                    <rg:eq name="id" value="${bankRegion?.id}"/>
                </rg:nest>
            </rg:nest>
        </rg:criteria>
    </rg:grid>

    <button onclick="linkRequest()"><g:message code="link-request" /></button>

    <g:javascript>
        function linkRequest(){
            var reqId=$("#LoanRequestNT_BankRegionGrid").getGridParam('selrow')
            var branchId=$("#BranchGrid").getGridParam('selrow')
            if(!reqId){
                alert("<g:message code="please-select-a-request" />")
                return false;
            }
            if(!branchId){
                alert("<g:message code="please-select-a-branch" />")
                return false;
            }
            $.ajax({
                url:'<g:createLink action="linkBranchRequestRegion" />',
                data:{
                 branchId:branchId,
                 reqId:reqId
                }
            }).done(function (response) {
                alert(response)
                $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                $("#BranchGrid").trigger("reloadGrid")
            })
        }
        function reject(id){
            if(confirm('<g:message code="are.you.sure.to.reject.reuqest"/>')){
                $.ajax({
                    type:'post',
                    url:'<g:createLink action="rejectBankRegion"/>',
                    data:{id:id}
                }).success(function(){
                    $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                })
            }
        }
        function accept(id){
            if(confirm('<g:message code="are.you.sure.to.accept.reuqest"/>')){
                $.ajax({
                    type:'post',
                    url:'<g:createLink action="acceptBankRegion"/>',
                    data:{id:id}
                }).success(function(){
                    $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                })
            }
        }
    </g:javascript>
</div>
</body>
</html>
