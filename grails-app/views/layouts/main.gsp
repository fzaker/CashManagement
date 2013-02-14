<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js" ng-app><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(plugin: 'rapid-grails', dir: 'css', file: 'rapidgrails.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'css3.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'theme.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'msgGrowl.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(plugin: 'rapid-grails', dir: 'css', file: 'rg-rtl.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(plugin: 'rapid-grails', dir: 'css', file: 'jquery-ui-rtl.css')}" type="text/css">

    <ckeditor:resources/>
    <g:javascript plugin="rapid-grails" src="angular.min.js"></g:javascript>
    <g:javascript library="jquery"></g:javascript>
    <r:layoutResources/>
    <jqui:resources theme="bootstrap"></jqui:resources>

    <g:javascript plugin="rapid-grails" src="utils.js"></g:javascript>
    <g:javascript plugin="rapid-grails" src="grid_utils.js"></g:javascript>
    <g:javascript plugin="rapid-grails" src="jquery.json-2.3.min.js"></g:javascript>
    <g:javascript plugin="rapid-grails" src="jquery.form.js"></g:javascript>

    <link rel="stylesheet"
          href="${resource(dir: 'css/datepicker', file: 'ui.datepicker.css', plugin: 'rapid-grails')}"/>
    <g:javascript src="datepicker/jquery.ui.datepicker-cc.js" plugin="rapid-grails"/>
    <g:javascript src="datepicker/calendar.js" plugin="rapid-grails"/>
    <g:javascript src="datepicker/jquery.ui.datepicker-cc-fa.js" plugin="rapid-grails"/>

    <rg:jqgridResources></rg:jqgridResources>
    <g:javascript src="jquery.labelify.js"></g:javascript>
    <g:javascript src="theme.js"></g:javascript>

    <rg:jstreeResources/>

    <script language="javascript" src="${resource(dir: 'js', file: 'msgGrowl.js')}" type="text/javascript"></script>

    <link rel="stylesheet" href="${resource(dir: 'css/superfish', file: 'superfish.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/superfish', file: 'superfish-rtl.css')}"/>
    <g:javascript src="superfish/hoverIntent.js"/>
    <g:javascript src="superfish/superfish.js"/>
    <g:javascript src="superfish/supersubs.js"/>

    <g:javascript>
        jQuery(function() {
            jQuery('ul.sf-menu').supersubs({maxWidth: 27, extraWidth: 1}).superfish();
        });
    </g:javascript>

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'common.css')}"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/themes', file: (setting?setting.siteColor:'blue') + '.css')}"/>

    <g:layoutHead/>
</head>

<body dir="rtl">
<div id="bokeh"><div id="container">
    <div id="header" role="banner">
        <h1 id="logo">Application Title</h1>
    </div><!-- end #header -->

    <g:render template="/menu"/>

    <div id="content">
        <g:layoutBody/>
    </div>
</div>
</div>


<div id="footer" role="contentinfo">
    <g:message code="application.name" default="Cash Management System"/> | <g:message code="application.copyRight"
                                                                                    default="© AGAH-IT 2012"/>
</div><!-- end #footer -->

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt"
                                                                   default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources/>

<script>

    function msgSuccess(text) {
        $.msgGrowl({
            type:'success', 'text':text, position:'bottom-left'
        });
    }

    function msgInfo(text) {
        $.msgGrowl({
            type:'info', 'text':text, position:'bottom-left'
        });
    }

    function msgWarning(text) {
        $.msgGrowl({
            type:'warning', 'text':text, position:'bottom-left'
        });
    }

    function msgError(text) {
        $.msgGrowl({
            type:'error', 'text':text, position:'bottom-left'
        });
    }
</script>
</body>
</html>
