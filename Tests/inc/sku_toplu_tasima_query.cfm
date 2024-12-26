<cfquery name="GETSKU" datasource="#dsn#">
    SELECT * FROM #dsn3#.STOCKS WHERE PRODUCT_CODE_2 = '#attributes.SKU_CODE#'
</cfquery>
<cfdump var="#GETSKU#">
    <CFIF GETSKU.RECORDCOUNT EQ 0>
<cfquery name="getStocks" datasource="#dsn2#">
    
SELECT T.*,S.PRODUCT_NAME FROM (
SELECT STOCK_ID,LOT_NO,SUM(STOCK_IN-STOCK_OUT) BAKIYE FROM STOCKS_ROW AS SR 
WHERE SR.STORE=#listGetAt(attributes.FromLocationId,1,"-")# AND SR.STORE_LOCATION=#listGetAt(attributes.FromLocationId,2,"-")#
GROUP BY STOCK_ID,LOT_NO
) AS T
LEFT JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=T.STOCK_ID
WHERE BAKIYE>0 
AND S.STOCK_ID=#GETSKU.STOCK_ID#
ORDER BY STOCK_ID
</cfquery>


<cfelse>
<CFSET getStocks.recordCount=0>
    
</CFIF>