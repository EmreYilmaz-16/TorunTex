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
    SELECT S.PRODUCT_NAME
        ,S.PRODUCT_ID
        ,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
        ,ISNULL(SEVKIYAT_SEPET_ROW_PBS.AMOUNT,0) AS AMOUNT_
        ,ISNULL(SEVKIYAT_SEPET_ROW_PBS.AMOUNT2,0) AS AMOUNT2_
        ,ISNULL(SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT),0) AS AMOUNT
        ,ISNULL(SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT2),0) AS AMOUNT2
    FROM #dsn3#.SEVKIYAT_SEPET_ROW_PBS
    LEFT JOIN #dsn3#.SEVKIYAT_SEPET_ROW_READ_PBS ON SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID = SEVKIYAT_SEPET_ROW_READ_PBS.SEPET_ROW_ID
    LEFT JOIN #dsn3#.STOCKS AS S ON S.PRODUCT_ID = SEVKIYAT_SEPET_ROW_PBS.PRODUCT_ID
    WHERE SEVKIYAT_SEPET_ROW_PBS.SEPET_ID = #SEPET_ID#
    GROUP BY S.PRODUCT_NAME
        ,S.PRODUCT_ID
        ,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2
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
                ,O.ORDER_HEAD
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
            WHERE SEPET_ID = #SEPET_ID#
        </cfquery>
        <cf_box><cfoutput>
            <table class="table table-sm table-bordered">
                <tr>
                    <td>#getSepet.DEPARTMENT_HEAD# - #getSepet.COMMENT#</td>                    
                    <td>#getSepet.NICKNAME#</td>
                    <td>#getSepet.COUNTRY_NAME#</td>
                    <td>#getSepet.PLAKA#</td>
                    <td>#getSepet.KONTEYNER#</td>
                    <td>#getSepet.SEVK_NO#</td>
                </tr>
                <tr>
                    <td>
                        <b>Sipariş No :</b>#getSepet.ORDER_NUMBER#
                    </td>
                    <td>
                        <b>Sipariş  :</b>#getSepet.ORDER_HEAD#
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <button type="button" class="btn form-control btn-danger" onclick="IptalEt()">İptal</button>
                    </td>
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
            <input type="text" class="form-control" name="BARKOD" id="BARKOD" placeholder="Barkod Okutunuz" onkeyup="islemYap(this,event)">
            <span class="input-group-text" ><span id="AdS">0</span>&nbsp;Kg.</span> 
            <span class="input-group-text" ><span id="AdK">0</span>&nbsp;Ad.</span>
        </div>
        <label id="LastRead"></label>
    </div>
    <table class="table table-warning table-stripped" id="Sepetim">

         <cfquery name="getO" datasource="#dsn3#">
            SELECT PRODUCT_ID FROM ORDER_ROW WHERE ORDER_ID=#ORDER_ID#
        </cfquery>
        <cfset vls=valueList(getO.PRODUCT_ID)>
        <cfset ToplamAdet=0>
        <cfset ToplamKg=0>
        <cfoutput query="GETDATA">
            <tr <cfif not listFind(vls,PRODUCT_ID)>data-fromSiparis="0"<cfelse>data-fromSiparis="1"</cfif> id="ROW_#PRODUCT_ID#" <cfif not listFind(vls,PRODUCT_ID)>class="bg-danger"<cfelse><cfif AMOUNT2 eq AMOUNT2_>class="bg-success"<cfelseif AMOUNT2 gt AMOUNT2_>class="bg-primary"  </cfif> </cfif>  data-PRODUCT_ID='#PRODUCT_ID#' data-SEPET_ROW_ID="#SEPET_ROW_ID#"> 
                <td id="AMOUNT_#PRODUCT_ID#">
                    
                    <cfif len(AMOUNT)>#AMOUNT#<CFELSE>0</cfif>/ #AMOUNT_#
                </td>
                <td id="AMOUNT2_#PRODUCT_ID#">
                    <cfif len(AMOUNT2)>#AMOUNT2#<CFELSE>0</cfif> / #AMOUNT2_#
                </td>
                <td id="PRODUCT_NAME_#PRODUCT_ID#">
                    #PRODUCT_NAME#
                </td>
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
            var dsn="#dsn#"
            var dsn1="#dsn1#"
            var dsn2="#dsn2#"
            var dsn3="#dsn3#"
            var UserId=#session.ep.userid#
        </cfoutput>
    </script>
    <script src="/AddOns/Partner/js/sevkiyat.js"></script>
