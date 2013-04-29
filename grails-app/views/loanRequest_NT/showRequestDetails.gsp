
<%@ page import="cashmanagement.LoanRequest_NT" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'loanRequest_NT.label', default: 'LoanRequest_NT')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
    <g:javascript src="jquery.printelement.js"/>
</head>
<body>
<a href="#show-loanRequest_NT" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="show-loanRequest_NT" class="content scaffold-show" role="main">

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list loanRequest_NT">

        <g:if test="${loanRequest_NTInstance?.loanNo}">
            <li class="fieldcontain">
                <span id="loanNo-label" class="property-label"><g:message code="loanRequest_NT.loanNo" default="Loan No" /></span>

                <span class="property-value" aria-labelledby="loanNo-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanNo"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanIDCode}">
            <li class="fieldcontain">
                <span id="loanIDCode-label" class="property-label"><g:message code="loanRequest_NT.loanIDCode.label" default="Loan IDC ode" /></span>

                <span class="property-value" aria-labelledby="loanIDCode-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanIDCode"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.name}">
            <li class="fieldcontain">
                <span  class="property-label"><g:message code="loanRequest_NT.name" default="Loan IDC ode" /></span>

                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="name"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanType}">
            <li class="fieldcontain">
                <span id="loanType-label" class="property-label"><g:message code="loanRequest_NT.loanType" default="Loan Type" /></span>

                <span class="property-value" aria-labelledby="loanType-label">${loanRequest_NTInstance?.loanType?.encodeAsHTML()}</span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanAmount}">
            <li class="fieldcontain">
                <span id="loanAmount-label" class="property-label"><g:message code="loanRequest_NT.loanAmount" default="Loan Amount" /></span>

                <span class="property-value" aria-labelledby="loanAmount-label"><g:fieldValue bean="${loanRequest_NTInstance}" field="loanAmount"/></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.requestDate}">
            <li class="fieldcontain">
                <span id="requestDate-label" class="property-label"><g:message code="loanRequest_NT.requestDate" default="Request Date" /></span>

                <span class="property-value" aria-labelledby="requestDate-label"><rg:formatJalaliDate date="${loanRequest_NTInstance?.requestDate}" /></span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.loanRequestStatus}">
            <li class="fieldcontain">
                <span id="loanRequestStatus-label" class="property-label"><g:message code="loanRequest_NT.loanRequestStatus" default="Loan Request Status" /></span>

                <span class="property-value" aria-labelledby="loanRequestStatus-label"><g:message code="${loanRequest_NTInstance.loanRequestStatus}"/></span>

            </li>
        </g:if>
        <g:if test="${loanRequest_NTInstance?.rejectReason}">
            <li class="fieldcontain">
                <span class="property-label"><g:message code="rejectReason" /></span>
                <span class="property-value">${loanRequest_NTInstance?.rejectReason?.encodeAsHTML()}</span>
            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.branch}">
            <li class="fieldcontain">
                <span id="branch-label" class="property-label"><g:message code="request-branch" default="Branch" /></span>

                <span class="property-value" aria-labelledby="branch-label">${loanRequest_NTInstance?.branch?.encodeAsHTML()}</span>

            </li>
        </g:if>

        <g:if test="${loanRequest_NTInstance?.user}">
            <li class="fieldcontain">
                <span id="user-label" class="property-label"><g:message code="create-user" default="User" /></span>

                <span class="property-value" aria-labelledby="user-label">${loanRequest_NTInstance?.user?.encodeAsHTML()}</span>

            </li>
        </g:if>
        <g:if test="${loanRequest_NTInstance?.confirmUser}">
            <li class="fieldcontain">
                <span class="property-label"><g:message code="confirm-user" default="User" /></span>

                <span class="property-value" aria-labelledby="user-label">${loanRequest_NTInstance?.confirmUser?.encodeAsHTML()}</span>

            </li>
        </g:if>

        <g:if test="${requestBranchHead}">
            <g:if test="${requestBranchHead?.user}">
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="user-branchHead" default="User" /></span>
                    <span class="property-value" aria-labelledby="user-label">${requestBranchHead?.user?.encodeAsHTML()}</span>
                </li>
            </g:if>
            <g:if test="${requestBranchHead?.changeDate}">
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="date-branchHead" /></span>
                    <span class="property-value"><rg:formatJalaliDate date="${requestBranchHead?.changeDate}"/></span>
                </li>
            </g:if>
            <g:if test="${requestBranchHead?.loanReqStatus}">
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="status-branchHead" /></span>
                    <span class="property-value"><g:message code="${requestBranchHead?.loanReqStatus?.encodeAsHTML()}"/></span>
                </li>
            </g:if>
            %{--<g:if test="${requestBranchHead?.rejectReason}">--}%
                %{--<li class="fieldcontain">--}%
                    %{--<span class="property-label"><g:message code="rejectReason" /></span>--}%
                    %{--<span class="property-value">${requestBranchHead?.rejectReason?.encodeAsHTML()}</span>--}%
                %{--</li>--}%
            %{--</g:if>--}%

        </g:if>

        <g:if test="${requestBankRegion}">
            <g:if test="${requestBankRegion?.user}">
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="user-bankRegion" default="User" /></span>
                    <span class="property-value" aria-labelledby="user-label">${requestBankRegion?.user?.encodeAsHTML()}</span>
                </li>
            </g:if>
            <g:if test="${requestBankRegion?.changeDate}">
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="date-bankRegion" /></span>
                    <span class="property-value"><rg:formatJalaliDate date="${requestBankRegion?.changeDate}"/></span>
                </li>
            </g:if>
            <g:if test="${requestBankRegion?.loanReqStatus}">
                <li class="fieldcontain">
                    <span class="property-label"><g:message code="status-bankRegion" /></span>
                    <span class="property-value"><g:message code="${requestBankRegion?.loanReqStatus?.encodeAsHTML()}"/></span>
                </li>
            </g:if>
            %{--<g:if test="${requestBankRegion?.rejectReason}">--}%
                %{--<li class="fieldcontain">--}%
                    %{--<span class="property-label"><g:message code="rejectReason" /></span>--}%
                    %{--<span class="property-value">${requestBankRegion?.rejectReason?.encodeAsHTML()}</span>--}%
                %{--</li>--}%
            %{--</g:if>--}%

        </g:if>
        <g:set var="commands" value="${[]}"/>
        <g:if test="${[cashmanagement.LoanRequest_NT.Pending,LoanRequest_NT.Sent].contains(loanRequest_NTInstance?.loanRequestStatus)}">
            <g:set var="commands" value="${[[handler: 'reject(#id#)', icon: 'cancel',title:message(code:"reject")]]}"/>
        </g:if>
        <g:if test="${hasBarrow}">
            <li class="fieldcontain">
                <rg:grid domainClass="${cashmanagement.LoanRequestNTBarrow}"
                         columns="[[name:'credit'],[name:'user'],[name:'branch'],[name:'date']]"
                         commands="${commands}"
                         showCommand="false"
                         caption="${message(code:"request_barrows")}">
                    <rg:criteria>
                        <rg:eq name="request.id" value="${loanRequest_NTInstance?.id}"/>
                        <rg:ne name="branch.id" value="${loanRequest_NTInstance?.branch?.id}"/>
                    </rg:criteria>

                </rg:grid>
            </li>
        </g:if>

    </ol>

</div>
<input type="button" value="<g:message code="print" />" onclick="printEL()">
<script type="text/javascript">
    function printEL(){
        var f=$('#show-loanRequest_NT').clone()
        f.find('#LoanRequestNTBarrowGridContainer').remove()
        f.printElement({ printMode:'popup',overrideElementCSS:['${resource(dir: 'css',file: 'main.css')}']})
    }
    function reject(id){
       if(confirm('<g:message code="are.you.sure.to.reject.reuqest"/>')){
           $.ajax({
               type:'post',
               url:'<g:createLink action="rejectBarrow"/>',
               data:{
                   id:id
               }
           }).success(function(){
               $("#LoanRequestNTBarrowGrid").trigger("reloadGrid")
           })
       }
    }
</script>
</body>
</html>
