<cf_box title="İthal Mal Girişi">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>Fatura No</label>
                  
                    <cfset GETF=getFatura()>
                    <SELECT class="form-control form-select" name="FaturaNo" id="FaturaNo" onchange="getFatura(this,event)">
                        <option value="">Seçiniz</option>
                        <cfoutput query="GETF">
                            <option value="#INVOICE_ID#">#INVOICE_NUMBER#</option>
                        </cfoutput>
                    </SELECT>
                    <!---<input type="text" name="FaturaNo" id="FaturaNo" onkeyup="getFatura(this,event)">---->
                </div>
            </td>
            <td>
                <CFSET GETL=getLocation()>
                <div class="form-group">
                    <label>Hol</label>
                    <SELECT class="form-control form-select" name="DEPARTMENT_LOCATION" id="DEPARTMENT_LOCATION" onchange="getShelves(this,event)">
                        <option value="">Seçiniz</option>
                        <cfoutput query="GETL">
                            <option value="#DEPARTMENT_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </SELECT>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <label>Raf</label>
                    <SELECT class="form-control form-select" name="PRODUCT_PLACE_ID" id="PRODUCT_PLACE_ID" onchange="">
                        <option value="">Seçiniz</option>
                    </SELECT>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="fatura_satirlari">
                    
                </div>
            </td>
        </tr>
    </table>
   
    
</cf_box>

<script>
    function getFatura(el) {
        AjaxPageLoad(
    "index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=37&INVOICE_ID=" +
      el.value,
    "fatura_satirlari",
    1,
    "Yükleniyor"
  );
    }
    function SatirEkle(INVOICE_ID,STOCK_ID,WRK_ROW_ID,MIKTAR,MIKTAR2) {
        console.table(arguments);

    }
    function getShelves(el) {
        var STORE=list_getat(el.value,1,"-")
    var STLOCATION=list_getat(el.value,2,"-")
    var Res=wrk_query("SELECT TOP 10 PRODUCT_PLACE_ID,SHELF_CODE FROM PRODUCT_PLACE WHERE STORE_ID="+STORE+" AND LOCATION_ID="+STLOCATION,"DSN3")
    $("#PRODUCT_PLACE_ID").html('<option value="">Seçiniz</option>')
    for (let index = 0; index < Res.recordcount; index++) {
        var opt=document.createElement("option");
        opt.value=Res.PRODUCT_PLACE_ID[i];
        opt.innerText=Res.SHELF_CODE[i];
        document.getElementById("PRODUCT_PLACE_ID").appendChild(opt);
    }
    }
    function wrk_query(str_query, data_source, maxrows) {
  var new_query = new Object();
  var req;
  if (!data_source) data_source = "dsn";
  if (!maxrows) maxrows = 0;
  function callpage(url) {
    req = false;
    if (window.XMLHttpRequest)
      try {
        req = new XMLHttpRequest();
      } catch (e) {
        req = false;
      }
    else if (window.ActiveXObject)
      try {
        req = new ActiveXObject("Msxml2.XMLHTTP");
      } catch (e) {
        try {
          req = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {
          req = false;
        }
      }
    if (req) {
      function return_function_() {
        if (req.readyState == 4 && req.status == 200)
          try {
            eval(req.responseText.replace(/\u200B/g, ""));
            new_query = get_js_query; //alert('Cevap:\n\n'+req.responseText);//
          } catch (e) {
            new_query = false;
          }
      }
      req.open("post", url + "&xmlhttp=1", false);
      req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      req.setRequestHeader("pragma", "nocache");
      if (encodeURI(str_query).indexOf("+") == -1)
        // + isareti encodeURI fonksiyonundan gecmedigi icin encodeURIComponent fonksiyonunu kullaniyoruz. EY 20120125
        req.send(
          "str_sql=" +
            encodeURI(str_query) +
            "&data_source=" +
            data_source +
            "&maxrows=" +
            maxrows
        );
      else
        req.send(
          "str_sql=" +
            encodeURIComponent(str_query) +
            "&data_source=" +
            data_source +
            "&maxrows=" +
            maxrows
        );
      return_function_();
    }
  }

  //TolgaS 20070124 objects yetkisi olmayan partnerlar var diye fuseaction objects2 yapildi
  callpage("/index.cfm?fuseaction=objects2.emptypopup_get_js_query&isAjax=1");
  //alert(new_query);

  return new_query;
}

</script>



<cffunction name="getFatura">
    <cfquery name="GETF" datasource="#DSN2#">
        SELECT DISTINCT INVOICE_ID
            ,INVOICE_NUMBER
            ,PROCESS_STAGE
            
        FROM (
            SELECT INVOICE_NUMBER
                ,I.INVOICE_ID
                ,IR.AMOUNT
                ,IR.AMOUNT2
                ,I.PROCESS_STAGE
                ,(
                    SELECT SUM(AMOUNT)
                    FROM #dsn2#.SHIP_ROW AS SR
                    INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
                    WHERE 1 = 1
                        AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
                        AND S.SHIP_TYPE = 811
                    ) AS AC
                    ,(
                    SELECT SUM(AMOUNT2)
                    FROM #dsn2#.SHIP_ROW AS SR
                    INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
                    WHERE 1 = 1
                        AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
                        AND S.SHIP_TYPE = 811
                    ) AS AC2
            FROM #dsn2#.INVOICE AS I
            INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
            WHERE INVOICE_CAT = 591
            --    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
            ) AS IRRS
        WHERE ISNULL(AC, 0) < AMOUNT

</cfquery>
<cfreturn GETF>
</cffunction>
<cffunction name="getLocation">
    <cfquery name="getl" datasource="#dsn#">
        SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=13
    </cfquery>
    <cfreturn getl>
</cffunction>