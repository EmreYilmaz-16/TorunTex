<cf_box title="Stok Bul">
    <div class="form-group">
<input type="text" style="font-size:25pt" name="PRODUCT_CODE_2" placeholder="Ürün Özel Kodu" id="PRODUCT_CODE_2" onkeyup="searchSKU(this.value,event)">
</div>
<hr>
<div style="display:flex">
    <div id="StokDetay" style="width:33%">

    </div>
    <div style="width:33%;display: flex;flex-direction: column;" >
        <div id="Lokasyon">
            
        </div>
        <div id="GraphArea">
            
        </div>
    </div>
    <div id="LotDetay" style="width:33%">

    </div>
</div>

</cf_box>

<script>
    function searchSKU(v,e) {
        console.log(v);
        console.log(e.keyCode)
        if(e.keyCode==13){
            var Sresult=wrk_query("SELECT * FROM STOCKS WHERE PRODUCT_CODE_2='"+v+"'","dsn3")
           console.log(Sresult)
            if(Sresult.recordcount>0){
                AjaxPageLoad(
    "index.cfm?fuseaction=stock.detail_stock_popup&pid="+Sresult.PRODUCT_ID[0]+"&stock_id="+Sresult.STOCK_ID[0],
    "StokDetay",
    1,
    "Yükleniyor"
  );
  AjaxPageLoad(
    "index.cfm?fuseaction=stock.detail_store_stock_popup&product_id="+Sresult.PRODUCT_ID[0]+"&stock_id="+Sresult.STOCK_ID[0],
    "Lokasyon",
    1,
    "Yükleniyor"
  );
  AjaxPageLoad(
    "index.cfm?fuseaction=stock.popup_stock_graph_ajax&pid="+Sresult.PRODUCT_ID[0]+"&stock_code="+Sresult.STOCK_CODE[0],
    "GraphArea",
    1,
    "Yükleniyor"
  );
  AjaxPageLoad(
    "index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=45&stock_id="+Sresult.STOCK_ID[0]+"&stock_code="+Sresult.STOCK_CODE[0],
    "LotDetay",
    1,
    "Yükleniyor"
  );
            }
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

