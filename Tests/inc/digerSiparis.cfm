<cf_box>
<cfquery name="gets" datasource="#dsn3#">
    SELECT ORR.QUANTITY,C.NICKNAME,ORR.UNIT2,SP.PRIORITY,SL.COMMENT,SBI_1.BASKET_INFO_TYPE AS BINFO_1,SBI_2.BASKET_INFO_TYPE AS BINFO_2,SC.COUNTRY_NAME 
,ISNULL((SELECT SUM(STOCK_IN) AS S_IN FROM w3Toruntex_2023_1.STOCKS_ROW  WHERE PBS_RELATION_ID=ORR.WRK_ROW_ID AND PROCESS_TYPE=110),0) AS URETIM
FROM w3Toruntex_1.ORDER_ROW AS ORR
INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
INNER JOIN w3Toruntex.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID=O.PRIORITY_ID
INNER JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID =O.COMPANY_ID
INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID =O.DELIVER_DEPT_ID AND
SL.LOCATION_ID=O.LOCATION_ID
          LEFT JOIN w3Toruntex_1.SETUP_BASKET_INFO_TYPES  AS SBI_1 ON ORR.SELECT_INFO_EXTRA =SBI_1.BASKET_INFO_TYPE_ID
            LEFT JOIN w3Toruntex_1.SETUP_BASKET_INFO_TYPES  AS SBI_2 ON ORR.BASKET_EXTRA_INFO_ID =SBI_2.BASKET_INFO_TYPE_ID
LEFT JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID=O.COUNTRY_ID
WHERE STOCK_ID =#attributes.STOCK_ID#
</cfquery>
<cf_big_list id="digerSiparisTbl" class="table table-sm">
  <thead>
    <tr>
        <th>
            Öncelik
        </th>
        <th>
            İstasyon
        </th>
        <th>
            Lokasyon
        </th>
        <th>
            Müşteri
        </th>
        <th>
            Paket Kg
        </th>
        <th>
            Ülkesi
        </th>
        <th>
            Eksik Kg
        </th>        
    </tr>
</thead>
<tbody>
    <cfoutput query="gets">
        <tr>
            <td style="width:7%">#PRIORITY#</td>
            <td style="width:13%">#UNIT2#</td>
            <td style="width:14%">#COMMENT#</td>
            <td style="width:30%"><cfif len(NICKNAME) gt 20>#left(NICKNAME,20)#<cfelse>#NICKNAME#</cfif> </td>
            <td style="width:10%">#BINFO_2#</td>
            <td style="width:13%">#COUNTRY_NAME#</td>
            <td style="width:13%">#tlformat(QUANTITY-URETIM)#</td>
        </tr>
    </cfoutput>
</tbody>
</cf_big_list>
</cf_box>