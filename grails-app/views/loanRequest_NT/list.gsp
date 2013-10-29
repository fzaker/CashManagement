<%@ page import="java.math.RoundingMode; cashmanagement.SystemParameters; cashmanagement.LoanRequest_NT" %>
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
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
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
    <g:form action="save">
        <div class="form-field">
            <div class="form-fields-part inline">
                <div class="fieldcontain">
                    <g:hiddenField name="id" value="${loanRequest_nt?.id}"/>
                    <label for="loanType.id"><g:message code="loanType"/></label>
                    <g:select
                            from="${cashmanagement.LoanType.findAllByLoanGroup(SystemParameters.findAll().first().gheyreTabserei)}"
                            optionKey="id" name="loanType.id" value="${loanRequest_nt?.loanType?.id}"/>
                </div>

                <div class="fieldcontain">
                    <label for="loanNo"><g:message code="loanNo"/></label>
                    <g:textField name="loanNo" required="true" value="${loanRequest_nt?.loanNo}"/>
                </div>

                <div class="fieldcontain">
                    <label for="name"><g:message code="loanRequest_NT.name"/></label>
                    <g:textField name="name" required="true" value="${loanRequest_nt?.name}"/>
                </div>

                <div class="fieldcontain">
                    <label for="family"><g:message code="loanRequest_NT.family"/></label>
                    <g:textField name="family" required="true" value="${loanRequest_nt?.family}"/>
                </div>

                <div class="fieldcontain">
                    <label for="melliCode"><g:message code="loanRequest_NT.melliCode"/></label>
                    <g:textField name="melliCode" required="true" value="${loanRequest_nt?.melliCode}"/>
                </div>

                <div class="fieldcontain">
                    <label for="loanAmount"><g:message code="loanAmount"/></label>
                    <g:textField name="loanAmount" required="true" value="${g.formatNumber(number:loanRequest_nt?.loanAmount)}"/>
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
                <a href="#Test"><g:message code="Sent"/></a>
            </li>
            <li>
                <a href="#Rejected"><g:message code="Rejected"/></a>
            </li>
        </ul>


        <div id="pending">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
                     idPostfix="PendingList"
                     maxColumns="7"
                     caption="${message(code: "Pending")}"
                     showCommand="false"
                     firstColumnWidth="110"
                     commands="${[[controller: 'loanRequest_NT', action: 'showRequestDetails', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')],[controller: 'loanRequest_NT', action: 'list', param: 'id=#id#', icon: 'application_edit',title:message(code:'edit')], [handler: 'reject(#id#)', icon: 'cancel', title: message(code: "reject")], [handler: 'accept(#id#)', icon: 'tick', title: message(code: "confirm")]]}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
                    <rg:eq name="branch.id" value="${branch?.id}"/>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Confirm">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
                     columns="[[name: 'loanIDCode'], [name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'family'], [name: 'melliCode'], [name: 'loanAmount'], [name: 'requestDate']]"
                     idPostfix="ConfirmList"
                     showCommand="false"
                     firstColumnWidth="70"
                     commands="[[controller: 'loanRequest_NT', action: 'showRequestDetails', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')], [handler: 'reject(#id#)', icon: 'cancel', title: message(code: 'reject')]]"
                     caption="${message(code: "Confirm")}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                    <rg:eq name="branch.id" value="${branch?.id}"/>
                </rg:criteria>
            </rg:grid>
        </div>
        <div id="Paid">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
                     columns="[[name: 'loanIDCode'], [name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'family'], [name: 'melliCode'], [name: 'loanAmount'], [name: 'requestDate']]"
                     idPostfix="PaidList"
                     showCommand="false"
                     firstColumnWidth="40"
                     commands="[[controller: 'loanRequest_NT', action: 'showRequestDetails', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                     caption="${message(code: "Confirm")}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Paid}"/>
                    <rg:eq name="branch.id" value="${branch?.id}"/>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Test">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
                     idPostfix="SentList"
                     maxColumns="7"
                     firstColumnWidth="40"
                     showCommand="false"
                     commands="[[controller: 'loanRequest_NT', action: 'showRequestDetails', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                     caption="${message(code: "Sent")}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Sent}"/>
                    <rg:eq name="branch.id" value="${branch?.id}"/>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Rejected">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
                     columns="[[name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'family'], [name: 'melliCode'], [name: 'loanAmount'], [name: 'requestDate'], [name: 'rejectReason'], [name: 'rejectUser']]"
                     idPostfix="RejectedList"
                     showCommand="false"
                     firstColumnWidth="40"
                     commands="[[controller: 'loanRequest_NT', action: 'showRequestDetails', param: 'id=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                     caption="${message(code: "Rejected")}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
                    <rg:eq name="branch.id" value="${branch?.id}"/>
                </rg:criteria>
            </rg:grid>
        </div>
    </div>
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
            }).success(function(){
                $("#LoanRequest_NTPendingListGrid").trigger("reloadGrid")
                $("#LoanRequest_NTRejectedListGrid").trigger("reloadGrid")
                $("#LoanRequest_NTConfirmListGrid").trigger("reloadGrid")
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
                            $("#LoanRequest_NTPendingListGrid").trigger("reloadGrid")
                            $("#LoanRequest_NTConfirmListGrid").trigger("reloadGrid")
                        })
                    }
                    if(data.result=="CANCEL" && confirm(data.message)){
                        $.ajax({
                            type:'post',
                            url:'<g:createLink action="acceptSend"/>',
                            data:{id:id}
                        }).success(function(){
                            $("#LoanRequest_NTPendingListGrid").trigger("reloadGrid")
                            $("#LoanRequest_NTSentListGrid").trigger("reloadGrid")
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
            $("#loanAmount").keyup(function(){
                $("#loanAmountValue").html(addCommas($("#loanAmount").val()))
            }).keyup()
        });
</g:javascript>
</body>
</html>
