<cfquery name="getld" datasource="#dsn3#">
    

    select WRK_ROW_ID,T.FIS_NUMBER,LNO,STORE,STORE_LOCATION,STOCK_IN,SS.PRODUCT_CODE,SS.PRODUCT_NAME,SS.PRODUCT_CODE_2,SS.PRODUCT_NAME+'|'+LNO+'||'+CONVERT(VARCHAR,STOCK_IN) AS NEW_LOT_BARCODE,SL.COMMENT
 from w3Toruntex_1.ORDER_ROW  AS ORR
 OUTER APPLY(
  SELECT FIS_NUMBER,LOT_NO AS LNO,STORE,STORE_LOCATION,STOCK_IN FROM w3Toruntex_2024_1.STOCKS_ROW AS SR
LEFT JOIN w3Toruntex_2024_1.STOCK_FIS AS SF ON SF.FIS_ID=SR.UPD_ID
 WHERE PBS_RELATION_ID=ORR.WRK_ROW_ID AND SF.PROCESS_CAT=87
 )AS T
 LEFT JOIN w3Toruntex_1.STOCKS AS SS ON SS.STOCK_ID=ORR.STOCK_ID
 LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=STORE AND SL.LOCATION_ID=STORE_LOCATION
 WHERE ORDER_ID=#attributes.ORDER_ID# ORDER BY SS.STOCK_ID
</cfquery>
<cf_big_list>
<cfoutput query="getld">
    <tr>
        <td>
            #LNO#
        </td>
        <td>
            <a href="javascript://">#NEW_LOT_BARCODE#</a>
        </td>
        <td>#PRODUCT_CODE#</td>
        <td>#PRODUCT_NAME#</td>
        <td>#STOCK_IN#</td>
        <td>#FIS_NUMBER#</td>
        <td>#COMMENT#</td>
    </tr>
</cfoutput>
</cf_big_list>