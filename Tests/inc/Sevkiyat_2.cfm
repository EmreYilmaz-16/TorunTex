<style>
    .form-control {
  display: block !important;
  width: 100%;
  height: calc(1.5em + .75rem + 2px);
  padding: .375rem .75rem !important;
  font-size: 1rem !important;
  font-weight: 400;
  line-height: 1.5 !important;
  color: #495057;
  
  background-clip: padding-box;
  border: 1px solid #ced4da !important;
  border-radius: .25rem !important;
  transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out !important;
}
</style>
<cfdump var="#attributes#">
<cfset DEPARTMENT_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),1,"-")>
<cfset LOCATION_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),2,"-")>
<cfset ORDER_ID=listGetAt(attributes.SELECT1,2,"*")>
<cfset SEPET_ID=listGetAt(attributes.SELECT1,3,"*")>
<CFIF SEPET_ID neq 0>
    
    <cflocation url="/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=24&SELECT1=#attributes.select1#">
    </script>
</CFIF>
<cfquery name="GETmX" datasource="#DSN3#">
    select ISNULL(max(SEPET_ID),0 )+1 SEPET_ID  from  SEVKIYAT_SEPET_PBS
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
MERHABA
<cfabort>
<cfquery name="CREATE_SEPET" datasource="#DSN3#" result="RES">
    INSERT INTO SEVKIYAT_SEPET_PBS(SEVK_NO,DEPARTMENT_ID,LOCATION_ID,ORDER_ID,RECORD_DATE,RECORD_EMP ) VALUES ('#SEPET_NO#',#DEPARTMENT_ID#,#LOCATION_ID#,#ORDER_ID#,GETDATE(),#session.ep.userid#)
</cfquery>
<cfquery name="getOrderRow" datasource="#dsn3#">
    SELECT * FROM ORDER_ROW WHERE ORDER_ID=#ORDER_ID#
</cfquery>

<CFLOOP query="getOrderRow">
    <cfquery name="INSERT_SEPET_ROW" datasource="#DSN3#">
        INSERT INTO SEVKIYAT_SEPET_ROW_PBS (SEPET_ID,WRK_ROW_ID,PRODUCT_ID,AMOUNT,AMOUNT2)
        VALUES(#RES.GENERATEDKEY#,'#WRK_ROW_ID#',#PRODUCT_ID#,#QUANTITY#,#AMOUNT2#)
    </cfquery>
</CFLOOP>
<cfset DEPARTMENT_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),1,"-")>
<cfset LOCATION_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),2,"-")>
<cfset ORDER_ID=listGetAt(attributes.SELECT1,2,"*")>
<cfset SEPET_ID=listGetAt(attributes.SELECT1,3,"*")>
<CFSET GIDEN_DEGISKEN="#DEPARTMENT_ID#-#LOCATION_ID#*#ORDER_ID#*#RES.GENERATEDKEY#">

<cflocation url="/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=24&SELECT1=#GIDEN_DEGISKEN#">

<cf_box title="Sevkiyat İşlemi">
    <div>
        <cfquery name="getSepet" datasource="#dsn3#">
            SELECT ISNULL(IS_CLOSED, 0) IS_CLOSED
                ,SEVK_NO
                ,SS.DEPARTMENT_ID
                ,SS.LOCATION_ID
                ,SS.ORDER_ID
                ,O.ORDER_NUMBER
                ,C.NICKNAME
                ,SC.COUNTRY_NAME
                ,SL.COMMENT
                ,D.DEPARTMENT_HEAD
                ,'PLAKA' AS PLAKA
                ,'KONTEYNER NO ' AS KONTEYNER
            FROM #dsn3#.SEVKIYAT_SEPET_PBS SS
            LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID = SS.ORDER_ID
            LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
            LEFT JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = C.COUNTRY
            LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = SS.LOCATION_ID
                AND SL.DEPARTMENT_ID = SS.DEPARTMENT_ID
            LEFT JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = SS.DEPARTMENT_ID
            WHERE SEPET_ID = #RES.GENERATEDKEY#
        </cfquery>
        <cf_box><cfoutput>
            <table class="table table-sm table-bordered">
                <tr>
                    <td>#getSepet.SEVK_NO#</td>
                    <td>#getSepet.NICKNAME#</td>
                    <td>#getSepet.COUNTRY_NAME#</td>
                    <td>#getSepet.PLAKA#</td>
                    <td>#getSepet.KONTEYNER#</td>
                    <td>#getSepet.DEPARTMENT_HEAD# - #getSepet.COMMENT#</td>
                </tr>
            </table>
        </cfoutput></cf_box>
    </div>
    <div>
        <button class="form-control btn btn-warning" data-status="1" onclick="SevkiyatKapa(this,<cfoutput>#RES.GENERATEDKEY#</cfoutput>)">Sevkiyat Açık</button>
    </div>
    
<input type="hidden" name="SEPET_ID" id="SEPET_ID" value="<CFOUTPUT>#RES.GENERATEDKEY#</CFOUTPUT>">

<input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="<CFOUTPUT>#DEPARTMENT_ID#</CFOUTPUT>">
<input type="hidden" name="LOCATION_ID" id="LOCATION_ID" value="<CFOUTPUT>#LOCATION_ID#</CFOUTPUT>">
<input type="hidden" name="ORDER_ID" id="ORDER_ID" value="<CFOUTPUT>#ORDER_ID#</CFOUTPUT>">
<div class="form-group">
    <label>Barkod</label>
    <div class="input-group">
        <input type="text" class="form-control" name="BARKOD" id="BARKOD" placeholder="Barkod Okutunuz" onkeyup="islemYap(this,event)">
            <span class="input-group-text" ><span id="AdS">0</span>&nbsp;Kg.</span> 
            <span class="input-group-text" ><span id="AdK">0</span>&nbsp;Ad.</span>
    </div>
    <label id="LastRead"></label>
</div>
<table class="table table-warning table-stripped" id="Sepetim">
    <cfquery name="GETDATA" datasource="#DSN3#">
SELECT S.PRODUCT_NAME
    ,S.PRODUCT_ID
	,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT AS AMOUNT_
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2 AS AMOUNT2_
	,SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT) AS AMOUNT
	,SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT2) AS AMOUNT2
FROM #dsn3#.SEVKIYAT_SEPET_ROW_PBS
LEFT JOIN #dsn3#.SEVKIYAT_SEPET_ROW_READ_PBS ON SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID = SEVKIYAT_SEPET_ROW_READ_PBS.SEPET_ROW_ID
LEFT JOIN #dsn3#.STOCKS AS S ON S.PRODUCT_ID = SEVKIYAT_SEPET_ROW_PBS.PRODUCT_ID
WHERE SEVKIYAT_SEPET_ROW_PBS.SEPET_ID = #RES.GENERATEDKEY#
GROUP BY S.PRODUCT_NAME
    ,S.PRODUCT_ID
	,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT
	,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2
    </cfquery>
    <cfquery name="getO" datasource="#dsn3#">
        SELECT PRODUCT_ID FROM ORDER_ROW WHERE ORDER_ID=#ORDER_ID#
    </cfquery>
    <cfset vls=valueList(getO.PRODUCT_ID)>
    <cfoutput query="GETDATA">
        <tr <cfif not listFind(vls,PRODUCT_ID)>data-fromSiparis="0"<cfelse>data-fromSiparis="1"</cfif> id="ROW_#PRODUCT_ID#" <cfif not listFind(vls,PRODUCT_ID)>class="bg-danger"<cfelse><cfif AMOUNT2 eq AMOUNT2_>class="bg-success"<cfelseif AMOUNT2 gt AMOUNT2_>class="bg-primary"  </cfif> </cfif>  data-PRODUCT_ID='#PRODUCT_ID#' data-SEPET_ROW_ID="#SEPET_ROW_ID#">
            <td  id="AMOUNT_#PRODUCT_ID#">
                #AMOUNT# / #AMOUNT_#
            </td>
            <td id="AMOUNT2_#PRODUCT_ID#">
                #AMOUNT2# / #AMOUNT2_#
            </td>
            <td id="PRODUCT_NAME_#PRODUCT_ID#">
                #PRODUCT_NAME#
            </td>
        </tr>
    </cfoutput>
</table>

</cf_box>
<script>
    <cfoutput>
        var ToplamAdet='#ToplamAdet#';
        var ToplamKg='#ToplamKg#';
        var SevkStatus=#getSepet.IS_CLOSED#;
        var dsn="#dsn#"
        var dsn1="#dsn1#"
        var dsn2="#dsn2#"
        var dsn3="#dsn3#"
    </cfoutput>
</script>
<script src="/AddOns/Partner/js/sevkiyat.min.js"></script>