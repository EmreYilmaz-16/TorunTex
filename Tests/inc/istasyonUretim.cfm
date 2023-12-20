<cfquery name="gets" datasource="#dsn2#">
 SELECT TOP 5 SR.STOCK_IN AS AMOUNT
	,C.NICKNAME
	,SL.COMMENT
	,O.ORDER_NUMBER
	,S.PRODUCT_NAME 
    ,SR.UPD_ID
    ,SR.LOT_NO
    ,(SELECT COUNT(*) AS SS FROM #dsn2#.STOCKS_ROW 
INNER JOIN #dsn2#.STOCK_FIS AS SF ON SF.FIS_ID=STOCKS_ROW.UPD_ID
WHERE LOT_NO=SR.LOT_NO AND SF.PROCESS_CAT  NOT IN (87,255)
) AS HAREKET_VAMI
    FROM #DSN2#.STOCKS_ROW AS SR    
LEFT JOIN #dsn3#.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID = SR.PBS_RELATION_ID
LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID = ORR.ORDER_ID
LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID = SR.STORE
	AND SL.LOCATION_ID = SR.STORE_LOCATION
LEFT JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID = SR.STOCK_ID

 WHERE STORE=#attributes.DEPARTMENT_ID# AND STORE_LOCATION=#attributes.LOCATION_ID#
AND PROCESS_TYPE = 110
ORDER BY SR.PROCESS_DATE DESC
</cfquery>

<cf_big_list class="table table-sm table-stripped" SHOW_FS="0">
  <thead>
    <tr>
        <th>Seri</th>
        <th>
            Ürün
        </th>
        <th>
            Müşteri
        </th>
        <th>Sipariş No</th>
        <th>
            Miktar
        </th>
        <th>
            
        </th>
    </tr>
</thead>
<tbody>
    <cfoutput query="gets">
        <tr>
            <td>#LOT_NO#</td>
            <td>#PRODUCT_NAME#</td>
            <td ><cfif len(NICKNAME) gt 20>#left(NICKNAME,20)#<cfelse>#NICKNAME#</cfif> </td>  
            <td>#ORDER_NUMBER#</td>
            <td>#AMOUNT#</td>
            <td><cfif HAREKET_VAMI eq 0>
                <input type="radio" name="SELRADIO" value="#LOT_NO#">
            </cfif>
            </td>
        </tr>
    </cfoutput>
</tbody>
</cf_big_list>