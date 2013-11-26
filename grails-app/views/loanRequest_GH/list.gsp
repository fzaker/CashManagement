<%@ page import="cashmanagement.SystemParameters; cashmanagement.LoanRequest_GH" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_GH.label', default: 'LoanRequest_GH')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-loanRequest_GH" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                    default="Skip to content&hellip;"/></a>

<div id="list-loanRequest_GH" ng-controller="loanRequest_GHController" class="content scaffold-list" role="main">
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div class="left" style="width: 50%">
    <div class="fieldcontain">
        <span class="property-label"><g:message code="paidLoanAmount"/></span>
        <span class="property-value"><g:formatNumber number="${paidLoanAmount}" type="number"/></span>
    </div>
    <div class="fieldcontain">
        <span class="property-label"><g:message code="paidLoanAmountThisPeriod"/></span>
        <span class="property-value"><g:formatNumber number="${paidLoanAmountThisPeriod}" type="number"/></span>
    </div>

</div>
<div class="right" style="width: 50%">
    <div class="fieldcontain">
        <span class="property-label"><g:message code="assignedpermissionamountbranch"/></span>
        <span class="property-value"><g:formatNumber number="${permitAmount}" type="number"/></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="usedpermissionamountbranch"/></span>
        <span class="property-value" id="usedAmount"><g:formatNumber number="${usedAmount}" type="number"/></span>
    </div>

    <div class="fieldcontain">
        <span class="property-label"><g:message code="ghpermitpermissionamountbranch"/></span>
        <span class="property-value" id="permitAmount"><g:formatNumber number="${permitAmount - usedAmount}"
                                                                       type="number"/></span>
    </div>
</div>
<br>
<g:form action="save">
    <div class="form-field">
        <div class="form-fields-part inline">
            <div class="fieldcontain">
                <g:hiddenField name="id" value="${loanRequest_gh?.id}"/>
                <label for="loanType.id"><g:message code="loanType"/></label>
                <g:select
                        from="${cashmanagement.LoanType.findAllByLoanGroup(SystemParameters.findAll().first().gharzolhasane)}"
                        optionKey="id" name="loanType.id" value="${loanRequest_gh?.loanType?.id?:params['loanType.id']}"/>
            </div>

            <div class="fieldcontain">
                <label for="loanNo"><g:message code="loanNo"/></label>
                <g:textField name="loanNo" required="true" value="${loanRequest_gh?.loanNo?:params['loanNo']}"/>
            </div>

            <div class="fieldcontain">
                <label for="name"><g:message code="loanRequest_T.name"/></label>
                <g:textField name="name" required="true" value="${loanRequest_gh?.name?:params['name']}"/>
            </div>

            <div class="fieldcontain">
                <label for="family"><g:message code="loanRequest_T.family"/></label>
                <g:textField name="family" required="true" value="${loanRequest_gh?.family?:params['family']}"/>
            </div>

            <div class="fieldcontain">
                <label for="melliCode"><g:message code="loanRequest_T.melliCode"/></label>
                <g:textField name="melliCode" required="true" value="${loanRequest_gh?.melliCode?:params['melliCode']}"/>
            </div>

            <div class="fieldcontain">
                <label for="loanAmount"><g:message code="loanAmount"/></label>
                <g:textField name="loanAmount" required="true" value="${g.formatNumber(number:loanRequest_gh?.loanAmount)?:params['loanAmount']}"/>
                <span id="loanAmountValue"></span>
            </div>
            %{--<div class="fieldcontain">--}%
            %{--<label for="loanIDCode"> <g:message code="loanIDCode"/> </label>--}%
            %{--<g:textField name="loanIDCode"  />--}%
            %{--</div>--}%

        </div>

        <div class="clear">
            <g:submitButton name="save" value="${message(code: "save.label")}"/>
        </div>
    </div>

</g:form>

<div id="manoto">
    <ul>
        <li>
            <a href="#pending"><g:message code="Pending"/></a>
        </li>
        <li>
            <a href="#Confirm"><g:message code="Confirm"/></a>
        </li>
        <li>
            <a href="#Paid"><g:message code="Paid"/></a>
        </li>

        <li>
            <a href="#Rejected"><g:message code="Rejected"/></a>
        </li>
    </ul>


    <div id="pending">
        <rg:criteria inline="true" id='pend'>
            <rg:ilike name='loanNo'/>
            <rg:ilike name='melliCode'/>
            <rg:eq name="loanRequestStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Pending}"/>
            <rg:eq hidden='true' name="branch.id" value="${branch?.id}"/>
            <rg:filterGrid grid="LoanRequest_GHPendingListGrid"/>
        </rg:criteria>
        <rg:grid domainClass="${cashmanagement.LoanRequest_GH}"
                 columns="[[name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'family'], [name: 'melliCode'], [name: 'loanAmount'], [name: 'requestDate']]"
                 showCommand="false"
                 firstColumnWidth="110"
                 caption="${message(code: "Pending")}"
                 commands="${[[controller: 'loanRequest_GH', action: 'show', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')],[controller: 'loanRequest_GH', action: 'list', param: 'id=#id#', icon: 'application_edit',title:message(code:'edit')], [handler: 'reject(#id#)', icon: 'cancel', title: message(code: "reject")], [handler: 'accept(#id#)', icon: 'tick', title: message(code: "confirm")]]}"
                 idPostfix="PendingList">
            <rg:criteria>
                <rg:eq name="branch.id" value="${branch.id}"/>
                <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_GH.Pending}"/>
            </rg:criteria>
        </rg:grid>
    </div>

    <div id="Confirm">
        <rg:criteria inline="true" id='conf'>
            <rg:ilike name='loanNo'/>
            <rg:ilike name='melliCode'/>
            <rg:eq name="loanRequestStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Confirm}"/>
            <rg:eq hidden='true' name="branch.id" value="${branch?.id}"/>
            <rg:filterGrid grid="LoanRequest_GHConfirmListGrid"/>
        </rg:criteria>
        <rg:grid domainClass="${cashmanagement.LoanRequest_GH}"
                 columns="[[name: 'loanNo'], [name: 'loanIDCode'], [name: 'loanType'], [name: 'name'],[name:'family'],[name:'melliCode'], [name: 'loanAmount'], [name: 'requestDate']]"
                 showCommand="false"
                 firstColumnWidth="70"
                 caption="${message(code: "Confirm")}"
                 commands="[[controller: 'loanRequest_GH', action: 'show', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')], [handler: 'reject(#id#)', icon: 'cancel', title: message(code: 'reject')]]"
                 idPostfix="ConfirmList">
            <rg:criteria>
                <rg:eq name="branch.id" value="${branch.id}"/>
                <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_GH.Confirm}"/>
            </rg:criteria>
        </rg:grid>
    </div>

    <div id="Paid">
        <rg:criteria inline="true" id='paid'>
            <rg:ilike name='loanNo'/>
            <rg:ilike name='melliCode'/>
            <rg:eq name="loanRequestStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Paid}"/>
            <rg:eq hidden='true' name="branch.id" value="${branch?.id}"/>
            <rg:filterGrid grid="LoanRequest_GHPaidListGrid"/>
        </rg:criteria>
        <rg:grid domainClass="${cashmanagement.LoanRequest_GH}"
                 columns="[[name: 'loanNo'], [name: 'loanIDCode'], [name: 'loanType'], [name: 'name'],[name:'family'],[name:'melliCode'], [name: 'loanAmount'], [name: 'requestDate']]"
                 showCommand="false"
                 firstColumnWidth="40"
                 caption="${message(code: "Paid")}"
                 commands="[[controller: 'loanRequest_GH', action: 'show', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                 idPostfix="PaidList">
            <rg:criteria>
                <rg:eq name="branch.id" value="${branch.id}"/>
                <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_GH.Paid}"/>
            </rg:criteria>
        </rg:grid>
    </div>

    <div id="Rejected">
        <rg:criteria inline="true" id='rej'>
            <rg:ilike name='loanNo'/>
            <rg:ilike name='melliCode'/>
            <rg:eq name="loanRequestStatus" hidden='true' value="${cashmanagement.LoanRequest_NT.Cancel}"/>
            <rg:eq hidden='true' name="branch.id" value="${branch?.id}"/>
            <rg:filterGrid grid="LoanRequest_GHRejectedListGrid"/>
        </rg:criteria>
        <rg:grid domainClass="${cashmanagement.LoanRequest_GH}"
                 columns="[[name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'family'],[name: 'melliCode'], [name: 'loanAmount'], [name: 'requestDate'], [name: 'rejectReason']]"
                 showCommand="false"
                 firstColumnWidth="40"
                 caption="${message(code: "Rejected")}"
                 commands="[[controller: 'loanRequest_GH', action: 'show', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                 idPostfix="RejectedList">
            <rg:criteria>
                <rg:eq name="branch.id" value="${branch.id}"/>
                <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_GH.Cancel}"/>
            </rg:criteria>
        </rg:grid>
    </div>

    <div id="reject-reason">
        <div class="fieldcontain">
            <g:hiddenField name="loanId"/>
            <label for="rejectReason">
                <g:message code="rejectReason.label" default="Loan No"/>
            </label>
            <g:select name="rejectReason" from="${cashmanagement.RejectReason.list()}" optionKey="id"/>
        </div>
        <g:submitButton name="save" value="${message(code: "save.label")}" onclick="rejectSubmit()"/>
    </div>
    <g:javascript>
                function saveGridCallback(resp){
                    $("#LoanRequest_GHRejectedListGrid").trigger("reloadGrid")
                    $("#LoanRequest_GHApprovedListGrid").trigger("reloadGrid")
                    $("#usedAmount").html(addCommas(resp.usedAmount))
                    $("#permitAmount").html(addCommas(resp.permitAmount-resp.usedAmount))
                }
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
                function reject(id){
                    $("#loanId").val(id)
                    $("#reject-reason").dialog('open')
                }
                function rejectSubmit(){
                    $.ajax({
                        type:'post',
                        url:'<g:createLink action="reject"/>',
                        data:{
                            id:$("#loanId").val(),
                            rejectReasonId:$("#rejectReason").val()
                        }
                    }).success(function(resp){
                        $("#LoanRequest_GHPendingListGrid").trigger("reloadGrid")
                        $("#LoanRequest_GHConfirmListGrid").trigger("reloadGrid")
                        $("#LoanRequest_GHPaidListGrid").trigger("reloadGrid")
                        $("#LoanRequest_GHRejectedListGrid").trigger("reloadGrid")
                        $("#usedAmount").html(addCommas(resp.usedAmount))
                        $("#permitAmount").html(addCommas(resp.permitAmount-resp.usedAmount))
                        $("#reject-reason").dialog('close')
                    })
                }
                function accept(id){
                    $.ajax({
                            type:'post',
                            url:'<g:createLink action="preAccept"/>',
                            data:{id:id}
                        }).success(function(data){
                            if(data.result=="OK" && confirm(data.message)){
                                $.ajax({
                                    type:'post',
                                    url:'<g:createLink action="acceptConfirm"/>',
                                    data:{id:id}
                                }).success(function(){
                                    $("#LoanRequest_GHPendingListGrid").trigger("reloadGrid")
                                    $("#LoanRequest_GHConfirmListGrid").trigger("reloadGrid")
                                })
                            }
                            if(data.result=="CANCEL" && confirm(data.message)){
                                $.ajax({
                                    type:'post',
                                    url:'<g:createLink action="acceptReject"/>',
                                    data:{id:id}
                                }).success(function(){
                                    $("#LoanRequest_GHPendingListGrid").trigger("reloadGrid")
                                    $("#LoanRequest_GHRejectedListGrid").trigger("reloadGrid")
                                })
                            }
                        })

                }
                $(function(){
                    $( "#manoto" ).tabs();
                    $("#reject-reason").dialog({
                        resizable:false,
                        modal:true,
                        title:'<g:message code="are.you.sure.to.reject.reuqest"/>',
                        autoOpen:false
                    })
                    $( "#loanRequest_GH" ).on( "dialogclose", function( ) {
                        $("#loanAmountValue").html('')
                    } );
                    $("#loanAmount").keyup(function(){
                        $("#loanAmountValue").html(addCommas($("#loanAmount").val()))
                    })
                })
    </g:javascript>
    %{--<input type="button" ng-click="openLoanRequest_TEditDialog()" value="Edit LoanRequest_T"/>--}%
</div>
</body>
</html>
