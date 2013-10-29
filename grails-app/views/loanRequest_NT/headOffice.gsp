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

<div class="sep"></div>
<rg:grid domainClass="${cashmanagement.LoanRequestNT_HeadOffice}"
         maxColumns="8"
         showCommand="false"
         firstColumnWidth="110"
         commands="${[[controller:'loanRequest_NT', action:'showRequestDetails',param:'headOffice=#id#', icon: 'magnifier',title:message(code:'show-details')],[handler: 'reject(#id#)', icon: 'cancel',title:message(code:"reject")], [handler: 'accept(#id#)', icon: 'tick',title:message(code:"confirm")]]}">
    <rg:criteria>
        <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Pending}"/>
    </rg:criteria>
</rg:grid>

<br>
<br>
<div id="manoto">
    <ul>
        <li>
            <a href="#Confirm"><g:message code="Confirm"/></a>
        </li>
        <li>
            <a href="#Rejected"><g:message code="Rejected"/></a>
        </li>
    </ul>


    <div id="Confirm">
        <rg:grid domainClass="${cashmanagement.LoanRequestNT_HeadOffice}"
                 idPostfix="ConfirmList"
                 columns="[[name: 'loanIDCode'], [name: 'loanNo'], [name: 'loanType'], [name: 'name'], [name: 'melliCode'], [name: 'loanAmount'],[name: 'branch']]"
                 commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'headOffice=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                 showCommand="false"
                 caption="${message(code: "Confirm")}">
            <rg:criteria>
                <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Confirm}"/>

            </rg:criteria>
        </rg:grid>
    </div>


    <div id="Rejected">
        <rg:grid domainClass="${cashmanagement.LoanRequestNT_HeadOffice}"
                 columns="[[name:'loanNo'],[name:'name'],[name:'melliCode'],[name:'loanType'],[name:'loanAmount'],[name:'requestDate'],[name:'rejectReason']]"
                 idPostfix="RejectedList"
                 showCommand="false"
                 commands="[[controller:'loanRequest_NT', action:'showRequestDetails',param:'headOffice=#id#', icon: 'magnifier',title:message(code:'show-details')]]"
                 caption="${message(code: "Rejected")}">
            <rg:criteria>
                <rg:eq name="loanReqStatus" value="${cashmanagement.LoanRequest_NT.Cancel}"/>

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
            url:'<g:createLink action="rejectHeadOffice"/>',
                data:{
                    id:$("#loanId").val(),
                    rejectReasonId:$("#rejectReason").val()
                }
            }).success(function(){
                $("#LoanRequestNT_HeadOfficeGrid").trigger("reloadGrid")
                $("#LoanRequestNT_HeadOfficeRejectedListGrid").trigger("reloadGrid")
                $("#reject-reason").dialog('close')
            })
    }
    function accept(id){
        $.ajax({
                type:'post',
                url:'<g:createLink action="acceptHeadOffice"/>',
                data:{id:id}
            }).success(function(data){
                alert(data)
                $("#LoanRequestNT_HeadOfficeGrid").trigger("reloadGrid")
                $("#LoanRequestNT_HeadOfficeConfirmListGrid").trigger("reloadGrid")

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

    });
</g:javascript>
</div>
</body>
</html>
