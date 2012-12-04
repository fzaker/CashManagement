<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Report Menu</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: (setting?setting.siteColor:'blue') + 'Style.css')}"/>

</head>
<body>
<h2></h2>
<div style="margin-top: 60px;">
<g:javascript src="jquerymenu-min.js"/>
<script type="text/javascript">
    $(document).ready(function() {
        jQuery().jqueryMenu();
    });
</script>

<g:set var="vehicle" value="${(user && (user.region.code=='7'))? 'taxi' : 'bus'}"/>

<div style="direction:ltr;font-size:16px;margin:auto;" id="jquerymenu">
    <ul>
        <li>
            <a href="" rel="busDriver">
                <g:message code="vehicleDriver" args="${[message(code: vehicle)]}"/>
                <span><g:message code="vehicleDriver.reports.description" args="${[message(code: vehicle)]}"/></span>
            </a>
        </li>
        <li>
            <a href="" rel="bus">
                <g:message code="vehicle" args="${[message(code: vehicle)]}"/>
                <span><g:message code="vehicle.reports.description" args="${[message(code: vehicle)]}"/></span>
            </a>
        </li>

        <li>
            <a href="" rel="busline">
                <g:message code="vehicleLine" args="${[message(code: vehicle)]}"/>
                <span><g:message code="vehicleLine.reports.description" args="${[message(code: vehicle)]}"/></span>
            </a>
        </li>
        <li>
            <a href="" rel="charge">
                &#1588;&#1575;&#1585;&#1688;
                <span>&#1605;&#1588;&#1575;&#1607;&#1583;&#1607; &#1711;&#1586;&#1575;&#1585;&#1588;&#1575;&#1578; &#1608; &#1606;&#1605;&#1608;&#1583;&#1575;&#1585;&#1607;&#1575;&#1740; &#1588;&#1575;&#1585;&#1688;</span>
            </a>
        </li>
        <li>
            <a href="" rel="decharge">
                &#1583;&#1588;&#1575;&#1585;&#1688;
                <span>&#1605;&#1588;&#1575;&#1607;&#1583;&#1607; &#1711;&#1586;&#1575;&#1585;&#1588;&#1575;&#1578; &#1608; &#1606;&#1605;&#1608;&#1583;&#1575;&#1585;&#1607;&#1575;&#1740; &#1583;&#1588;&#1575;&#1585;&#1688;</span>
            </a>
        </li>
        <li>
            <a href="" rel="card">
                &#1705;&#1575;&#1585;&#1578;
                <span>&#1605;&#1588;&#1575;&#1607;&#1583;&#1607; &#1711;&#1586;&#1575;&#1585;&#1588;&#1575;&#1578; &#1605;&#1585;&#1576;&#1608;&#1591; &#1576;&#1607; &#1705;&#1575;&#1585;&#1578;</span>
            </a>

        </li>
    </ul>

</div>
<div style="direction:ltr;" id="jquerymenububble">
<div class="slider">
<div class="set busDriver">
    <ul>
        <li>
            <span>

                <img src="${resource(dir: 'images/reportMenuImages', file: 'monthlyChart.png')}"/>

            </span>
            <g:link controller="report" action="busDriverMonthlyChart" params="${[id:'p']}"><g:message code="report.busDriverMonthlyChart" args="${[message(code: vehicle)]}"/></g:link>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'distributor-report.png')}" />
            </span>
            <g:link controller="report" action="busLineDriversTotals" params="${[id:'p']}"><g:message code="report.busLineDriversTotals" args="${[message(code: vehicle)]}"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'driver-bus.png')}" />
            </span>
            <g:link controller="report" action="dailyBusWithDriverTransactionTotals" params="${[id:'p']}"><g:message code="report.dailyBusWithDriverTransactionTotals" args="${[message(code: vehicle)]}"/></g:link>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'earning.png')}"/>

            </span>
            <g:link controller="report" action="bptByBusDriver" params="${[id:'p']}"><g:message code="report.bptByBusDriver" args="${[message(code: vehicle)]}"/></g:link>

        </li>

        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'driverSum.png')}" />
            </span>
            <g:link controller="report" action="busDriversSummary" params="${[id:'p']}"><g:message code="report.busDriversSummary" args="${[message(code: vehicle)]}"/></g:link>
        </li>
    </ul>
</div>
<div class="set bus">
    <ul>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'cash_register.png')}"/>
            </span>
            <g:link controller="report" action="bptByBus" params="${[id:'p']}"><g:message code="report.bptByBus" args="${[message(code: vehicle)]}"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: vehicle + '.png')}"/>
            </span>
            <g:link controller="report" action="busList" params="${[id:'s']}"><g:message code="report.busList" args="${[message(code: vehicle)]}"/></g:link>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'Calendar.png')}"/>
            </span>
            <g:link controller="report" action="busMonthly" params="${[id:'p']}"><g:message code="report.busMonthly" args="${[message(code: vehicle)]}"/></g:link>
            <g:link controller="report" action="govBusMonthly" params="${[id:'p']}"><g:message code="report.govBusMonthly" args="${[message(code: vehicle)]}"/></g:link>
            <g:link controller="report" action="privateBusMonthly" params="${[id:'p']}"><g:message code="report.privateBusMonthly" args="${[message(code: vehicle)]}"/></g:link>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'schedule.png')}"/>
            </span>
            <g:link controller="report" action="busDaily" params="${[id:'p']}"><g:message code="report.busDaily" args="${[message(code: vehicle)]}"/></g:link>
            <g:link controller="report" action="govBusDaily" params="${[id:'p']}"><g:message code="report.govBusDaily" args="${[message(code: vehicle)]}"/></g:link>
            <g:link controller="report" action="privateBusDaily" params="${[id:'p']}"><g:message code="report.privateBusDaily" args="${[message(code: vehicle)]}"/></g:link>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'brand.png')}" />
            </span>
            <g:link controller="report" action="busListByBrand" params="${[id:'p']}"><g:message code="report.busListByBrand" args="${[message(code: vehicle)]}"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'driver-bus.png')}" />
            </span>
            <g:link controller="report" action="dailyBusWithDriverTransactionTotals" params="${[id:'p']}"><g:message code="report.dailyBusWithDriverTransactionTotals" args="${[message(code: vehicle)]}"/></g:link>
        </li>

    </ul>
</div>
<div class="set busline">
    <ul>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'Bus_Line.png')}" />
            </span>
            <g:link controller="report" action="busLineList" params="${[id:'s']}"><g:message code="report.busLineList" args="${[message(code: vehicle)]}"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'ColumnChart.png')}" />
            </span>
            <g:link controller="report" action="busLineHourOfDaySumChart" params="${[id:'p']}"><g:message code="report.busLineHourOfDaySumChart"/></g:link>
            <g:link style="margin-top:14px;" controller="report" action="busLineHourOfDayCountChart" params="${[id:'p']}"><g:message code="report.busLineHourOfDayCountChart"/></g:link>
        </li>

        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'time_report.png')}" />
            </span>
            <g:link controller="report" action="busLineHourOfDayTotal" params="${[id:'p']}"><g:message code="report.busLineHourOfDayTotal"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'calculator.png')}" />
            </span>
            <g:link controller="report" action="busLineDailyTotal" params="${[id:'p']}"><g:message code="report.busLineDailyTotal" args="${[message(code: vehicle)]}"/></g:link>

        </li>

        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'sum.png')}" />
            </span>
            <g:link controller="report" action="busLinesSummary" params="${[id:'p']}"><g:message code="report.busLinesSummary" args="${[message(code: vehicle)]}"/></g:link>

        </li>

        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'coins.png')}" />
            </span>
            <g:link controller="report" action="busLineFinancialReport" params="${[id:'p']}"><g:message code="report.busLineFinancialReport" args="${[message(code: vehicle)]}"/></g:link>

        </li>

    </ul>
</div>
<div class="set charge">
    <ul>
        <li>
            <span>

                <img src="${resource(dir: 'images/reportMenuImages', file: 'charge.png')}" />
            </span>
            <g:link controller="chargeReports" action="allChargeTransactions" params="${[id:'p']}"><g:message code="report.allChargeTransactions"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'chargePos.png')}" />
            </span>
            <g:link style="direction:rtl" controller="chargeReports" action="chargePosList" params="${[id:'s']}"><g:message code="report.chargePosList"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'list.png')}" />
            </span>
            <g:link style="direction:rtl" controller="chargeReports" action="posChargeTransactions" params="${[id:'p']}"><g:message code="report.posChargeTransactions"/></g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'Add.png')}" />
            </span>
            <g:link style="direction:rtl" controller="chargeReports" action="posChargeSum" params="${[id:'p']}">مجموع تراکنشهای شارژ pos</g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'money.png')}" />
            </span>
            <g:link style="direction:rtl" controller="chargeReports" action="posesChargeTransactionsSum" params="${[id:'p']}"><g:message code="report.posesChargeTransactionsSum"/></g:link>

        </li>

    </ul>
</div>
<div class="set decharge">
    <ul>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'decharge.png')}" />
            </span>
            <g:link controller="report" action="bptByPos" params="${[id:'p']}">تراکنشهای کاهنده</g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'monthlyReport.png')}" />
            </span>
            <g:link controller="report" action="dechargePOSMonthlyTotal" params="${[id:'p']}">گزارش کارکرد ماهانه کاهنده ها</g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'dechargeChart.png')}" />
            </span>
            <g:link controller="report" action="dechargePOSMonthlyChart" params="${[id:'p']}">نمودار کارکرد ماهانه دستگاه کاهنده</g:link>

        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'dechargePosList.png')}" />
            </span>
            <g:link controller="report" action="dechargePosList" params="${[id:'s']}">ليست کاهنده ها</g:link>

        </li>

    </ul>
</div>
<div class="set card">
    <ul>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'cardTransactions.png')}" />
            </span>

            <g:link controller="chargeReports" action="cardChargeTransactions" params="${[id:'p']}"><g:message code="report.cardChargeTransactions"/></g:link>
        </li>
        <li>
            <span>
                <img src="${resource(dir: 'images/reportMenuImages', file: 'cardChargSum.png')}" />
            </span>
            <g:link controller="chargeReports" action="cardChargeSum" params="${[id:'p']}"><g:message code="report.cardChargeSum"/></g:link>

        </li>

    </ul>
</div>
</div>
</div>
</div>
</body>
</html>