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
<cfset DEPARTMENT_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),1,"-")>
<cfset LOCATION_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),2,"-")>
<cfset ORDER_ID=listGetAt(attributes.SELECT1,2,"*")>
<cfset SEPET_ID=listGetAt(attributes.SELECT1,3,"*")>
<cfquery name="GETDATA" datasource="#DSN3#">
SELECT LOT_NO
	,SEPET_ROW_ID
	,SEPET_ID
	,SSC.PRODUCT_ID
	,SSC.RECORD_EMP
	,SSC.RECORD_DATE
	,S.PRODUCT_NAME
	,S.PRODUCT_CODE_2
	,AMOUNT
	,1 AS AMOUNT2
	,E.EMPLOYEE_NAME
	,E.EMPLOYEE_SURNAME
FROM w3Toruntex_1.SEVKIYAT_SEPET_CIKAN SSC
LEFT JOIN w3Toruntex_1.STOCKS AS S ON S.PRODUCT_ID = SSC.PRODUCT_ID
LEFT JOIN w3Toruntex.EMPLOYEES AS E ON E.EMPLOYEE_ID = SSC.RECORD_EMP
 WHERE SEPET_ID=#SEPET_ID#
        </cfquery>
        
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
            FROM w3Toruntex_1.SEVKIYAT_SEPET_PBS SS
            LEFT JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID = SS.ORDER_ID
            LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
            LEFT JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = C.COUNTRY
            LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = SS.LOCATION_ID
                AND SL.DEPARTMENT_ID = SS.DEPARTMENT_ID
            LEFT JOIN w3Toruntex.DEPARTMENT AS D ON D.DEPARTMENT_ID = SS.DEPARTMENT_ID
            WHERE SEPET_ID = #SEPET_ID#
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
        <button class="form-control btn <cfif getSepet.IS_CLOSED eq 1>btn-danger<cfelse> btn-warning</cfif>" data-status="<CFOUTPUT>#getSepet.IS_CLOSED#</CFOUTPUT>" onclick="SevkiyatKapa(this,<cfoutput>#SEPET_ID#</cfoutput>)"><cfif getSepet.IS_CLOSED eq 1>Sevkiyat Kilitli<cfelse>Sevkiyat Açık</cfif></button>
    </div>
    <input type="hidden" name="SEPET_ID" id="SEPET_ID" value="<CFOUTPUT>#SEPET_ID#</CFOUTPUT>">
    <input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="<CFOUTPUT>#DEPARTMENT_ID#</CFOUTPUT>">
    <input type="hidden" name="LOCATION_ID" id="LOCATION_ID" value="<CFOUTPUT>#LOCATION_ID#</CFOUTPUT>">
    <input type="hidden" name="ORDER_ID" id="ORDER_ID" value="<CFOUTPUT>#ORDER_ID#</CFOUTPUT>">
    <div class="form-group">
        <label>Barkod</label>
        <div class="input-group">
            <input type="text" class="form-control" name="BARKOD" id="BARKOD" placeholder="Barkod Okutunuz" onkeyup="EksiislemYap(this,event)">
            <span class="input-group-text" ><span id="AdS">0</span>&nbsp;Kg.</span> 
            <span class="input-group-text" ><span id="AdK">0</span>&nbsp;Ad.</span>
        </div>
        <label id="LastRead"></label>
    </div>
    <table class="table table-warning table-stripped" id="Sepetim">

         <cfquery name="getO" datasource="#dsn3#">
            SELECT PRODUCT_ID FROM ORDER_ROW WHERE ORDER_ID=#ORDER_ID#
        </cfquery>
       
        <cfset ToplamAdet=0>
        <cfset ToplamKg=0>
        <cfoutput query="GETDATA">
            <tr> 
                <td id="LOT_NO_#PRODUCT_ID#">#LOT_NO#</td>
                <td id="PRODUCT_CODE_#PRODUCT_ID#">#PRODUCT_CODE_2#</td>
                <td id="PRODUCT_NAME_#PRODUCT_ID#">#PRODUCT_NAME#</td>                
                <td id="AMOUNT_#PRODUCT_ID#">#AMOUNT#</td>
                <td id="AMOUNT2_#PRODUCT_ID#">#AMOUNT2#</td>
                <td id="CIKARAN_#PRODUCT_ID#">#EMPLOYEE_NAME# #EMPLOYEE_SURNAME#</td>                
                <td id="TARIH_#PRODUCT_ID#"><input type="date" readonly value="#RECORD_DATE#"></td>  
                <td></td>                
            </tr>
            <cfset ToplamAdet+=AMOUNT2>
            <cfset ToplamKg+=AMOUNT>
        </cfoutput>
    </table>
    </cf_box>
    <audio id="myAudio">
        <source src="/AddOns/Partner/content/beep.mp3" type="audio/mpeg">
        <source src="/AddOns/Partner/content/beep.ogg" type="audio/ogg">
    </audio>
    <script>
        <cfoutput>
            var ToplamAdet='#ToplamAdet#';
            var ToplamKg='#ToplamKg#';
            var SevkStatus=#getSepet.IS_CLOSED#;
            var UserId=#session.ep.UserId#;
        </cfoutput>
    </script>
    <script src="/AddOns/Partner/js/sevkiyat.js"></script>
