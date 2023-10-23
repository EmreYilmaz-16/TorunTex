<cfquery name="gets" datasource="#dsn2#">
    SELECT SUM(STOCK_IN-STOCK_OUT) AS BAK,SR.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME FROM STOCKS_ROW SR
    LEFT JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID
    WHERE STORE=7 AND STORE_LOCATION=7 GROUP BY SR.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME
</cfquery>

<cfdump var="#gets#">
<table>
<cfoutput query="gets">
    <tr>
        <td>
            #PRODUCT_CODE#
        </td>
        <td>
            #PRODUCT_NAME#
        </td>
        <td>
            <button type="button" onclick="SendMasa(#STOCK_ID#)"></button>
        </td>
    </tr>
</cfoutput>
</table>
<script>
function SendMasa(STOCK_ID) {
    openBoxDraggable("index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=7&stok_id="+STOCK_ID);
    

}

</script>