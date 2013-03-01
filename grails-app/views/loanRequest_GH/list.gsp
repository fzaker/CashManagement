<%@ page import="cashmanagement.SystemParameters; fi.joensuu.joyds1.calendar.JalaliCalendar; cashmanagement.LoanRequest_GH" %>
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
<g:set var="year" value="${new JalaliCalendar().getYear()}"/>
<g:set var="permissionAmountBranch"
       value="${permitAmount}"/>
<g:set var="usedAmountBranch"
       value="${usedAmount}"/>
<g:set var="permissionAmountBranchMonth"
       value="${permitAmountMonth}"/>
<g:set var="usedAmountBranchMonth"
       value="${usedAmountMonth}"/>


<div id="list-loanRequest_GH" ng-controller="loanRequest_GHController" class="content scaffold-list" role="main">
    <div class="fieldcontain">
        <span><g:message code="bankpercentgharzolhasane"/>: <g:formatNumber
                number="${bankPercent}" type="number"/></span>
    </div>
    <div class="fieldcontain">
        <span><g:message code="assignedpermissionamountbranch"/> ${branch}: <g:formatNumber
                number="${permitAmount}" type="number"/></span>
    </div>

    <div class="fieldcontain">
        <span><g:message code="usedpermissionamountbranch"/> ${branch}: <span id="usedAmount"><g:formatNumber
                number="${usedAmountBranch}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span><g:message code="permitpermissionamountbranch"/> ${branch}: <span id="permitAmount"><g:formatNumber
                number="${permitAmount - usedAmountBranch}" type="number"/></span></span>
    </div>
    <div class="fieldcontain">
        <span><g:message code="assignedpermissionamountbranchmonth"/> ${branch}: <g:formatNumber
                number="${permissionAmountBranchMonth}" type="number"/></span>
    </div>

    <div class="fieldcontain">
        <span><g:message code="usedpermissionamountbranchmonth"/> ${branch}: <span id="usedAmountMonth"><g:formatNumber
                number="${usedAmountBranchMonth}" type="number"/></span></span>
    </div>

    <div class="fieldcontain">
        <span><g:message code="permitpermissionamountbranchmonth"/> ${branch}: <span id="permitAmountMonth"><g:formatNumber
                number="${permissionAmountBranchMonth - usedAmountBranchMonth}" type="number"/></span></span>
    </div>


    <input type="button" ng-click="openLoanRequest_GHCreateDialog()" value="${message(code: "create")}"/>
    <rg:grid domainClass="${cashmanagement.LoanRequest_GH}"
             caption="${message(code: "Confirm")}"
             showCommand="false"
             commands="${[[handler: 'reject(#id#)', icon: 'cancel']]}"
             idPostfix="ApprovedList">
        <rg:criteria>
            <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
            <rg:eq name="branch.id" value="${branch?.id}"/>
        </rg:criteria>
    </rg:grid>
    <br>
    <rg:grid domainClass="${cashmanagement.LoanRequest_GH}"
             caption="${message(code: "Rejected")}"
             showCommand="false"
             idPostfix="RejectedList">
        <rg:criteria>
            <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>
            <rg:eq name="branch.id" value="${branch?.id}"/>
        </rg:criteria>
    </rg:grid>
    <rg:dialog id="loanRequest_GH" title="${entityName}">
        <rg:fields bean="${new cashmanagement.LoanRequest_GH()}">
            <rg:modify>
                <rg:hiddenReference field="loanIDCode"/>
                <rg:hiddenReference field="loanRequestStatus"/>
                <rg:hiddenReference field="branch"/>
                <rg:hiddenReference field="requestDate"/>
                <rg:ignoreField field="loanType"/>
            </rg:modify>
            <g:select name="loanType.id" from="${cashmanagement.LoanType.findAllByLoanGroup(SystemParameters.findAll().first().gharzolhasane)}"
                        ng-model="loanRequest_GHInstance.loanType.id" optionKey="id"/>
        </rg:fields>
        <rg:saveButton domainClass="${cashmanagement.LoanRequest_GH}" conroller="loanRequest_GH"
                       params="[saveCallback: 'saveGridCallback']"/>
        <rg:cancelButton/>
    </rg:dialog>
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
                function saveGridCallback(resp){
                    $("#LoanRequest_GHRejectedListGrid").trigger("reloadGrid")
                    $("#LoanRequest_GHApprovedListGrid").trigger("reloadGrid")
                    $("#usedAmount").html(addCommas(resp.usedAmount))
                    $("#permitAmount").html(addCommas(resp.remainAmount))
                    $("#usedAmountMonth").html(addCommas(resp.usedAmountMonth) )
                    $("#permitAmountMonth").html(addCommas(resp.remainAmountMonth))
                }
                function reject(id){
                    if(confirm('<g:message code="are.you.sure.to.reject.reuqest"/>')){
                        $.ajax({
                            type:'post',
                            url:'<g:createLink action="reject"/>',
                            data:{id:id}
                        }).success(function(resp){
                            $("#LoanRequest_GHApprovedListGrid").trigger("reloadGrid")
                            $("#LoanRequest_GHRejectedListGrid").trigger("reloadGrid")
                            $("#usedAmount").html(addCommas(resp.usedAmount))
                            $("#permitAmount").html(addCommas(resp.remainAmount))
                            $("#usedAmountMonth").html(addCommas(resp.usedAmountMonth))
                            $("#permitAmountMonth").html(addCommas(resp.remainAmountMonth))
                        })
                    }
                }
    </g:javascript>

    %{--<input type="button" ng-click="openLoanRequest_GHEditDialog()" value="Edit LoanRequest_GH"/>--}%
</div>
</body>
</html>
