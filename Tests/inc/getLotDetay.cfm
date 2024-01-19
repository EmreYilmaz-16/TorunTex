<cf_box title="Lot Detayları">
<cfquery name="getData" datasource="#dsn2#">
    SELECT TB.*,D.DEPARTMENT_HEAD,SL.COMMENT,PP.SHELF_CODE,SL.DEPARTMENT_LOCATION FROM (
SELECT SUM(STOCK_IN-STOCK_OUT) AS B ,LOT_NO,SHELF_NUMBER,STORE,STORE_LOCATION FROM STOCKS_ROW 
WHERE STOCK_ID=#attributes.stock_id# GROUP BY LOT_NO,SHELF_NUMBER,STORE,STORE_LOCATION
) AS TB 
LEFT JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID=TB.STORE
LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=TB.STORE_LOCATION AND SL.DEPARTMENT_ID=TB.STORE
LEFT JOIN #dsn3#.PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=TB.SHELF_NUMBER
WHERE B>0
</cfquery>

<cf_ajax_list>
    <thead>
    <tr>
        <th>Depo</th>
        <th>Raf</th>
        <th>Seri (Lot No)</th>
        <th>Miktar</th>
    </tr>
</thead>
<tbody>
<cfoutput query="getData">
    <tr>
        <td>
            #DEPARTMENT_HEAD#-#COMMENT#
        </td>
        <td>
            <cfif len(SHELF_CODE)>
           #DEPARTMENT_LOCATION#-#SHELF_CODE# 
        </cfif>
        </td>
        <td>
            #LOT_NO# 
        </td>
        <td>
            #B# 
        </td>
    </tr>
</cfoutput>
</tbody>
</cf_ajax_list>
</cf_box>