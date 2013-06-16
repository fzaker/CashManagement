
<%@ page import="cashmanagement.SystemParameters; cashmanagement.LoanRequest_T" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanRequest_T.label', default: 'LoanRequest_T')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
        <h2><g:message code="default.list.label" args="[entityName]" /></h2>
		<a href="#list-loanRequest_T" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-loanRequest_T" ng-controller="loanRequest_TController" class="content scaffold-list" role="main">

            <div class="fieldcontain">
                <span><g:message code="assignedpermissionamountbranch"/> ${branch}: <g:formatNumber
                        number="${permitAmount}" type="number"/></span>
            </div>

            <div class="fieldcontain">
                <span><g:message code="usedpermissionamountbranch"/> ${branch}: <span id="usedAmount"><g:formatNumber
                        number="${usedAmount}" type="number"/></span></span>
            </div>

            <div class="fieldcontain">
                <span><g:message code="permitpermissionamountbranch"/> ${branch}: <span id="permitAmount"><g:formatNumber
                        number="${permitAmount - usedAmount}" type="number"/></span></span>
            </div>

            <input type="button" ng-click="openLoanRequest_TCreateDialog()" value="${message(code:"create")}"/>
            <rg:grid domainClass="${cashmanagement.LoanRequest_T}"
                     showCommand="false"
                     commands="${[[handler: 'reject(#id#)', icon: 'cancel']]}"
                     caption="${message(code:"Confirm")}"
                     idPostfix="ApprovedList">
                <rg:criteria>
                    <rg:eq name="branch.id" value="${branch.id}"/>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                </rg:criteria>
            </rg:grid>
            <br>
            <rg:grid domainClass="${cashmanagement.LoanRequest_T}"
                     columns="[[name:'loanNo'],[name:'loanIDCode'],[name:'loanType'],[name:'name'],[name:'loanAmount'],[name:'requestDate'],[name:'rejectReason']]"
                     showCommand="false"
                     caption="${message(code: "Rejected")}"
                     idPostfix="RejectedList">
                <rg:criteria>
                    <rg:eq name="branch.id" value="${branch.id}"/>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
                </rg:criteria>
            </rg:grid>
            <rg:dialog id="loanRequest_T" title="${entityName}">
                <rg:fields bean="${new cashmanagement.LoanRequest_T()}">
                    <rg:modify>
                        <rg:hiddenReference field="loanIDCode"/>
                        <rg:hiddenReference field="loanRequestStatus"/>
                        <rg:hiddenReference field="branch"/>
                        <rg:hiddenReference field="requestDate"/>
                        <rg:ignoreField field="loanType"/>
                        <rg:ignoreField field="rejectReason"/>
                    </rg:modify>
                    <g:select name="loanType.id" from="${cashmanagement.LoanType.findAllByLoanGroup(SystemParameters.findAll().first().tabserei)}"
                              ng-model="loanRequest_TInstance.loanType.id" optionKey="id"/>
                </rg:fields>
                <div id="loanAmountValue"></div >
                <rg:saveButton domainClass="${cashmanagement.LoanRequest_T}" conroller="loanRequest_T"  params="[saveCallback:'saveGridCallback']"/>
                <rg:cancelButton/>
            </rg:dialog>
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
            <g:javascript>
                function saveGridCallback(resp){
                    $("#LoanRequest_TRejectedListGrid").trigger("reloadGrid")
                    $("#LoanRequest_TApprovedListGrid").trigger("reloadGrid")
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
                        $("#LoanRequest_TApprovedListGrid").trigger("reloadGrid")
                        $("#LoanRequest_TRejectedListGrid").trigger("reloadGrid")
                        $("#usedAmount").html(addCommas(resp.usedAmount))
                        $("#permitAmount").html(addCommas(resp.permitAmount-resp.usedAmount))
                        $("#reject-reason").dialog('close')
                    })
                }
                $(function(){
                    $("#reject-reason").dialog({
                        resizable:false,
                        modal:true,
                        title:'<g:message code="are.you.sure.to.reject.reuqest"/>',
                        autoOpen:false
                    })
                    $( "#loanRequest_T" ).on( "dialogclose", function( ) {
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
