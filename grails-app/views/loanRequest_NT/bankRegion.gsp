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

    <button onclick="linkRequest()"><g:message code="link-request"/></button>
    <br>
    <br>
    <div id="manoto">
        <ul>
            <li>
                <a href="#Confirm"><g:message code="Confirm"/></a>
            </li>
            <li>
                <a href="#Test"><g:message code="Sent"/></a>
            </li>
            <li>
                <a href="#Rejected"><g:message code="Rejected"/></a>
            </li>
        </ul>


        <div id="Confirm">
            <rg:grid domainClass="${cashmanagement.LoanRequestNT_BankRegion}"
                     idPostfix="ConfirmList"
                     showCommand="false"
                     caption="${message(code: "Confirm")}">
                <rg:criteria>
                    <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
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
        </div>

        <div id="Test">
            <rg:grid domainClass="${cashmanagement.LoanRequestNT_BankRegion}"
                     idPostfix="SentList"
                     showCommand="false"
                     caption="${message(code: "Sent")}">
                <rg:criteria>
                    <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Sent}"/>
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
        </div>

        <div id="Rejected">
            <rg:grid domainClass="${cashmanagement.LoanRequestNT_BankRegion}"
                     idPostfix="RejectedList"
                     showCommand="false"
                     caption="${message(code: "Rejected")}">
                <rg:criteria>
                    <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
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
        </div>
    </div>
    <g:javascript>
        function linkRequest(){
            var reqId=$("#LoanRequestNT_BankRegionGrid").getGridParam('selrow')
            var branchId=$("#BranchGrid").getGridParam('selrow')
            if(!reqId){
                alert("<g:message code="please-select-a-request"/>")
                return false;
            }
            if(!branchId){
                alert("<g:message code="please-select-a-branch"/>")
                return false;
            }
            var amt=prompt("<g:message code="please-enter-amount"/>")
            $.ajax({
                url:'<g:createLink action="linkBranchRequestRegion"/>',
                data:{
                 branchId:branchId,
                 reqId:reqId,
                 amt:amt
                }
            }).done(function (response) {
                alert(response)
                $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                $("#BranchGrid").trigger("reloadGrid")
                $("#LoanRequestNT_BankRegionConfirmListGrid").trigger("reloadGrid")
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
                    $("#LoanRequestNT_BankRegionRejectedListGrid").trigger("reloadGrid")
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
                    $("#LoanRequestNT_BankRegionSentListGrid").trigger("reloadGrid")
                })
            }
        }
        $(function() {
            $( "#manoto" ).tabs();
        });
    </g:javascript>
</div>
</body>
</html>
