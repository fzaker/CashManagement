<%@ page import="cashmanagement.BranchHeadTransfer" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title><g:message code="branchHeadResourceTransfer.title"/></title>
</head>

<body>
<h2><g:message code="branchHeadResourceTransfer.title"/></h2>

<div id="list-loanRequestNT_BranchHead" ng-controller="loanRequestNT_BranchHeadController" class="content scaffold-list" role="main">
    <rg:grid domainClass="${cashmanagement.LoanRequestNT_BranchHead}">
        <rg:criteria >
            <rg:nest name="loanRequest_nt">
                %{--<rg:nest name="branch">--}%
                    <rg:eq name="branch.id" value="${branchHeadId}"/>
                %{--</rg:nest>--}%
            </rg:nest>
        </rg:criteria>
    </rg:grid>

</div>
<div id="list-resourceReadyBranch" ng-controller="resourceReadyBranchController" class="content scaffold-list" role="main">
    <rg:grid domainClass="${cashmanagement.ResourceReadyBranch}"></rg:grid>

</div>

</body>
</html>
