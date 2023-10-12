<cfparam name="YM_CAT" default="Original-YM.%">
<cfquery name="GetYmOrg" datasource="#dsn2#">
    SELECT * FROM w3Toruntex_1.STOCKS WHERE STOCK_CODE LIKE '#YM_CAT#%'
</cfquery>
<cf_grid_list>
<cfoutput query="GetYmOrg">
<tr>
    <td>
        #PRODUCT_NAME#
    </td>
    <td>
        <button onclick="SepeteEkle(#PRODUCT_ID#,#STOCK_ID#)">Sepete Ekle</button>
    </td>
</tr>
</cfoutput>
</cf_grid_list>
<cf_box title="Sepetim">
    <cf_grid_list>
        <tbody id="basket"></tbody>
    </cf_grid_list>
</cf_box>




<script src="/AddOns/Partner/js/Sepet.js"></script>