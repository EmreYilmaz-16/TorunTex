var ROW_COUNT = 1;
function getShelves(el) {
  var DEPARTMENT_ID = list_getat(el.value, 1, "-");
  var LOCATION_ID = list_getat(el.value, 2, "-");
  var Res = wrk_query(
    "SELECT SHELF_CODE,PRODUCT_PLACE_ID FROM PRODUCT_PLACE WHERE STORE_ID=" +
      DEPARTMENT_ID +
      " AND LOCATION_ID=" +
      LOCATION_ID,
    "DSN3"
  );
  $("#DEP_LOC").val(el.value);
  $("#SHELF").html('<option value="">Seçiniz</option>');
  for (let index = 0; index < Res.SHELF_CODE.length; index++) {
    var opt = document.createElement("option");
    opt.setAttribute("value", Res.PRODUCT_PLACE_ID[index]);
    opt.innerText = Res.SHELF_CODE[index];
    document.getElementById("SHELF").appendChild(opt);
  }
  el.setAttribute("disabled", "yes");
}
function getShelfProducts(el) {
  $("#SHELF_ID").val(el.value);
  el.setAttribute("disabled", "yes");
  AjaxPageLoad(
    "index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=34&SHELF_NUMBER=" +
      el.value,
    "URUNLER",
    1,
    "Yükleniyor"
  );
}
function getShelfProductsz(el) {
  var str =
    "SELECT * FROM  (SELECT SUM(AMOUNT) AS A,SUM(AMOUNT2) AS A2,T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PP.PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID FROM (";
  str +=
    " SELECT SUM(AMOUNT) AMOUNT ,SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM (SELECT SR.AMOUNT, UNIT ,SR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,ROW_PROJECT_ID AS PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM " +
    dsn2 +
    ".SHIP_ROW AS SR";
  str +=
    " LEFT JOIN " +
    dsn2 +
    ".SHIP AS S ON S.SHIP_ID=SR.SHIP_ID WHERE 1=1 AND S.DEPARTMENT_IN=13 ) AS T2 GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 UNION ALL";
  str +=
    " SELECT -1* SUM(AMOUNT) AMOUNT,-1* SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM ( SELECT SFR.AMOUNT,UNIT,SFR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM " +
    dsn2 +
    ".STOCK_FIS_ROW AS SFR ";
  str +=
    " LEFT JOIN " +
    dsn2 +
    ".STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID WHERE SF.DEPARTMENT_OUT=13 ) AS T GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2) AS T2";
  str +=
    " LEFT JOIN " +
    dsn +
    ".PRO_PROJECTS AS PP ON PP.PROJECT_ID=T2.PROJECT_ID LEFT JOIN " +
    dsn3 +
    ".STOCKS AS  S ON S.STOCK_ID=T2.STOCK_ID LEFT JOIN " +
    dsn3 +
    ".PRODUCT_PLACE AS PS ON PS.PRODUCT_PLACE_ID=T2.SHELF_NUMBER";
  str +=
    " GROUP BY T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID) AS TS WHERE A>0 AND SHELF_NUMBER=" +
    el.value;
  $("#URUNLER").html("");
  var Res = wrk_query(str, "dsn3");
  for (let index = 0; index < Res.recordcount; index++) {
    var tr = document.createElement("tr");
    var td = document.createElement("td");
    td.setAttribute("id", "PRODUCT_CODE_" + index);
    td.innerText = Res.PRODUCT_CODE[index];
    tr.appendChild(td);
    var td = document.createElement("td");
    td.innerText = Res.PRODUCT_NAME[index];
    td.setAttribute("id", "PRODUCT_NAME" + index);
    tr.appendChild(td);
    var td = document.createElement("td");
    var input = document.createElement("input");
    input.value = Res.A[index];
    input.setAttribute("type", "text");
    input.setAttribute("readonly", "yes");
    input.setAttribute("data-rid", index);
    input.setAttribute("id", "A_" + index);
    input.setAttribute("data-stm", Res.A[index]);
    td.appendChild(input);
    tr.appendChild(td);

    var td = document.createElement("td");
    var input = document.createElement("input");
    input.value = Res.A2[index];
    input.setAttribute("type", "text");
    input.setAttribute("onchange", "hasapEt(this,event)");
    input.setAttribute("data-rid", index);
    input.setAttribute("id", "A2_" + index);
    input.setAttribute("data-stm", Res.A2[index]);
    td.appendChild(input);
    tr.appendChild(td);
    var td = document.createElement("td");
    td.innerText = Res.PROJECT_HEAD[index];
    td.setAttribute("id", "PROJECT_HEAD_" + index);
    tr.appendChild(td);
    var td = document.createElement("td");

    var btn = document.createElement("button");
    btn.innerText = "Ekle";
    btn.setAttribute("class", "btn btn-sm btn-success");
    td.appendChild(btn);
    tr.appendChild(td);
    btn.setAttribute(
      "onclick",
      "satirEkle(this," + index + "," + Res.STOCK_ID[index] + ")"
    );
    document.getElementById("URUNLER").appendChild(tr);
  }
}

function hasapEt(el, ev) {
  debugger;
  var BASLANGIC_MIKTAR2 = el.getAttribute("data-stm");
  BASLANGIC_MIKTAR2 = parseInt(BASLANGIC_MIKTAR2);
  var RC = el.getAttribute("data-rid");
  RC = parseInt(RC);
  var BASLANGIC_KG = document
    .getElementById("A_" + RC)
    .getAttribute("data-stm");
  BASLANGIC_KG = parseFloat(BASLANGIC_KG);
  var BirimCuvalAgirlik = BASLANGIC_KG / BASLANGIC_MIKTAR2;
  var e = BirimCuvalAgirlik * parseInt(el.value);
  document.getElementById("A_" + RC).value = e;
}
function satirEkle(el, rc, STOCK_ID, PROJECT_ID, LOT_NO) {
  var PRODUCT_NAME = document.getElementById("PRODUCT_NAME_" + rc).innerText;
  var PRODUCT_CODE = document.getElementById("PRODUCT_CODE_" + rc).innerText;
  var PROJECT_HEAD = document.getElementById("PROJECT_HEAD_" + rc).innerText;
  var A = document.getElementById("A_" + rc).value;
  var A2 = document.getElementById("A2_" + rc).value;
  var tr = document.createElement("tr");

  var td = document.createElement("td");
  td.innerText = PRODUCT_CODE;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PRODUCT_NAME;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PROJECT_HEAD;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = LOT_NO;
  tr.appendChild(td);

  var td = document.createElement("td");
  var input = document.createElement("input");
  input.setAttribute("name", "MIKTAR2" + ROW_COUNT);
  input.setAttribute("type", "text");
  input.setAttribute("readonly", "yes");
  input.value = A2;
  td.appendChild(input);
  tr.appendChild(td);

  var td = document.createElement("td");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.setAttribute("readonly", "yes");
  input.setAttribute("name", "MIKTAR" + ROW_COUNT);
  input.value = A;
  td.appendChild(input);
  tr.appendChild(td);

  var td = document.createElement("td");
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("readonly", "yes");
  input.setAttribute("name", "STOCK_ID" + ROW_COUNT);
  input.value = STOCK_ID;
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("readonly", "yes");
  input.setAttribute("name", "LOT_NO" + ROW_COUNT);
  input.value = LOT_NO;
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("readonly", "yes");
  input.setAttribute("name", "PROJECT_ID" + ROW_COUNT);
  input.value = PROJECT_ID;
  td.appendChild(input);
  tr.appendChild(td);
  document.getElementById("Sepetim").appendChild(tr);
  $("#TSATIR").val(ROW_COUNT);
  ROW_COUNT++;
}
function temzile() {
  window.location.reload();

  // document.getElementById("LOCATION").removeAttribute("disabled");
  // document.getElementById("SHELF").removeAttribute("disabled");
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
