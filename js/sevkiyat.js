function islemYap(el, ev) {
  if (ev.keyCode == 13) {
    //console.log(el.value)
    var UrunBarkodu = el.value;
    UrunBarkodu = ReplaceAll(UrunBarkodu, "||", "|");
    var UrunKodu = list_getat(UrunBarkodu, 1, "|");
    var LotNo = list_getat(UrunBarkodu, 2, "|");
    var Agirlik = list_getat(UrunBarkodu, 3, "|");
    var OSX = { UrunKodu: UrunKodu, LotNo: LotNo, Agirlik: Agirlik };
    console.table(OSX);
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
  function SendFormData(uri, BasketData) {
    var mapForm = document.createElement("form");
    mapForm.target = "Map";
    mapForm.method = "POST"; // or "post" if appropriate
    mapForm.action = uri;
  
    var mapInput = document.createElement("input");
    mapInput.type = "hidden";
    mapInput.name = "data";
    mapInput.value = JSON.stringify(BasketData);
    mapForm.appendChild(mapInput);
  
    document.body.appendChild(mapForm);
  
    map = window.open(
      uri,
      "Map",
      "status=0,title=0,height=600,width=800,scrollbars=1"
    );
  
    if (map) {
      mapForm.submit();
    } else {
      alert("You must allow popups for this map to work.");
    }
  }
  