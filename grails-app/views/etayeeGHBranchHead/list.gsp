<%@ page import="cashmanagement.EtayeeGHBranchHead" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'etayeeGHBranchHead.label', default: 'EtayeeGHBranchHead')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<h2><g:message code="default.list.label" args="[entityName]"/></h2>
<a href="#list-etayeeGHBranchHead" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                        default="Skip to content&hellip;"/></a>

<div id="list-etayeeGHBranchHead" ng-controller="etayeeGHBranchHeadController" class="content scaffold-list" role="main">
    <rg:grid domainClass="${cashmanagement.EtayeeGHBranchHead}" showCommand="false">
        <rg:commands>
            <rg:deleteCommand deleteURL="${createLink(controller: "etayeeGHBranchHead",action: "delete")}"/>
        </rg:commands>
    </rg:grid>
    <rg:dialog id="etayeeGHBranchHead" title="">
        <rg:fields bean="${new cashmanagement.EtayeeGHBranchHead()}">
            <rg:modify>
                <rg:ignoreField field="date"/>
                <rg:ignoreField field="user"/>
                <rg:ignoreField field="branchHead"/>
            </rg:modify>
            <g:select name="branchHead.id" from="${branchHeads}" ng-model="etayeeGHBranchHeadInstance.branchHead.id"
                      optionKey="id"/>
        </rg:fields>
        <div id="loanAmountValue"></div>
        <rg:saveButton domainClass="${cashmanagement.EtayeeGHBranchHead}" conroller="etayeeGHBranchHead" action="save"/>
        <rg:cancelButton/>
    </rg:dialog>
    <input type="button" ng-click="openEtayeeGHBranchHeadCreateDialog()" value="${message(code: "create")}"/>
    <input type="button" ng-click="openEtayeeGHBranchHeadEditDialog()" value="${message(code: "edit")}"/>
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
        $("#etayeeGHBranchHead").bind("dialogopen", function() {
            setTimeout('$("#amount").keyup()',100)

        })
    })
</g:javascript>
</body>
</html>
