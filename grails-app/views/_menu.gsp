<div id="menu">
    <ul class="sf-menu Menu">
        <li class="MenuItem current">
            <a href="#a" class="sf-top-level-anchor toplevel">اطلاعات پايه</a>
            <ul>
                <li>
                    <a href="#aa">صفات عمومی</a>
                    <ul>
                        <li><g:link controller="color">رنگ ها</g:link></li>
                        <li><g:link controller="deviceStatus">وضعيت دستگاه</g:link></li>
                        <li><g:link controller="gasType">انواع سوخت</g:link></li>
                        <li><g:link controller="placeType">انواع مکان</g:link></li>
                        <li><g:link controller="posType">انواع POS</g:link></li>
                        <li><g:link controller="busBrand">انواع برند</g:link></li>
                    </ul>
                </li>
                <li>
                    <g:link controller="place">مکان ها</g:link>
                </li>
                <li class="current">
                    <a href="#ab">Test</a>
                    <ul>
                        <li><g:link controller="bus"><g:message code="${vehicle}"/> ها</g:link></li>
                        <li><g:link controller="busLine"><g:message code="${vehicle}.lines"/></g:link></li>
                        <li><g:link controller="busDriver"><g:message code="${vehicle}.drivers"/></g:link></li>
                    </ul>
                </li>
            </ul>
        </li>
        <li class="MenuItem">
            <a href="#a" class="sf-top-level-anchor toplevel">Menu 2</a>
        </li>
    </ul>
</div>