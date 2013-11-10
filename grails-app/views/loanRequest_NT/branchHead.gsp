<%@ page import="java.math.RoundingMode; cashmanagement.LoanRequest_NT" %>
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
<g:if test="${permitAmount==0}">
    <h3><div class="error"><g:message code="permit-amt-is-zero" /></div></h3>
</g:if>
<div class="left" style="width: 50%">
    <div class="fieldcontain">
        <span class="property-label"><g:message code="permitpermissionamountbranch"/>:</span>
        <span class="property-value"><g:formatNumber
                number="${permitAmount}" maxFractionDigits="0" roundingMode="${RoundingMode.DOWN}" type="number"/></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="usedPercentbranch" args="[manabeDays]"/>:</span>
        <span class="property-value"><span id="usedAmount"><g:formatNumber
                number="${usedPercent}" maxFractionDigits="2" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="usedPercentPrevMonthBranch" args="[manabeDays]"/>:</span>
        <span class="property-value"><span id="permitAmount"><g:formatNumber
                number="${usedPercentPrevMonth}" maxFractionDigits="2" type="number"/></span></span>
    </div>
</div>

<div class="right" style="width: 50%">
    <div class="fieldcontain">
        <span class="property-label"><g:message code="avg.manabe" args="[manabeDays,tendaysago,today]"/>:</span>
        <span class="property-value"><span id="manabe"><g:formatNumber
                number="${manabe}" maxFractionDigits="0" roundingMode="${RoundingMode.DOWN}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="last.masaref"/>:</span>
        <span class="property-value"><span id="masaref"><g:formatNumber
                number="${masaref}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="tashilatEtayee"/>:</span>
        <span class="property-value"><span id="tashilatEtayee"><g:formatNumber
                number="${tashilatEtayee}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="sumCredit"/>:</span>
        <span class="property-value"><span id="sumCredit"><g:formatNumber
                number="${sumCredit}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="sumDebit"/>:</span>
        <span class="property-value"><span id="sumDebit"><g:formatNumber
                number="${sumDebit}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="permitToward"/>:</span>
        <span class="property-value"><span id="permitToward">
            %{--<g:formatNumber number="${permitToward}" maxFractionDigits="2" type="number"/>(--}%
            <g:formatNumber number="${permitToward * 100}" maxFractionDigits="2" type="number"/>%
            %{--)--}%
        </span></span>
    </div>
</div>

<div class="sep"></div>
<rg:criteria inline="true" >
    <rg:nest name="loanRequest_nt">
        <rg:ilike name='loanNo'/>
        <rg:ilike name='melliCode'/>
    </rg:nest>
    <rg:eq name="loanReqStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Pending}"/>
    <rg:nest name="loanRequest_nt">
        <rg:nest name="branch">
            <rg:nest name="branchHead">
                <rg:eq hidden='true' name="id" value="${branchHead?.id}"/>
            </rg:nest>
        </rg:nest>
    </rg:nest>
    <rg:filterGrid grid="LoanRequestNT_BranchHeadGrid"/>
</rg:criteria>
    <rg:grid domainClass="${cashmanagement.LoanRequestNT_BranchHead}"
             maxColumns="8"
             showCommand="false"
             firstColumnWidth="110"
             commands="${[[controller:'loanRequest_NT', action:'showRequestDetails',param:'branchHead=#id#', icon: 'magnifier',title:message(code:'show-details')],[handler: 'reject(#id#)', icon: 'cancel',title:message(code:"reject")], [handler: 'accept(#id#)', icon: 'tick',title:message(code:"confirm")]]}">
        <rg:criteria>
            <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
            <rg:nest name="loanRequest_nt">
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:eq name="id" value="${branchHead?.id}"/>
                    </rg:nest>
                </rg:nest>
            </rg:nest>
        </rg:criteria>
    </rg:grid>
<rg:criteria inline="true" id='brnch'>
    <rg:ilike name='branchCode' label='code'/>
    <rg:ilike name='branchName' label='title'/>
    <rg:eq hidden='true' name="branchHead.id" value="${branchHead?.id}"/>
    <rg:filterGrid grid="BranchGrid"/>
</rg:criteria>
    <rg:grid domainClass="${cashmanagement.Branch}"
             columns="${[[name:'branchCode'],[name:'branchName'],[name:'available'],[name:'percentCurMonth'],[name:'percentOldMonth']]}"
             commands="${[[controller:'loanRequest_NT', action:'showBranchDetails',param:'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]}"
             showCommand="false">
        <rg:criteria>
            <rg:eq name="branchHead.id" value="${branchHead?.id}"/>
        </rg:criteria>
    </rg:grid>
    <g:if test="${permitAmount>0}">
        <button onclick="linkRequest()"><g:message code="link-request"/></button>
    </g:if>

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
            <rg:criteria inline="true" id='conf'>
                <rg:nest name="loanRequest_nt">
                    <rg:ilike name='loanNo'/>
                    <rg:ilike name='melliCode'/>
                </rg:nest>
                <rg:eq name="loanReqStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                <rg:nest name="loanRequest_nt">
                    <rg:nest name="branch">
                        <rg:nest name="branchHead">
                            <rg:eq hidden='true' name="id" value="${branchHead?.id}"/>
                        </rg:nest>
                    </rg:nest>
                </rg:nest>
                <rg:filterGrid grid="LoanRequestNT_BranchHeadConfirmListGrid"/>
            </rg:criteria>
            <rg:grid domainClass="${cashmanagement.LoanRequestNT_BranchHead}"
                     idPostfix="ConfirmList"
                     columns="[[name: 'loanIDCode'], [name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'melliCode'], [name: 'loanAmount'],[name: 'branch']]"
                     commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'branchHead=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                     showCommand="false"
                     caption="${message(code: "Confirm")}">
                <rg:criteria>
                    <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                    <rg:nest name="loanRequest_nt">
                        <rg:nest name="branch">
                            <rg:nest name="branchHead">
                                <rg:eq name="id" value="${branchHead?.id}"/>
                            </rg:nest>
                        </rg:nest>
                    </rg:nest>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Test">
            <rg:criteria inline="true" id="sent">
                <rg:nest name="loanRequest_nt">
                    <rg:ilike name='loanNo'/>
                    <rg:ilike name='melliCode'/>
                </rg:nest>
                <rg:eq name="loanReqStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Sent}"/>
                <rg:nest name="loanRequest_nt">
                    <rg:nest name="branch">
                        <rg:nest name="branchHead">
                            <rg:eq hidden='true' name="id" value="${branchHead?.id}"/>
                        </rg:nest>
                    </rg:nest>
                </rg:nest>
                <rg:filterGrid grid="LoanRequestNT_BranchHeadSentListGrid"/>
            </rg:criteria>
            <rg:grid domainClass="${cashmanagement.LoanRequestNT_BranchHead}"
                     idPostfix="SentList"
                     showCommand="false"
                     commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'branchHead=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                     caption="${message(code: "Sent")}">
                <rg:criteria>
                    <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Sent}"/>
                    <rg:nest name="loanRequest_nt">
                        <rg:nest name="branch">
                            <rg:nest name="branchHead">
                                <rg:eq name="id" value="${branchHead?.id}"/>
                            </rg:nest>
                        </rg:nest>
                    </rg:nest>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Rejected">
            <rg:criteria inline="true" id='cance'>
            <rg:nest name="loanRequest_nt">
                <rg:ilike name='loanNo'/>
                <rg:ilike name='melliCode'/>
            </rg:nest>
            <rg:eq name="loanReqStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Cancel}"/>
            <rg:nest name="loanRequest_nt">
                <rg:nest name="branch">
                    <rg:nest name="branchHead">
                        <rg:eq hidden='true' name="id" value="${branchHead?.id}"/>
                    </rg:nest>
                </rg:nest>
            </rg:nest>
            <rg:filterGrid grid="LoanRequestNT_BranchHeadRejectedListGrid"/>
        </rg:criteria>
            <rg:grid domainClass="${cashmanagement.LoanRequestNT_BranchHead}"
                     columns="[[name:'loanNo'],[name:'name'],[name:'melliCode'],[name:'loanType'],[name:'loanAmount'],[name:'requestDate'],[name:'rejectReason']]"
                     idPostfix="RejectedList"
                     showCommand="false"
                     commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'branchHead=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                     caption="${message(code: "Rejected")}">
                <rg:criteria>
                    <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
                    <rg:nest name="loanRequest_nt">
                        <rg:nest name="branch">
                            <rg:nest name="branchHead">
                                <rg:eq name="id" value="${branchHead?.id}"/>
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
        <g:if test="${permitAmount>0}">
        function linkRequestSubmit(){
            var reqId=$("#LoanRequestNT_BranchHeadGrid").getGridParam('selrow')
            var branchId=$("#BranchGrid").getGridParam('selrow')
            var amt=$("#amount").val()
            $.ajax({
                url:'<g:createLink action="linkBranchRequest"/>',
                data:{
                 branchId:branchId,
                 reqId:reqId,
                 amt:amt
                }
            }).done(function (response) {
                alert(response)
                $("#LoanRequestNT_BranchHeadGrid").trigger("reloadGrid")
                $("#BranchGrid").trigger("reloadGrid")
                $("#LoanRequestNT_BranchHeadConfirmListGrid").trigger("reloadGrid")
                $("#link-amount").dialog("close")
            })
        }
        function linkRequest(){
            var reqId=$("#LoanRequestNT_BranchHeadGrid").getGridParam('selrow')
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
                url:'<g:createLink action="getRequestBranch" />',
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
        </g:if>
        function reject(id){
            $("#loanId").val(id)
            $("#reject-reason").dialog('open')
        }
        function rejectSubmit(){
            $.ajax({
                type:'post',
                url:'<g:createLink action="rejectBranchHead"/>',
                data:{
                    id:$("#loanId").val(),
                    rejectReasonId:$("#rejectReason").val()
                }
            }).success(function(){
                $("#LoanRequestNT_BranchHeadGrid").trigger("reloadGrid")
                $("#LoanRequestNT_BranchHeadRejectedListGrid").trigger("reloadGrid")
                $("#reject-reason").dialog('close')
            })
        }
        function accept(id){
            $.ajax({
                    type:'post',
                    url:'<g:createLink action="preAcceptBranchHead"/>',
                    data:{id:id}
                }).success(function(data){
                    if(data.result=="OK" && confirm(data.message)){
                        $.ajax({
                            type:'post',
                            url:'<g:createLink action="acceptConfirmBranchHead"/>',
                            data:{id:id}
                        }).success(function(){
                            $("#LoanRequestNT_BranchHeadGrid").trigger("reloadGrid")
                            $("#LoanRequestNT_BranchHeadConfirmListGrid").trigger("reloadGrid")
                        })
                    }
                    if(data.result=="CANCEL" && confirm(data.message)){
                        $.ajax({
                            type:'post',
                            url:'<g:createLink action="acceptSendBranchHead"/>',
                            data:{id:id}
                        }).success(function(){
                            $("#LoanRequestNT_BranchHeadGrid").trigger("reloadGrid")
                            $("#LoanRequestNT_BranchHeadSentListGrid").trigger("reloadGrid")
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
