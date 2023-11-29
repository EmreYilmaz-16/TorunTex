<cf_box title="Yazıcılar">
<cfquery name="GetIpa" datasource="#dsn#">
SELECT SPR.*,SL.COMMENT,D.DEPARTMENT_HEAD FROM STATION_PRINTER_RELATION_PBS AS SPR 
LEFT JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID =SPR.STORE_ID
LEFT JOIN STOCKS_LOCATION AS SL ON SL.LOCATION_ID =SPR.LOCATION_ID AND SL.DEPARTMENT_ID=D.DEPARTMENT_ID 
</cfquery>

<cf_big_list>
    <tr>
        <th></th>
        <th>Departman</th>
        <th>İstasyon</th>
        <th>Yazıcı Adı</th>
        <th>İp Adresi</th>
        <th><i class="fa fa-plus" id="basket_header_add_2" onclick="window.location.href='/index.cfm?fuseaction=#attributes.fuseaction#&sayfa=21&iid=0'"></i></th>
    </tr>
    <cfoutput query="GetIpa">
        <tr>
            <td>#currentrow#</td>
            <td>#DEPARTMENT_HEAD#</td>
            <td>#COMMENT#</td>
            <td>#PRINTER_NAME#</td>
            <td>#IP_ADDRESS#</td>
            <td><i class="icon-search" onclick="window.location.href='/index.cfm?fuseaction=#attributes.fuseaction#&sayfa=21&iid=#ID#'"></i></td>
        </tr>
    </cfoutput>
</cf_big_list>
</cf_box>