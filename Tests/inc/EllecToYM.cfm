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
        <button onclick="SepeteEkle(#PRODUCT_ID#,#STOCK_ID#,'#PRODUCT_NAME#')">Sepete Ekle</button>
    </td>
</tr>
</cfoutput>
</cf_grid_list>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=4">
<cf_box title="Sepetim">
    <cf_grid_list>
        <tbody id="basket"></tbody>
    </cf_grid_list>
</cf_box>
<input type="submit">
</cfform>



<script src="/AddOns/Partner/js/Sepet.js"></script>