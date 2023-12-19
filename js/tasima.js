var LOCATION_OUT = "";
var DEPARTMENT_OUT = "";
var OUT_TXT = "";
var WRK_ROW_ID_OUT = "";

var LOCATION_IN = "";
var DEPARTMENT_IN = "";
var IN_TXT = "";
var WRK_ROW_ID_IN = "";

var LOT_NUMARA = "";
var STOCK_ID = "";
$(document).ready(function () {
  $("#DEPARTMENT_OUT_SEL").html(
    "<option value=''>Giriş Deposu Seçiniz</option>"
  );
});

function getBarkode_1(el, ev) {
  if (ev.keyCode == 13) {
    var UrunBarkodu = el.value;
    UrunBarkodu = ReplaceAll(UrunBarkodu, "||", "|");
    var UrunKodu = list_getat(UrunBarkodu, 1, "|");
    var LotNo = list_getat(UrunBarkodu, 2, "|");
    var Agirlik = list_getat(UrunBarkodu, 3, "|");
    //BILGI STOK ROWDAN SONRA LOKASYONU ALINIYOR
    var Qstr1 =
      "SELECT TOP 1 STORE DELIVER_DEPT_ID,STORE_LOCATION LOCATION_ID,STOCK_ID,PBS_RELATION_ID AS WRK_ROW_ID FROM " +
      dsn2 +
      ".STOCKS_ROW WHERE  LOT_NO='" +
      LotNo +
      "' ORDER BY PROCESS_DATE DESC,UPD_ID DESC";
    var QueryResult_1 = wrk_query(Qstr1);
    if (QueryResult_1.recordcount > 0) {
      LOCATION_OUT = QueryResult_1.LOCATION_ID[0];
      DEPARTMENT_OUT = QueryResult_1.DELIVER_DEPT_ID[0];
      WRK_ROW_ID_OUT = QueryResult_1.WRK_ROW_ID[0];
      getOutLocations();
    } else {
      alert("Ürün Bulunamadı");
    }
  }
}

function getOutLocations() {

  $("#DEPARTMENT_OUT_SEL").html(
    "<option value=''>Giriş Deposu Seçiniz</option>"
  );
  $("#DEPARTMENT_OUT_SEL").focus();
  
  var Qstr1 =
    "SELECT D.DEPARTMENT_HEAD,SL.COMMENT,D.DEPARTMENT_ID,SL.LOCATION_ID FROM STOCKS_LOCATION AS SL ";
  Qstr1 +=
    " INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID     WHERE D.DEPARTMENT_ID=14 ";
  var QueryResult_1 = wrk_query(Qstr1, "DSN");
  for (let index = 0; index < QueryResult_1.LOCATION_ID.length; index++) {
    var DEPARTMENT_HEAD = QueryResult_1.DEPARTMENT_HEAD[0];
    var COMMENT = QueryResult_1.COMMENT[0];
    var DEPARTMENT_ID_ = QueryResult_1.DEPARTMENT_ID[0];
    var LOCATION_ID_ = QueryResult_1.LOCATION_ID[0];
    var option = document.createElement("option");
    option.setAttribute("value", DEPARTMENT_ID_ + "-" + LOCATION_ID_);
    option.innerText = DEPARTMENT_HEAD + "-" + COMMENT;
    document.getElementById("DEPARTMENT_OUT_SEL").appendChild(option);
  }
  $("#DEPARTMENT_OUT_SEL").click();
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
