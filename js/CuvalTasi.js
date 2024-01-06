var ValidStyle = "color: green; font-weight: bold; background: #b5e8b573;";
var InValidStyle = "color: red; font-weight: bold; background: #ff7a7a66;";
var AktifSiparisSureci = 259;

function SearchBarcode(el, ev) {
  if (ev.keyCode == 13) {
    var UrunBarkodu = el.value;
    UrunBarkodu = ReplaceAll(UrunBarkodu, "||", "|");
    var UrunKodu = list_getat(UrunBarkodu, 1, "|");
    var LotNo = list_getat(UrunBarkodu, 2, "|");
    var Agirlik = list_getat(UrunBarkodu, 3, "|");
    /*var Qstr1 =
      "SELECT ORDERS.DELIVER_DEPT_ID,ORDERS.LOCATION_ID,ORR.WRK_ROW_ID,ORR.STOCK_ID FROM " +
      dsn3 +
      ".ORDER_ROW as ORR";
    Qstr1 += " INNER JOIN " + dsn3 + ".ORDERS ON ORDERS.ORDER_ID=ORR.ORDER_ID";
    Qstr1 +=
      " WHERE ORR.WRK_ROW_ID=( SELECT TOP 1  PBS_RELATION_ID FROM " +
      dsn2 +
      ".STOCKS_ROW where LOT_NO='" +
      LotNo +
      "' ORDER BY PROCESS_DATE DESC ,UPD_ID DESC)";*/
    var Qstr1 =
      "SELECT TOP 1 STORE DELIVER_DEPT_ID,STORE_LOCATION LOCATION_ID,STOCK_ID,PBS_RELATION_ID AS WRK_ROW_ID,UNIT2 FROM " +
      dsn2 +
      ".STOCKS_ROW WHERE  LOT_NO='" +
      LotNo +
      "' ORDER BY PROCESS_DATE DESC,UPD_ID DESC";
    var QueryResult_1 = wrk_query(Qstr1);
    if (QueryResult_1.recordcount > 0) {
      el.setAttribute("style", ValidStyle);
      var exxx = document.getElementById("txtFromDeptLocation");
      exxx.setAttribute("style", ValidStyle);
      var Qstr2 =
        "SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.DEPARTMENT_ID,SL.LOCATION_ID FROM STOCKS_LOCATION as SL ";
      Qstr2 +=
        " INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID  WHERE SL.DEPARTMENT_ID=" +
        QueryResult_1.DELIVER_DEPT_ID[0] +
        " AND SL.LOCATION_ID=" +
        QueryResult_1.LOCATION_ID[0];
      var QueryResult_2 = wrk_query(Qstr2);
      $("#txtFromDeptLocation").val(
        QueryResult_2.DEPARTMENT_HEAD[0] + " " + QueryResult_2.COMMENT[0]
      );
      debugger;
      var t = searchDepo_3(QueryResult_1.STOCK_ID[0], el, exxx);
      if (t == false) $("#btnKayit").hide();
      if (t == false) return false;

      $("#txtFromDeptId").val(QueryResult_2.DEPARTMENT_ID[0]);
      $("#txtFromLocId").val(QueryResult_2.LOCATION_ID[0]);
      $("#FROM_STOCK_ID").val(QueryResult_1.STOCK_ID[0]);
      $("#FROM_WRK_ROW_ID").val(QueryResult_1.WRK_ROW_ID[0]);
      $("#FROM_AMOUNT").val(Agirlik);
      $("#TO_AMOUNT").val(Agirlik);
      $("#FROM_LOT_NO").val(LotNo);
      $("#FROM_UNIT2").val(QueryResult_1.UNIT2);
      $("#TO_LOT_NO").val(LotNo);
      $("#exitr").show(500);
      $("#txtDepoAdi").focus();
      Kaydet();
    } else {
      el.setAttribute("style", InValidStyle);
    }
  }
}
function searchDepo(el, ev) {
  if (ev.keyCode == 13) {
    var STOCK_ID = $("#FROM_STOCK_ID").val();
    var Qstr1 =
      "SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.LOCATION_ID,SL.DEPARTMENT_ID FROM " +
      dsn +
      ".STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID WHERE 1=1 AND COMMENT ='" +
      el.value +
      "'";
    // var Qstr1="SELECT * FROM "+dsn+".STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D WHERE 1=1 AND COMMENT ='"+el.value+"'";
    var QueryResult_1 = wrk_query(Qstr1);
    if (QueryResult_1.recordcount > 0) {
      var Qstr2 =
        "SELECT O.ORDER_ID,ORDER_NUMBER,ORDER_HEAD,ORR.WRK_ROW_ID,ORR.STOCK_ID,ORR.UNIT2 FROM " +
        dsn3 +
        ".ORDERS AS O";
      Qstr2 +=
        " INNER JOIN " + dsn3 + ".ORDER_ROW AS ORR ON ORR.ORDER_ID=O.ORDER_ID ";
      Qstr2 +=
        " WHERE O.ORDER_STAGE=" +
        AktifSiparisSureci +
        " AND O.DELIVER_DEPT_ID=" +
        QueryResult_1.DEPARTMENT_ID[0] +
        " AND O.LOCATION_ID=" +
        QueryResult_1.LOCATION_ID[0] +
        "  AND ORR.STOCK_ID=" +
        STOCK_ID;
      var QueryResult_2 = wrk_query(Qstr2);

      if (
        QueryResult_2.recordcount > 0 ||
        QueryResult_1.DEPARTMENT_ID[0] == 15
      ) {
        el.setAttribute("style", ValidStyle);
        document
          .getElementById("txtToDeptLocation")
          .setAttribute("style", ValidStyle);
        $("#txtToDeptId").val(QueryResult_1.DEPARTMENT_ID[0]);
        $("#txtToLocId").val(QueryResult_1.LOCATION_ID[0]);
        $("#txtToDeptLocation").val(
          QueryResult_1.DEPARTMENT_HEAD[0] + "-" + QueryResult_1.COMMENT[0]
        );

        $("#TO_STOCK_ID").val(STOCK_ID);
        if (QueryResult_2.recordcount > 0) {
          $("#TO_WRK_ROW_ID").val(QueryResult_2.WRK_ROW_ID[0]);
        } else {
          $("#TO_WRK_ROW_ID").val("");
        }

        $("#btnKayit").show();
        return true;
      } else {
        el.setAttribute("style", InValidStyle);
        document
          .getElementById("txtToDeptLocation")
          .setAttribute("style", InValidStyle);
        return false;
      }
    } else {
      el.setAttribute("style", InValidStyle);
      return false;
    }
  }
}
function searchDepo_2(el, ev) {
  var STOCK_ID = $("#FROM_STOCK_ID").val();
  var Qstr1 =
    "SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.LOCATION_ID,SL.DEPARTMENT_ID FROM " +
    dsn +
    ".STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID WHERE 1=1 AND COMMENT ='" +
    el.value +
    "'";
  // var Qstr1="SELECT * FROM "+dsn+".STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D WHERE 1=1 AND COMMENT ='"+el.value+"'";
  var QueryResult_1 = wrk_query(Qstr1);
  if (QueryResult_1.recordcount > 0) {
    var Qstr2 =
      "SELECT O.ORDER_ID,ORDER_NUMBER,ORDER_HEAD,ORR.WRK_ROW_ID,ORR.STOCK_ID,ORR.UNIT2 FROM " +
      dsn3 +
      ".ORDERS AS O";
    Qstr2 +=
      " INNER JOIN " + dsn3 + ".ORDER_ROW AS ORR ON ORR.ORDER_ID=O.ORDER_ID ";
    Qstr2 +=
      " WHERE O.ORDER_STAGE=" +
      AktifSiparisSureci +
      " AND O.DELIVER_DEPT_ID=" +
      QueryResult_1.DEPARTMENT_ID[0] +
      " AND O.LOCATION_ID=" +
      QueryResult_1.LOCATION_ID[0] +
      "  AND ORR.STOCK_ID=" +
      STOCK_ID;
    var QueryResult_2 = wrk_query(Qstr2);

    if (QueryResult_2.recordcount > 0 || QueryResult_1.DEPARTMENT_ID[0] == 15) {
      el.setAttribute("style", ValidStyle);
      document
        .getElementById("txtToDeptLocation")
        .setAttribute("style", ValidStyle);
      $("#txtToDeptId").val(QueryResult_1.DEPARTMENT_ID[0]);
      $("#txtToLocId").val(QueryResult_1.LOCATION_ID[0]);
      $("#txtToDeptLocation").val(
        QueryResult_1.DEPARTMENT_HEAD[0] + "-" + QueryResult_1.COMMENT[0]
      );

      $("#TO_STOCK_ID").val(STOCK_ID);
      if (QueryResult_2.recordcount > 0) {
        $("#TO_WRK_ROW_ID").val(QueryResult_2.WRK_ROW_ID[0]);
      } else {
        $("#TO_WRK_ROW_ID").val("");
      }

      $("#btnKayit").show();
    } else {
      el.setAttribute("style", InValidStyle);
      document
        .getElementById("txtToDeptLocation")
        .setAttribute("style", InValidStyle);
    }
  } else {
    el.setAttribute("style", InValidStyle);
  }
}
function searchDepo_3(STOCK_ID, el, el2) {
  var cmnt = document.getElementById("txtDepoAdi").value;
  //var STOCK_ID = $("#FROM_STOCK_ID").val();
  var Qstr1 =
    "SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.LOCATION_ID,SL.DEPARTMENT_ID FROM " +
    dsn +
    ".STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID WHERE 1=1 AND COMMENT ='" +
    cmnt +
    "'";
  // var Qstr1="SELECT * FROM "+dsn+".STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D WHERE 1=1 AND COMMENT ='"+el.value+"'";
  var QueryResult_1 = wrk_query(Qstr1);
  if (QueryResult_1.recordcount > 0) {
    var Qstr2 =
      "SELECT O.ORDER_ID,ORDER_NUMBER,ORDER_HEAD,ORR.WRK_ROW_ID,ORR.STOCK_ID,ORR.UNIT2 FROM " +
      dsn3 +
      ".ORDERS AS O";
    Qstr2 +=
      " INNER JOIN " + dsn3 + ".ORDER_ROW AS ORR ON ORR.ORDER_ID=O.ORDER_ID ";
    Qstr2 +=
      " WHERE O.ORDER_STAGE=" +
      AktifSiparisSureci +
      " AND O.DELIVER_DEPT_ID=" +
      QueryResult_1.DEPARTMENT_ID[0] +
      " AND O.LOCATION_ID=" +
      QueryResult_1.LOCATION_ID[0] +
      "  AND ORR.STOCK_ID=" +
      STOCK_ID;
    var QueryResult_2 = wrk_query(Qstr2);

    if (QueryResult_2.recordcount > 0 || QueryResult_1.DEPARTMENT_ID[0] == 15) {
      el.setAttribute("style", ValidStyle);
      el2.setAttribute("style", ValidStyle);
      document
        .getElementById("txtToDeptLocation")
        .setAttribute("style", ValidStyle);
      $("#txtToDeptId").val(QueryResult_1.DEPARTMENT_ID[0]);
      $("#txtToLocId").val(QueryResult_1.LOCATION_ID[0]);
      $("#txtToDeptLocation").val(
        QueryResult_1.DEPARTMENT_HEAD[0] + "-" + QueryResult_1.COMMENT[0]
      );

      $("#TO_STOCK_ID").val(STOCK_ID);
      if (QueryResult_2.recordcount > 0) {
        $("#TO_WRK_ROW_ID").val(QueryResult_2.WRK_ROW_ID[0]);
      } else {
        $("#TO_WRK_ROW_ID").val("");
      }
      document.getElementById("LastBarcode").value=el2.value
      document.getElementById("LastBarcode").setAttribute("class","text-success")
      return true;
      $("#btnKayit").show();
    } else {
      el.setAttribute("style", InValidStyle);
      el2.setAttribute("style", InValidStyle);
      
      document
        .getElementById("txtToDeptLocation")
        .setAttribute("style", InValidStyle);
        document.getElementById("LastBarcode").value=el2.value
        document.getElementById("LastBarcode").setAttribute("class","text-danger")
      return false;
    }
  } else {
    el.setAttribute("style", InValidStyle);
    el.setAttribute("style", InValidStyle);
    document.getElementById("LastBarcode").value=el2.value
    document.getElementById("LastBarcode").setAttribute("class","text-danger")
    return false;
  }
}
function Kaydet() {
  var FROM_DEPARTMENT_ID = $("#txtFromDeptId").val();
  var FROM_LOCATION_ID = $("#txtFromLocId").val();
  var FROM_WRK_ROW_ID = $("#FROM_WRK_ROW_ID").val();
  var FROM_STOCK_ID = $("#FROM_STOCK_ID").val();
  var FROM_AMOUNT = $("#FROM_AMOUNT").val();
  var FROM_LOT_NO = $("#FROM_LOT_NO").val();
  var FROM_UNIT2 = $("#FROM_UNIT2").val();
  var TO_DEPARTMENT_ID = $("#txtToDeptId").val();
  var TO_LOCATION_ID = $("#txtToLocId").val();
  var TO_WRK_ROW_ID = $("#TO_WRK_ROW_ID").val();
  var TO_STOCK_ID = $("#TO_STOCK_ID").val();
  var TO_AMOUNT = $("#TO_AMOUNT").val();
  var TO_LOT_NO = $("#TO_LOT_NO").val();

  var FormDatam = {
    FROM_DEPARTMENT_ID: FROM_DEPARTMENT_ID,
    FROM_LOCATION_ID: FROM_LOCATION_ID,
    FROM_WRK_ROW_ID: FROM_WRK_ROW_ID,
    FROM_STOCK_ID: FROM_STOCK_ID,
    FROM_AMOUNT: FROM_AMOUNT,
    FROM_LOT_NO: FROM_LOT_NO,
    TO_DEPARTMENT_ID: TO_DEPARTMENT_ID,
    TO_LOCATION_ID: TO_LOCATION_ID,
    TO_WRK_ROW_ID: TO_WRK_ROW_ID,
    TO_STOCK_ID: TO_STOCK_ID,
    TO_AMOUNT: TO_AMOUNT,
    TO_LOT_NO: TO_LOT_NO,
    FROM_UNIT2: FROM_UNIT2,
  };
  console.log(FormDatam);
  SendFormData(
    "/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=14",
    FormDatam
  );
}

function fokuslan() {
  $("#Barcode").val("");
  $("#Barcode").focus();
  $("#txtFromDeptLocation").val("");
  $("#txtFromDeptId").val("");
  $("#txtFromLocId").val("");
  document.getElementById("Barcode").removeAttribute("style");
  document.getElementById("txtFromDeptLocation").removeAttribute("style");
  document.getElementById("txtFromDeptId").removeAttribute("style");
  document.getElementById("txtFromLocId").removeAttribute("style");
  $("#btnKayit").hide();
  //txtFromDeptLocation,txtFromDeptId,txtFromLocId
}
function sepeteEkle(
  PRODUCT_CODE,
  PRODUCT_NAME,
  AMOUNT,
  UNIT,
  FROM_DEPO,
  TO_DEPO,
  LOT_NO,
  AMOUNT2,
  UNIT2,
  FIS_ID,
  FROM_ORDER,
  TO_ORDER
) {
  console.table(arguments);
  var tr = document.createElement("tr");

  var td = document.createElement("td");
  td.innerText = LOT_NO;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PRODUCT_NAME;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = AMOUNT + " " + UNIT;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = AMOUNT2 + " " + UNIT2;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerHTML = FROM_DEPO + " &gt; " + TO_DEPO;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerHTML = FROM_ORDER + " &gt; " + TO_ORDER;
  tr.appendChild(td);

  var td = document.createElement("td");
  // td.innerText(FROM_ORDER + " > " + TO_ORDER);
  var button = document.createElement("button");
  button.setAttribute("class", "btn btn-danger");
  button.innerText = "Sil";
  button.setAttribute("onclick", "fis_sil(" + FIS_ID + ",this)");
  td.appendChild(button);
  tr.appendChild(td);
  document.getElementById("Sepetim").appendChild(tr);
  $("#Barcode").html("");
  $("#Barcode").focus();
}

function fis_sil(FIS_ID, el) {
  $.ajax({
    url:
      "/AddOns/Partner/Servis/MasaServis.cfc?method=deleteSelectedFis&FIS_ID=" +
      FIS_ID,
    success: function (retDat) {
      console.log(retDat);
      el.parentElement.parentElement.remove();
    },
  });
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
