function setDept(el) {
  el.setAttribute("readonly", "true");
  $("#TXT_DEPARTMENT_IN").val(el.value);
  $("#LotNo").focus();
}
function getProduct(el, ev, pc) {
  var UrunBarkodu = el.value;
  UrunBarkodu = ReplaceAll(UrunBarkodu, "||", "|");
  var UrunKodu = list_getat(UrunBarkodu, 1, "|");
  var LotNo = list_getat(UrunBarkodu, 2, "|");
  var Agirlik = list_getat(UrunBarkodu, 3, "|");
  var Res = wrk_query(
    "SELECT * FROM STOCKS WHERE " + pc + "='" + UrunKodu + "'",
    "dsn3"
  );
  if (Res.recordcount) {
    satirEkle(
      Res.PRODUCT_ID[0],
      Res.STOCK_ID[0],
      Res.PRODUCT_CODE[0],
      Res.PRODUCT_CODE_2[0],
      LOT_NO,
      Agirlik
    );
  } else {
    alert("Ürün Bulunamadı");
  }
}

function satirEkle(
  PRODUCT_ID,
  STOCK_ID,
  PRODUCT_CODE,
  PRODUCT_CODE_2,
  LOT_NO,
  MIKTARIM
) {
  var str = document.getElementById("DEPOLAMA").value;
  var STORE_ID = list_getat(str, 1, "-");
  var LOCATION_ID = list_getat(str, 2, "-");
  var tr = document.createElement("tr");
  var td = document.createElement("td");
  td.innerText = LOT_NO;
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_ID_" + RC);
  input.setAttribute("value", PRODUCT_ID);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "STOCK_ID_" + RC);
  input.setAttribute("value", STOCK_ID);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_CODE" + RC);
  input.setAttribute("value", PRODUCT_CODE);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_CODE_2" + RC);
  input.setAttribute("value", PRODUCT_CODE_2);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "LOT_NO" + RC);
  input.setAttribute("value", LOT_NO);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "AMOUNT" + RC);
  input.setAttribute("value", MIKTARIM);
  td.appendChild(input);
  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText = PRODUCT_CODE_2;
  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText = MIKTARIM;
  tr.appendChild(td);
  document.getElementById("SayimTable").appendChild(tr);
  debugger;
  if (SayimSettings.is_product_code == 1) {
    $("#PRODUCT_CODE").val("");
    $("#LOT_NO").val("");
    $("#PRODUCT_CODE").focus();
  } else {
    $("#LOT_NO").val("");
    $("#LOT_NO").focus();
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
