var RowCount = 1;
var _SHELF_CODE = "";
var _SHELF_ID = "";
function getFatura(el) {
  AjaxPageLoad(
    "index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=37&INVOICE_ID=" +
      el.value,
    "fatura_satirlari",
    1,
    "Yükleniyor"
  );
  el.setAttribute("disabled", "yes");
}
function getFatura2(el) {
  AjaxPageLoad(
    "index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=37&INVOICE_ID=" +
      el,
    "fatura_satirlari",
    1,
    "Yükleniyor"
  );
  el.setAttribute("disabled", "yes");
}
function SatirEkle(
  INVOICE_ID,
  STOCK_ID,
  PRODUCT_ID,
  WRK_ROW_ID,
  MIKTAR,
  MIKTAR2,
  KALAN2,
  PRODUCT_NAME,
  PRODUCT_CODE,
  LOT_NO,
  IV_DATE
) {
  console.table(arguments);

  document.getElementById("INVOICE_ID").value = INVOICE_ID;
  document.getElementById("IV_DATE").value = IV_DATE;
  var SHELF_CODE = document.getElementById(SHELF_CODE);
  var DIS_MIKTAR = prompt("Giriş Yapılacak Çuval Miktarı");
  var BIRIM_KG = MIKTAR / MIKTAR2;
  var T_KG = 0;
  if (DIS_MIKTAR != null) {
    if (isNaN(DIS_MIKTAR) == false) {
      T_KG = BIRIM_KG * parseInt(DIS_MIKTAR);
      if (parseInt(DIS_MIKTAR) > KALAN2) {
        alert("Miktar Fatura Miktarından Büyük Olamaz");
      } else {
        var KNT = Kontrol(WRK_ROW_ID, MIKTAR2, parseInt(DIS_MIKTAR));
        if (KNT == false) {
          return false;
        }
        Ekle(
          PRODUCT_ID,
          STOCK_ID,
          WRK_ROW_ID,
          PRODUCT_NAME,
          PRODUCT_CODE,
          LOT_NO,
          T_KG,
          DIS_MIKTAR
        );
      }
    } else {
      alert("Miktar Numerik Olmalı");
    }
  }
}
function setShelf(el) {
  var ix = el.selectedIndex;
  var tx = el.options[ix].innerText;
  var tv = el.options[ix].value;
  _SHELF_CODE = tx;
  _SHELF_ID = tv;
  el.setAttribute("disabled", "yes");
}
function Kontrol(WRK_ROW_ID, MIKTAR2, EKLENEN) {
  var sepetSatir = document.getElementById("SEPETIM").children;
  var ToplamEklenen = EKLENEN;
  for (let i = 0; i < sepetSatir.length; i++) {
    var Satir = sepetSatir[i];
    var SatirWrk = Satir.getAttribute("data-wrk_row_id");
    var SatirRowId = Satir.getAttribute("data-rowcount");
    if (SatirWrk == WRK_ROW_ID) {
      console.log(SatirWrk);
      var SatirMiktar = document.getElementsByName("AMOUNT2_" + SatirRowId)[0]
        .value;
      console.log(SatirMiktar);
      ToplamEklenen += parseInt(SatirMiktar);
    }
  }
  console.log(ToplamEklenen);
  if (ToplamEklenen <= MIKTAR2) {
  } else {
    alert("Toplam Miktar Fatura Miktarından Fazladır");
    return false;
  }
}
function Ekle(
  PRODUCT_ID,
  STOCK_ID,
  WRK_ROW_ID,
  PRODUCT_NAME,
  PRODUCT_CODE,
  LOT_NO,
  MIKTAR,
  MIKTAR2
) {
  var tr = document.createElement("tr");
  tr.setAttribute("data-wrk_row_id", WRK_ROW_ID);
  tr.setAttribute("data-RowCount", RowCount);
  var td = document.createElement("td");
  td.innerText = RowCount;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = LOT_NO;

  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "LOT_NO_" + RowCount);
  input.setAttribute("value", LOT_NO);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_ID_" + RowCount);
  input.setAttribute("value", PRODUCT_ID);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "STOCK_ID_" + RowCount);
  input.setAttribute("value", STOCK_ID);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "WRK_ROW_ID_" + RowCount);
  input.setAttribute("value", WRK_ROW_ID);
  td.appendChild(input);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.setAttribute("readonly", "yes");
  input.setAttribute("name", "AMOUNT_" + RowCount);
  input.setAttribute("value", filterNum(commaSplit(parseFloat(MIKTAR))));
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);
  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.setAttribute("readonly", "yes");
  input.setAttribute("name", "AMOUNT2_" + RowCount);
  input.setAttribute("value", MIKTAR2);
  div.appendChild(input);
  td.appendChild(div);

  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText = _SHELF_CODE;
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "SHELF_ID_" + RowCount);
  input.setAttribute("value", _SHELF_ID);
  td.appendChild(input);
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PRODUCT_CODE;
  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText = PRODUCT_NAME;

  tr.appendChild(td);
  document.getElementById("SEPETIM").appendChild(tr);
  document.getElementById("row_count").value = RowCount;
  RowCount++;
}
function getShelves(el) {
  var STORE = list_getat(el.value, 1, "-");
  var STLOCATION = list_getat(el.value, 2, "-");
  var Res = wrk_query(
    "SELECT TOP 10 PRODUCT_PLACE_ID,SHELF_CODE FROM PRODUCT_PLACE WHERE STORE_ID=" +
      STORE +
      " AND LOCATION_ID=" +
      STLOCATION,
    "DSN3"
  );
  $("#PRODUCT_PLACE_ID").html('<option value="">Seçiniz</option>');
  for (let index = 0; index < Res.recordcount; index++) {
    var opt = document.createElement("option");
    opt.value = Res.PRODUCT_PLACE_ID[index];
    opt.innerText = Res.SHELF_CODE[index];
    document.getElementById("PRODUCT_PLACE_ID").appendChild(opt);
  }

  $("#DEP_LOC").val(el.value);
  el.setAttribute("disabled", "yes");
}
function kontrol() {
  var shelf = document.getElementById("PRODUCT_PLACE_ID").value;
  var loc = document.getElementById("DEPARTMENT_LOCATION").value;
  if (shelf.length == 0 || loc.length == 0) {
    alert("Raf - Lokasyon Seçmediniz !");
    return false;
  } else {
    return true;
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
