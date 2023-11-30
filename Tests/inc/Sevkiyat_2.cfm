
<cfdump var="#attributes#">
<cfset DEPARTMENT_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),1,"-")>
<cfset LOCATION_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),2,"-")>
<cfset ORDER_ID=listGetAt(attributes.SELECT1,2,"*")>
<cfset SEPET_ID=listGetAt(attributes.SELECT1,3,"*")>
<CFIF SEPET_ID EQ 0>
    <script>
        window.LOCATION_ID.href="/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=24&SELECT1=<cfoutput>#attributes.select1#</cfoutput>";
        <cfabort>
    </script>
</CFIF>
<cfquery name="GETmX" datasource="#DSN3#">
    select ISNULL(max(SEPET_ID),0 )+1 SEPET_ID  from  w3Toruntex_1.SEVKIYAT_SEPET_PBS
</cfquery>
<CFSET SEPET_NO="">
<CFIF LEN(GETmX.SEPET_ID) EQ 1>
    <CFSET SEPET_NO="0000000#GETmX.SEPET_ID#">
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 2>
    <CFSET SEPET_NO="000000#GETmX.SEPET_ID#">
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 3>
    <CFSET SEPET_NO="00000#GETmX.SEPET_ID#">
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 4>
    <CFSET SEPET_NO="0000#GETmX.SEPET_ID#">
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 5>
    <CFSET SEPET_NO="000#GETmX.SEPET_ID#">   
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 6>
    <CFSET SEPET_NO="00#GETmX.SEPET_ID#">  
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 7>
    <CFSET SEPET_NO="0#GETmX.SEPET_ID#">  
<CFELSEIF LEN(GETmX.SEPET_ID) EQ 8>
    <CFSET SEPET_NO="0#GETmX.SEPET_ID#">                                
</CFIF>
<cfquery name="CREATE_SEPET" datasource="#DSN3#" result="RES">
    INSERT INTO SEVKIYAT_SEPET_PBS(SEVK_NO,DEPARTMENT_ID,LOCATION_ID,ORDER_ID,RECORD_DATE,RECORD_EMP ) VALUES ('#SEPET_NO#',#DEPARTMENT_ID#,#LOCATION_ID#,#ORDER_ID#,GETDATE(),#session.ep.userid#)
</cfquery>
<cfquery name="getOrderRow" datasource="#dsn3#">
    SELECT * FROM ORDER_ROW WHERE ORDER_ID=#ORDER_ID#
</cfquery>

<CFLOOP query="getOrderRow">
    <cfquery name="INSERT_SEPET_ROW" datasource="#DSN3#">
        INSERT INTO SEVKIYAT_SEPET_ROW_PBS (SEPET_ID,WRK_ROW_ID,PRODUCT_ID,AMOUNT,AMOUNT2)
        VALUES(#RES.GENERATEDKEY#,#WRK_ROW_ID#,#PRODUCT_ID#,#QUANTITY#,#AMOUNT2#)
    </cfquery>
</CFLOOP>

<cf_box title="Sevkiyat İşlemi">
<input type="hidden" name="SEPET_ID" id="SEPET_ID" value="<CFOUTPUT>#RES.GENERATEDKEY#</CFOUTPUT>">
<div class="form-group">
    <label>Barkod</label>
    <input type="text" class="form-control" name="BARKOD" id="BARKOD" placeholder="Barkod Okutunuz" onkeyup="islemYap(this,event)">
</div>
<table class="table table-sm table-stripped">
    <cfquery name="GETDATA" datasource="#DSN3#">
SELECT S.PRODUCT_NAME
	,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT AS AMOUNT_
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2 AS AMOUNT2_
	,SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT) AS AMOUNT
	,SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT2) AS AMOUNT2
FROM w3Toruntex_1.SEVKIYAT_SEPET_ROW_PBS
LEFT JOIN w3Toruntex_1.SEVKIYAT_SEPET_ROW_READ_PBS ON SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID = SEVKIYAT_SEPET_ROW_READ_PBS.SEPET_ROW_ID
LEFT JOIN w3Toruntex_1.STOCKS AS S ON S.PRODUCT_ID = SEVKIYAT_SEPET_ROW_PBS.PRODUCT_ID
WHERE SEVKIYAT_SEPET_ROW_PBS.SEPET_ID = #RES.GENERATEDKEY#
GROUP BY S.PRODUCT_NAME
	,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2
    </cfquery>
    <cfoutput query="GETDATA">
        <tr>
            <td data-sepet_row="#SEPET_ROW_ID#" data-WRK_ROW_ID='#WRK_ROW_ID#'>
                #AMOUNT# / #AMOUNT_#
            </td>
            <td>
                #AMOUNT2# / #AMOUNT2_#
            </td>
            <td>
                #PRODUCT_NAME#
            </td>
        </tr>
    </cfoutput>
</table>
</cf_box>