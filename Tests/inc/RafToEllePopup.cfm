<cfdump var="#attributes#">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=3">
    <cfquery name="GETS" datasource="#DSN3#">
        SELECT * FROM STOCKS WHERE STOCK_ID =#attributes.STOCK_ID#
    </cfquery>
    <table>
        <TR>
            <TH>
                Ürün
            </TH>
            <TD>
                <cfoutput>#GETS.PRODUCT_NAME#</cfoutput>
            </TD>
        </tr>
        <tr>
            <TH>
                Miktar (Çuval)
            </TH>
            <td>
                <input type="text" name="DEF_A" id="Amount" onchange="KILO_HESAPLA(this)" value="<cfoutput>#attributes.DEF_A#</cfoutput>">
                <input type="hidden" name="CV" id="CV" value="<cfoutput>#attributes.CV#</cfoutput>">      
                <input type="hidden" name="LOT" value="<cfoutput>#attributes.LOT#</cfoutput>">      
                <input type="hidden" name="PROJECT_ID" value="<cfoutput>#attributes.PROJECT_ID#</cfoutput>">      
                <input type="hidden" name="STOCK_ID" value="<cfoutput>#attributes.STOCK_ID#</cfoutput>"> 
                <input type="hidden" name="IS_SUBMIT" value="<cfoutput>#1#</cfoutput>">      
                <input type="hidden" name="DEF" id="KILO" value="<cfoutput>#attributes.DEF#</cfoutput>"> 
                <input type="hidden" name="SHELFCODE" id="SHELFCODE" value="<cfoutput>#attributes.SHELFCODE#</cfoutput>">     
                <input type="hidden" name="PRODUCT_PLACE_ID" id="PRODUCT_PLACE_ID" value="<cfoutput>#attributes.PRODUCT_PLACE_ID#</cfoutput>">      
            </td>
        </TR>
    </table>
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cfquery name="getS2" datasource="#dsn3#">
        select * from w3Toruntex_1.PRODUCT_PLACE where PRODUCT_PLACE_ID=#attributes.PRODUCT_PLACE_ID#
    </cfquery>


    <cfset attributes.LOCATION_IN=3>
    <cfset attributes.LOCATION_OUT=getS2.LOCATION_ID>
    <cfset attributes.department_out=getS2.STORE_ID>
    <cfset attributes.department_in =7>
    <cfset form.process_cat=255>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD=attributes.PROJECT_ID>
   <cfset PROJECT_HEAD_IN=attributes.PROJECT_ID>
   <cfset PROJECT_ID=attributes.PROJECT_ID>
   <cfset PROJECT_ID_IN=attributes.PROJECT_ID>
   <cfset attributes.QUANTITY=attributes.DEF>
   <cfset attributes.uniq_relation_id_="">
   <cfset amount_other=DEF_A>
   <cfset unit_other="Çuval">
   <cfset lot_no=attributes.LOT>
 
<cfset attributes.ROWW=" ,">
<cfdump var="#listLen(attributes.ROWW)#">
<cfinclude template="StokFisQuery.cfm">
<cfdump var="#attributes#">
<script>
    window.opener.location.reload();
    this.close();
</script>
</cfif>
<script>
    function KILO_HESAPLA(el){
        var cv=document.getElementById("CV").value
        var Amount=document.getElementById("Amount").value
        var kilo=parseFloat(Amount)*parseFloat(cv);
        document.getElementById("KILO").value=kilo
    }
</script>
