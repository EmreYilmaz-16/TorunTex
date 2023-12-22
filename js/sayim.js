var PRODUCT_ID = "";
var STOCK_ID = "";
var PRODUCT_CODE = "";
var PRODUCT_CODE_2 = "";
var SHELF_CODE = "";
var DEPARTMENT_ID = "";
var LOCATION_ID = "";
var LOT_NO = "";
var RC = 1;
var MIKTARIM="";
function getProduct(el, ev, productCodeArea) {
  if (ev.keyCode == 13) {
    var GetProductQuery =
      "SELECT PRODUCT_ID,STOCK_ID,PRODUCT_CODE,PRODUCT_CODE_2 FROM STOCKS WHERE " +
      productCodeArea +
      "= '" +
      el.value +
      "'";
    var GetProductResult = wrk_query(GetProductQuery, "dsn3");
    if (GetProductResult.recordcount > 0) {
      PRODUCT_ID = GetProductResult.PRODUCT_ID[0];
      STOCK_ID = GetProductResult.STOCK_ID[0];
      PRODUCT_CODE = GetProductResult.PRODUCT_CODE[0];
      PRODUCT_CODE_2 = GetProductResult.PRODUCT_CODE_2[0];
      if (SayimSettings.is_lot_no == 1) {
        $("#LOT_NO").focus();
      } else {
        satirEkle();
      }
    } else {
      alert("Ürün Bulunamadı");
      return false;
    }
  }
}

function GetShelf(el, ev) {
  if (ev.keyCode == 13) {
    var str = document.getElementById("DEPOLAMA").value;
    var STORE_ID = list_getat(str, 1, "-");
    var LOCATION_ID = list_getat(str, 2, "-");
    var SHELF_CODE_ = list_getat(el.value, 3, "-");

    var GetShelfQuery =
      "SELECT * FROM PRODUCT_PLACE WHERE STORE_ID=" +
      STORE_ID +
      " AND LOCATION_ID=" +
      LOCATION_ID +
      " AND SHELF_CODE='" +
      SHELF_CODE_ +
      "'";
    GetShelfResult = wrk_query(GetShelfQuery, "dsn3");
    if (GetShelfResult.recordcount > 0) {
      SHELF_CODE = GetShelfResult.SHELF_CODE[0];
      DEPARTMENT_ID = GetShelfResult.STORE_ID[0];
      LOCATION_ID = GetShelfResult.LOCATION_ID[0];
      if (SayimSettings.is_product_code == 1) {
        $("#PRODUCT_CODE").focus();
        return true;
      }
      if (SayimSettings.is_lot_no == 1) {
        $("#LOT_NO").focus();
        return true;
      }
    } else {
      alert("Raf Bulunamadı");
      return false;
    }
  }
}

function getLotNo(el, ev, productCodeArea) {
  var LotNumarasi = el.value;
  if (ev.keyCode == 13) {
    if (SayimSettings.is_product_code == 0) {
      var GetLotNoQuery =
        "SELECT TOP 1 S.PRODUCT_NAME,S.PRODUCT_ID,S.STOCK_ID,SR.LOT_NO,S.PRODUCT_CODE_2,S.PRODUCT_CODE,ISNULL(STOCK_IN,STOCK_OUT) AS AMOUNTMIK FROM STOCKS_ROW AS SR LEFT JOIN "+DSN3+".STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID WHERE LOT_NO='" +
        LotNumarasi +
        "'";
      var GetLotNoResult = wrk_query(GetLotNoQuery, "dsn2");
      console.log(GetLotNoResult);
      if (getLotNo.recordcount) {
        PRODUCT_ID = GetLotNoResult.PRODUCT_ID[0];
        STOCK_ID = GetLotNoResult.STOCK_ID[0];
        PRODUCT_CODE = GetLotNoResult.PRODUCT_CODE[0];
        LOT_NO = GetLotNoResult.LOT_NO[0];
        PRODUCT_CODE_2 = GetLotNoResult.PRODUCT_CODE_2[0];
        MIKTARIM=GetLotNoResult.AMOUNTMIK[0];
        satirEkle();
      } else {
        alert("Lot Numaralı Ürün Bulunamadı");
      }
    } else {
      LOT_NO = LotNumarasi;
      satirEkle();
    }
  }
}

function satirEkle(params) {
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
  if (SayimSettings.is_rafli == 1) {
    var td = document.createElement("td");
    td.innerText = SHELF_CODE;
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "SHELF_CODE" + RC);
    input.setAttribute("value", SHELF_CODE);
    td.appendChild(input);
    
    tr.appendChild(td);
  }

  var td = document.createElement("td");
  td.innerText = 1;
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
  PRODUCT_ID = "";
  STOCK_ID = "";
  PRODUCT_CODE = "";
  PRODUCT_CODE_2 = "";
  DEPARTMENT_ID = "";
  LOCATION_ID = "";
  LOT_NO = "";
  $("#RC").val(RC);
  RC++;
}

function setDept(el) {
  el.setAttribute("readonly", "true");
  $("#TXT_DEPARTMENT_IN").val(el.value);
  $("#LotNo").focus();
}

function MerhabaDE(){
  alert("Merhaba Canım")
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