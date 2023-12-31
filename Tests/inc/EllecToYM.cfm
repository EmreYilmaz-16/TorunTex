<cf_box title="YM-DEPO Fişi">
<cfparam name="YM_CAT" default="OYM.%">
<cfquery name="GetYmOrg" datasource="#dsn2#">
    SELECT * FROM #dsn3#.STOCKS WHERE STOCK_CODE LIKE '#YM_CAT#%'
</cfquery>
<div style="height:30vh;overflow-x: none;overflow-y: scroll;">
<cf_grid_list>
<cfoutput query="GetYmOrg">
<tr>
    <td style="width:90%">
        #PRODUCT_NAME#
    </td>
    <td style="width:10%;text-align:center">
        <button class="btn btn-sm btn-warning"  onclick="SepeteEkle(#PRODUCT_ID#,#STOCK_ID#,'#PRODUCT_NAME#')"><span class="icn-md icon-download"></span></button>
    </td>
</tr>
</cfoutput>
</cf_grid_list>
</div>

<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=4">
    
<cf_box title="Sepetim">
    <div style="height:40vh;overflow-y: scroll;overflow-x: none;">
    <cf_grid_list>
        <tbody id="basket"></tbody>
    </cf_grid_list>
</div>
</cf_box>

<button type="submit" class="btn btn-success">Kaydet</button>
<input type="hidden" name="is_submit" value="1">
</cfform>


<cfif isDefined("attributes.is_submit")>
    
    <cfset OutputStr=serializeJSON(attributes)>
    
    <cfset QQ=queryNew("SID,PID,AMOUNT,STOCK_ID,PRODUCT_ID","INTEGER,INTEGER,DECIMAL,INTEGER,INTEGER")>
    <cfloop list="#attributes.ROWW#" item="li" index="ix">
        <cfquery name="getRel" datasource="#dsn3#">
            SELECT sum(STOCK_IN - STOCK_OUT)
                ,STOCK_ID
                ,PRODUCT_ID
            FROM #dsn2#.STOCKS_ROW
            WHERE PRODUCT_ID IN (
                    SELECT RELATED_PRODUCT_ID
                    FROM #dsn3#.RELATED_PRODUCT
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
            AMOUNT=evaluate("attributes.QUANTITY#li#"),
            STOCK_ID=getRel.STOCK_ID,
            PRODUCT_ID=getRel.PRODUCT_ID
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
        SELECT SUM(AMOUNT) AS AMOUNT,STOCK_ID,PRODUCT_ID FROM QQ GROUP BY  STOCK_ID,PRODUCT_ID
    </cfquery>

    <cfscript>
        structClear(attributes);
    </cfscript>
    <CFSET attributes.ROWW="">
    <cfloop query="QQ_2">
        <CFSET attributes.ROWW="#currentrow#,">
        <CFSET "attributes.STOCK_ID#currentrow#"="#STOCK_ID#">
        <CFSET "attributes.PRODUCT_ID#currentrow#"="#PRODUCT_ID#">
        <CFSET "attributes.QUANTITY#currentrow#"="#AMOUNT#">
        <cfset "attributes.PBS_RELATION_ID#currentrow#"="">
        <CFSET "attributes.row_unique_relation_id#currentrow#"="">
    </cfloop>
    
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
   

 <cfinclude template="StokFisQuery.cfm">
 
 <cfset PreSt=serializeJSON(attributes)>
 <br>PREST=<br>
 <cfdump var="#PreSt#">
<cfscript>
    structClear(attributes);
</cfscript>
<cfset attributes=deserializeJSON(OutputStr)>

<cfdump var="#attributes#">

<cfset pra=deserializeJSON(PreSt)>
<cfset attributes.LOCATION_IN="7">
<cfset attributes.LOCATION_OUT="0">
<cfset attributes.department_out="0">
<cfset attributes.department_in ="7">
<cfset form.process_cat=87>
<cfset attributes.process_cat = form.process_cat>
<cfset PROJECT_HEAD="">
<cfset PROJECT_HEAD_IN="">
<cfset PROJECT_ID="">
<cfset PROJECT_ID_IN="">
<cfset lot_no="">
<cfset AMOUNT_OTHER ="">
<cfset unit_other="">
<cfset attributes.PBS_RELATION_ID="">
<cfset attributes.ref_no=pra.FIS_NO>
<cfinclude template="StokFisQuery.cfm">
</cfif>
</cf_box>
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