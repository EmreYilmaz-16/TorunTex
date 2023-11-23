<table>
<tr>
    <td>
        <input type="text" name="Barcode" onkeyup="SearchBarcode(this,event)">
        <input type="hidden" name="FROM_WRK_ROW_ID" id="FROM_WRK_ROW_ID">
        <input type="hidden" name="TO_WRK_ROW_ID" id="TO_WRK_ROW_ID">
    </td>
    <td>
        <div class="form-group">
            <label>Çıkış Depo</label>
            <input type="text" readonly name="txtFromDeptLocation" id="txtFromDeptLocation">
            <input type="hidden"  name="txtFromDeptId" id="txtFromDeptId">
            <input type="hidden"  name="txtFromLocId" id="txtFromLocId">
        </div>
    </td>
    <td style="display:none">
        <div class="form-group">
            <label>Giriş Depo</label>
            <input type="text" name="txtToDeptLocation" id="txtToDeptLocation" onkeyup="searchDepo()">
            <input type="text"  name="txtToDeptId" id="txtToDeptId">
            <input type="text"  name="txtToLocId" id="txtToLocId">
        </div>
    </td>
</tr>
</table>

<script>
<cfoutput>
    var dsn="#dsn#";
    var dsn1="#dsn1#";
    var dsn2="#dsn2#";
    var dsn3="#dsn3#";
</cfoutput>
    function SearchBarcode(el,ev){
        if(ev.keyCode==13){
            var UrunBarkodu=el.value;
            UrunBarkodu=ReplaceAll(UrunBarkodu,"||","|")
            var UrunKodu=list_getat(UrunBarkodu,1,"|");
            var LotNo=list_getat(UrunBarkodu,2,"|");
            var Agirlik=list_getat(UrunBarkodu,3,"|");
            var Qstr1="SELECT ORDERS.DELIVER_DEPT_ID,ORDERS.LOCATION_ID,ORDER_ROW.WRK_ROW_ID FROM "+dsn3+".ORDER_ROW"
            Qstr1+=" INNER JOIN "+dsn3+".ORDERS ON ORDERS.ORDER_ID=ORDER_ROW.ORDER_ID"
            Qstr1+=" WHERE WRK_ROW_ID=( SELECT  DISTINCT PBS_RELATION_ID FROM "+dsn2+".STOCKS_ROW where LOT_NO='"+LotNo+"')"
            var QueryResult_1=wrk_query(Qstr1);
            console.log(QueryResult_1);
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

<!----

    Barkod Okut Çıkış Deposunu WrkQueryile getir 
    Giriş Depo Barkodu Okut wrlk query ile Giriş Depo bilgilerini getir

---->