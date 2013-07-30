<%@ page import="cashmanagement.EtayeeTBranchHead" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'etayeeTBranchHead.label', default: 'EtayeeTBranchHead')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-etayeeTBranchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                        default="Skip to content&hellip;"/></a>

<div id="list-etayeeTBranchHead" ng-controller="etayeeTBranchHeadController" class="content scaffold-list" role="main">
    <rg:grid domainClass="${cashmanagement.EtayeeTBranchHead}" showCommand="false">
        <rg:commands>
            <rg:deleteCommand deleteURL="${createLink(controller: "etayeeTBranchHead",action: "delete")}"/>
        </rg:commands>
    </rg:grid>
    <rg:dialog id="etayeeTBranchHead" title="">
        <rg:fields bean="${new cashmanagement.EtayeeTBranchHead()}">
            <rg:modify>
                <rg:ignoreField field="date"/>
                <rg:ignoreField field="user"/>
                <rg:ignoreField field="branchHead"/>
            </rg:modify>
            <g:select name="branchHead.id" from="${branchHeads}" ng-model="etayeeTBranchHeadInstance.branchHead.id"
                      optionKey="id"/>
        </rg:fields>
        <div id="loanAmountValue"></div>
        <rg:saveButton domainClass="${cashmanagement.EtayeeTBranchHead}" conroller="etayeeTBranchHead" action="save"/>
        <rg:cancelButton/>
    </rg:dialog>
    <input type="button" ng-click="openEtayeeTBranchHeadCreateDialog()" value="${message(code: "create")}"/>
    <input type="button" ng-click="openEtayeeTBranchHeadEditDialog()" value="${message(code: "edit")}"/>
</div>
<g:javascript>
    function addCommas(nStr) {
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
    $(function(){

        $("#amount").keyup(function(){
            $("#loanAmountValue").html(addCommas($("#amount").val()))
        })
        $("#etayeeTBranchHead").bind("dialogopen", function() {
            setTimeout('$("#amount").keyup()',100)

        })
    })
</g:javascript>
</body>
</html>
