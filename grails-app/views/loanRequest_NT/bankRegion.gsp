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
             firstColumnWidth="50"
             maxColumns="9"
             commands="${[[controller:'loanRequest_NT', action:'showRequestDetails',param:'bankRegion=#id#', icon: 'magnifier',title:message(code:'show-details')],[handler: 'reject(#id#)', icon: 'cancel',title:message(code:"reject")], [handler: 'accept(#id#)', icon: 'tick',title:message(code:"confirm")]]}">
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
             showCommand="false"
             groupby="branchHead"
             commands="${[[controller:'loanRequest_NT', action:'showBranchDetails',param:'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]}">
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
                     columns="[[name: 'loanIDCode'], [name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'melliCode'], [name: 'loanAmount'], [name: 'branch']]"
                     commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'bankRegion=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
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
                     commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'bankRegion=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
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
                     columns="[[name:'loanNo'],[name:'loanIDCode'],[name:'loanType'],[name:'loanAmount'],[name:'requestDate'],[name:'rejectReason']]"
                     idPostfix="RejectedList"
                     commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'bankRegion=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
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
    <div id="reject-reason">
        <div class="fieldcontain">
            <g:hiddenField name="loanId"/>
            <label for="rejectReason">
                <g:message code="rejectReason.label" default="Loan No" />
            </label>
            <g:select name="rejectReason" from="${cashmanagement.RejectReason.list()}" optionKey="id"/>
        </div>
        <g:submitButton name="save" value="${message(code: "save.label")}" onclick="rejectSubmit()"/>
    </div>
    <div id="link-amount">
        <div class="fieldcontain">
            <g:hiddenField name="loanId"/>
            <g:hiddenField name="branchId"/>
            <label for="amount">
                <g:message code="amount.label" default="Loan No" />
            </label>
            <g:textField name="amount"/>
        </div>
        <div id="amountValue"></div>
        <g:submitButton name="save" value="${message(code: "save.label")}" onclick="linkRequestSubmit()"/>
    </div>
    <g:javascript>
        function addCommas(nStr)
        {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }
        function linkRequestSubmit(){
            var reqId=$("#LoanRequestNT_BankRegionGrid").getGridParam('selrow')
            var branchId=$("#BranchGrid").getGridParam('selrow')
            var amt=$("#amount").val()
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
                $("#link-amount").dialog("close")
            })
        }
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
             $.ajax({
                url:'<g:createLink action="getRequestBranchHead" />',
                data:{id:reqId},
                success:function(request){
                    if(request.id==branchId){
                        alert("<g:message code="couldnot-link-from-same-branch"/>")
                        return false;
                    }
                    $("#link-amount").dialog("open")
                    $("#amountValue").html('')
                    $("#amount").val('')
                }
            })


        }
         function reject(id){
            $("#loanId").val(id)
            $("#reject-reason").dialog('open')
        }
        function rejectSubmit(){
            $.ajax({
                type:'post',
                url:'<g:createLink action="rejectBankRegion"/>',
                data:{
                    id:$("#loanId").val(),
                    rejectReasonId:$("#rejectReason").val()
                }
            }).success(function(){
                $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                $("#LoanRequestNT_BankRegionRejectedListGrid").trigger("reloadGrid")
                $("#reject-reason").dialog('close')
            })
        }
        function accept(id){
        $.ajax({
                    type:'post',
                    url:'<g:createLink action="preAcceptBankRegion"/>',
                    data:{id:id}
                }).success(function(data){
                    if(data.result=="OK" && confirm(data.message)){
                        $.ajax({
                            type:'post',
                            url:'<g:createLink action="acceptConfirmBankRegion"/>',
                            data:{id:id}
                        }).success(function(){
                            $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                            $("#LoanRequestNT_BankRegionConfirmListGrid").trigger("reloadGrid")
                        })
                    }
                    if(data.result=="CANCEL" && confirm(data.message)){
                        $.ajax({
                            type:'post',
                            url:'<g:createLink action="acceptSendBankRegion"/>',
                            data:{id:id}
                        }).success(function(){
                            $("#LoanRequestNT_BankRegionGrid").trigger("reloadGrid")
                            $("#LoanRequestNT_BankRegionSentListGrid").trigger("reloadGrid")
                        })
                    }
                })

        }
        $(function() {
            $( "#manoto" ).tabs();
            $("#reject-reason").dialog({
                resizable:false,
                modal:true,
                title:'<g:message code="are.you.sure.to.reject.reuqest"/>',
                autoOpen:false
            })
            $("#link-amount").dialog({
                resizable:false,
                modal:true,
                title:'<g:message code="please-enter-amount"/>',
                autoOpen:false
            })
            $("#amount").keyup(function(){
                $("#amountValue").html(addCommas($("#amount").val()))
            })
        });
    </g:javascript>
</div>
</body>
</html>
