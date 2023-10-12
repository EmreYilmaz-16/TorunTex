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
<input type="hidden" name="is_submit" value="1">
</cfform>
<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    <cfset attributes.LOCATION_IN="">
    <cfset attributes.LOCATION_OUT=3>
    <cfset attributes.department_out=7>
    <cfset attributes.department_in ="">
    <cfset form.process_cat=89>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset lot_no="">
  <cfinclude template="StokFisQuery.cfm">
 


    
</cfif>
<script src="/AddOns/Partner/js/Sepet.js"></script>