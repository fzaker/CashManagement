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

<div id="list-loanRequest_NT" ng-controller="loanRequest_NTController" class="content scaffold-list" role="main">
    %{--<input type="button" ng-click="openLoanRequest_NTCreateDialog()" value="Create LoanRequest_NT"/>--}%
    %{--<input type="button" ng-click="openLoanRequest_NTEditDialog()" value="Edit LoanRequest_NT"/>--}%
    %{--<rg:dialog id="loanRequest_NT" title="LoanRequest_NT Dialog">--}%
        %{--<rg:fields bean="${new cashmanagement.LoanRequest_NT()}">--}%
            %{--<rg:modify>--}%
                %{--<rg:hiddenReference field="loanIDCode"/>--}%
                %{--<rg:hiddenReference field="loanRequestStatus"/>--}%
                %{--<rg:hiddenReference field="branch"/>--}%
                %{--<rg:hiddenReference field="requestDate"/>--}%
            %{--</rg:modify>--}%
        %{--</rg:fields>--}%
        %{--<rg:saveButton domainClass="${cashmanagement.LoanRequest_NT}" conroller="loanRequest_NT"/>--}%
        %{--<rg:cancelButton/>--}%
    %{--</rg:dialog>--}%
    <g:form action="save">
        <div class="form-field">
            <div class="form-fields-part" >
                <div class="fieldcontain">
                    <label for="loanNo"> <g:message code="loanNo"/> </label>
                    <g:textField name="loanNo" required="true" />
                </div>
                <div class="fieldcontain">
                    <label for="loanType"> <g:message code="loanType"/> </label>
                    <g:select from="${cashmanagement.LoanType.findAll()}" optionKey="id" name="loanType.id"  />
                </div>
                <div class="fieldcontain">
                    <label for="loanAmount"> <g:message code="loanAmount"/> </label>
                    <g:textField name="loanAmount" required="true" />
                </div>
                %{--<div class="fieldcontain">--}%
                    %{--<label for="loanIDCode"> <g:message code="loanIDCode"/> </label>--}%
                    %{--<g:textField name="loanIDCode"  />--}%
                %{--</div>--}%
                <g:submitButton name="save"/>

            </div>
        </div>

    </g:form>
    <div id="manoto">
        <ul>
            <li>
                <a href="#pending"><g:message code="Pending"/> </a>
            </li>
            <li>
                <a href="#Confirm"><g:message code="Confirm"/></a>
            </li>
            <li>
                <a href="#Test"><g:message code="Sent"/></a>
            </li>
        </ul>


        <div id="pending">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}"
                     idPostfix="PendingList"
                     caption="PendingList"
                     showCommand="false"
                     firstColumnWidth="30"
                     commands="${[[handler: 'reject(#id#)', icon: 'cancel'], [handler: 'accept(#id#)', icon: 'arrow_turn_left']]}">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Confirm">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}" idPostfix="ConfirmList" caption="ConfirmList">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>
                </rg:criteria>
            </rg:grid>
        </div>

        <div id="Test">
            <rg:grid domainClass="${cashmanagement.LoanRequest_NT}" idPostfix="SentList" caption="SentList">
                <rg:criteria>
                    <rg:eq name="loanRequestStatus" value="${cashmanagement.LoanRequest_NT.Sent}"/>
                </rg:criteria>
            </rg:grid>
        </div>
    </div>
</div>
<g:javascript>
        function reject(id){
            if(confirm('<g:message code="are.you.sure.to.reject.reuqest"/>')){
                $.ajax({
                    type:'post',
                    url:'<g:createLink action="reject"/>',
                    data:{id:id}
                }).success(function(){
                    $("#LoanRequest_NTPendingListGrid").trigger("reloadGrid")
                })
            }
        }
        function accept(id){
            if(confirm('<g:message code="are.you.sure.to.accept.reuqest"/>')){
                $.ajax({
                    type:'post',
                    url:'<g:createLink action="accept"/>',
                    data:{id:id}
                }).success(function(){
                    $("#LoanRequest_NTPendingListGrid").trigger("reloadGrid")
                    $("#LoanRequest_NTSentListGrid").trigger("reloadGrid")
                })
            }
        }
        $(function() {
        $( "#manoto" ).tabs();
    });
</g:javascript>
</body>
</html>
