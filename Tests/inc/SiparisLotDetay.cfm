<cfquery name="getld" datasource="#dsn3#">
    

    select WRK_ROW_ID,T.FIS_NUMBER,LNO,STORE,STORE_LOCATION,STOCK_IN,SS.PRODUCT_CODE,SS.PRODUCT_NAME,SS.PRODUCT_CODE_2,SS.PRODUCT_NAME+'|'+LNO+'||'+CONVERT(VARCHAR,STOCK_IN) AS NEW_LOT_BARCODE,SL.COMMENT,T.RECORD_DATE,E.EMPLOYEE_NAME+' '+E.EMPLOYEE_SURNAME AS REMP
 from w3Toruntex_1.ORDER_ROW  AS ORR
 OUTER APPLY(
  SELECT FIS_NUMBER,LOT_NO AS LNO,STORE,STORE_LOCATION,STOCK_IN,sf.RECORD_EMP,sf.RECORD_DATE FROM w3Toruntex_2024_1.STOCKS_ROW AS SR
LEFT JOIN w3Toruntex_2024_1.STOCK_FIS AS SF ON SF.FIS_ID=SR.UPD_ID
 WHERE PBS_RELATION_ID=ORR.WRK_ROW_ID AND SF.PROCESS_CAT=87
 )AS T
 LEFT JOIN w3Toruntex_1.STOCKS AS SS ON SS.STOCK_ID=ORR.STOCK_ID
 LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=STORE AND SL.LOCATION_ID=STORE_LOCATION
 LEFT JOIN w3Toruntex.EMPLOYEES AS E ON E.EMPLOYEE_ID=T.RECORD_EMP
 WHERE ORDER_ID=#attributes.ORDER_ID# ORDER BY SS.STOCK_ID
</cfquery>
<cf_big_list>
    <thead>
        <tr>
            <th>Lot No</th>
            <th>Barko</th>
        <th>Ü.Kodu</th>
        <th>Ürün</th>
        <th>Miktar</th>
        <th>Üretim Fiş No</th>
        <th>İstasyon</th>
        <th>K.Tarihi</th>
        <th>Kaydeden</th>
        </tr>
        
    </thead>
    <tbody>
<cfoutput query="getld">
    <tr>
        <td>
            #LNO#
        </td>
        <td>
            <a href="javascript://" onclick='openBoxDraggable("index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=15&Barkod=#NEW_LOT_BARCODE#&is_submit=1")'>#NEW_LOT_BARCODE#</a>
        </td>
        <td>#PRODUCT_CODE#</td>
        <td>#PRODUCT_NAME#</td>
        <td>#STOCK_IN#</td>
        <td>#FIS_NUMBER#</td>
        <td>#COMMENT#</td>
        <td>#dateformat(RECORD_DATE,"dd/mm/yyyy")#</td>
        <td>#REMP#</td>
    </tr>
</cfoutput>
</tbody>
</cf_big_list>
