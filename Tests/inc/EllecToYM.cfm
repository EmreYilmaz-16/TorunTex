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
    <cfset QQ=queryNew("SID,PID,AMOUNT,STOCK_ID,PRODUCT_ID","INTEGER,INTEGER,DECIMAL,INTEGER,INTEGER")>
    <cfloop list="#attributes.ROWW#" item="li" index="ix">
        <cfquery name="getRel" datasource="#dsn3#">
            SELECT sum(STOCK_IN - STOCK_OUT)
                ,STOCK_ID
                ,PRODUCT_ID
            FROM w3Toruntex_2023_1.STOCKS_ROW
            WHERE PRODUCT_ID IN (
                    SELECT RELATED_PRODUCT_ID
                    FROM w3Toruntex_1.RELATED_PRODUCT
                    WHERE PRODUCT_ID = #evaluate("attributes.PRODUCT_ID#li#")#
                    )
                AND STORE = 7
                AND STORE_LOCATION = 3
            GROUP BY STOCK_ID
                ,PRODUCT_ID
        </cfquery>    
        <cfdump var="#getRel#">
        <cfif getRel.recordCount>
        <cfset QS={
            SID=evaluate("attributes.STOCK_ID#li#"),
            PID=evaluate("attributes.PRODUCT_ID#li#"),
            AMOUNT=evaluate("attributes.QUANTITY#li#")
            STOCK_ID=getRel.STOCK_ID,
            PRODUCT_ID=getRel.PRODUCT_ID,
        }>
        <cfscript>
            queryAddRow(QQ,QS);
        </cfscript>
        <cfelse>
            <cfoutput>
                #evaluate("attributes.PRODUCT_NAME#li#")# Ürününün Elleçleme Depoda Hammaddesi Bulunmamaktadır
            </cfoutput>
        </cfif>
    </cfloop>    
    <cfquery name="QQ_2" dbtype="query">
        SELECT SUM(AMOUNT),STOCK_ID,PRODUCT_ID FROM QQ GROUP BY  STOCK_ID,PRODUCT_ID
    </cfquery>

    <cfdump var="#QQ#">
    <cfdump var="#QQ_2#">
    
</cfif>
<script src="/AddOns/Partner/js/Sepet.js"></script>,



<!------

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
   <cfset AMOUNT_OTHER ="">
   <cfset unit_other="">
  <!---<cfinclude template="StokFisQuery.cfm">---->
 

<cfset MyStruct=attributes>
<cfloop list="#attributes.ROWW#" item="li" index="ix">
    <cfset STOCK_ID=evaluate("attributes.STOCK_ID#li#")>
    <cfset PRODUCT_ID=evaluate("attributes.PRODUCT_ID#li#")>
    <cfset AMOUNT=evaluate("attributes.QUANTITY#li#")>


    


</cfloop>


<cfdump var="#MyStruct#">
<cfdump var="#attributes#">----->