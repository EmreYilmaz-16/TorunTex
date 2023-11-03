var $select = null;
var $sipSelect = null;
var MainOrderRowID = 0;
var CurrentStation = null;
$(document).ready(function () {
  document
    .getElementById("wrk_main_layout")
    .setAttribute("class", "container-fluid");
  $sipSelect = $("#select_1").selectize({
    valueField: "PRODUCT_ID",
    labelField: "PRODUCT_NAME",
    searchField: "PRODUCT_NAME",
    onChange: eventHandler_1("onChange"),
  });
  $select = $("#select_2").selectize({
    valueField: "ORDER_ROW_ID",
    labelField: "ORDER_NUMBER",
    searchField: "ORDER_NUMBER",
    onChange: eventHandler_2("onChange"),
  });
  if (localStorage.getItem("ACTIVE_STATION") != null) {
    var Obj = JSON.parse(localStorage.getItem("ACTIVE_STATION"));
    CurrentStation = Obj.STATION;
    getProducts(CurrentStation);
  } else {
    OpenLogIn();
  }
  //   $("#select_2").selectize();
});
var eventHandler_1 = function (name) {
  return function () {
    console.log(name, arguments);
    //$('#log').append('<div><span class="name">' + name + '</span></div>');
    getOrders(arguments[0]);
  };
};
var eventHandler_2 = function (name) {
  return function () {
    console.log(name, arguments);
    //$('#log').append('<div><span class="name">' + name + '</span></div>');
    getAOrder(arguments[0]);
  };
};
function OpenLogIn() {
  openBoxDraggable(
    "index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=10"
  );
}
function getOrders(product_id) {
  if (localStorage.getItem("ACTIVE_STATION") != null) {
    var RS = localStorage.getItem("ACTIVE_STATION");
    $.ajax({
      url:
        "/AddOns/Partner/servis/MasaServis.cfc?method=getOrders&PRODUCT_ID=" +
        product_id +
        "&STATION=" +
        RS,
      success: function (retDat) {
        console.log(retDat);
        var arr = JSON.parse(retDat);
        console.log(arr);
        var control = $select[0].selectize;
        control.clear();
        control.clearOptions();
        for (let i = 0; i < arr.length; i++) {
          /* var opt=document.createElement("option");
            opt.setAttribute("value",arr[i].ORDER_ROW_ID);
            opt.innerText=arr[i].ORDER_NUMBER;
            document.getElementById("select_2").appendChild(opt);*/
          control.addOption({
            ORDER_ROW_ID: arr[i].ORDER_ROW_ID,
            ORDER_NUMBER: arr[i].ORDER_NUMBER,
            NICKNAME: arr[i].NICKNAME,
            ORDER_HEAD: arr[i].ORDER_HEAD,
          });
        }
      },
    });
  } else {
    alert("Giriş Yapınız");
  }
}
function getAOrder(ORDER_ROW_ID) {
  MainOrderRowID = ORDER_ROW_ID;
  $.ajax({
    url:
      "/AddOns/Partner/servis/MasaServis.cfc?method=getAOrder&ORDER_ROW_ID=" +
      ORDER_ROW_ID,
    success: function (retDat) {
      console.log(retDat);
      var Obj = JSON.parse(retDat);
      console.log(Obj);
      $("#RenkYazi").text(Obj.PROPERTY5);
      var Renk1_ = list_getat(Obj.PROPERTY5, 1, "-");
      var Renk2_ = list_getat(Obj.PROPERTY5, 2, "-");
      var Renk1 = "";
      var Renk2 = "";
      if (Renk1_ == "BEYAZ") {
        Renk1 = "white";
      } else if (Renk1_ == "SARI") {
        Renk1 = "yellow";
      } else if (Renk1_ == "YEŞİL") {
        Renk1 = "green";
      } else {
        Renk1 = "antiquewhite";
      }
      if (Renk2_ == "BEYAZ") {
        Renk2 = "white";
      } else if (Renk2_ == "SARI") {
        Renk2 = "yellow";
      } else if (Renk2_ == "YEŞİL") {
        Renk2 = "green";
      } else if (Renk2_ == "MAVİ") {
        Renk2 = "blue";
      } else {
        Renk2 = "antiquewhite";
      }
      $("#color1").attr(
        "style",
        "display:block;border: solid 0.5px black;background: " +
          Renk1 +
          ";width: 25%;"
      );
      $("#color2").attr(
        "style",
        "display:block;border: solid 0.5px black;background: " +
          Renk2 +
          ";width: 25%;"
      );
      $("#Country").text(Obj.COUNTRY_NAME);
      $("#Customer").text(Obj.NICKNAME);
      $("#paketIcerik").val(Obj.A1);
      $("#paketKG").val(Obj.A2);
      $("#WRK_ROW_ID").val(Obj.WRK_ROW_ID);
      $("#sipres").html("");
      $("#Complate").text(wrk_round(Obj.TAMAMLANMA) + " %");
      $("#LotNo").val(LotVer(CurrentStation));
      for (let i = 0; i < Obj.ALL_ROWS.length; i++) {
        var OO = Obj.ALL_ROWS[i];
        var tr = document.createElement("tr");
        var td = document.createElement("td");
        td.innerText = OO.PRODUCT_NAME;
        tr.appendChild(td);
        var td = document.createElement("td");
        td.innerText = commaSplit(OO.QUANTITY);
        tr.appendChild(td);
        var td = document.createElement("td");
        td.innerText = commaSplit(OO.R_AMOUNT);
        tr.appendChild(td);
        document.getElementById("sipres").appendChild(tr);
      }
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
function Yaz(sayi) {
  if (sayi > 0) {
    if (TxResult.value == "0") {
      if (sayi != -4) {
        TxResult.value = sayi;
      } else {
        TxResult.value += sayi;
      }
    } else {
      TxResult.value += sayi;
    }
  } else if (sayi < 0) {
    if (sayi == -1)
      TxResult.value = TxResult.value.substr(0, TxResult.value.length - 1);
    if (sayi == -2) TxResult.value = "0";
    if (sayi == -3) TxResult.value = "";
    if (sayi == -4) TxResult.value += ",";
    if (sayi == -5) TxResult.value += "";
  } else if (sayi == "0") {
    TxResult.value += sayi;
  }
}
var str = "";
$("body").on("keyup", function (event) {
  //console.log(event)

  console.log(str);
  if (event.keyCode == 13) {
    var Control = $sipSelect[0].selectize;
    var numa = wrk_query(
      "SELECT PRODUCT_ID FROM STOCKS WHERE PRODUCT_NAME='" + str + "'",
      "DSN3"
    );
    if (numa.recordcount > 0) {
      var num = numa.PRODUCT_ID[0];
    } else {
      alert("ürün bulunamadı");
      str = "";
      return false;
    }
    Control.setValue([num]);
    str = "";
  } else {
    str += event.key;
  }
});

function Yazdir() {
  var AMOUNT = document.getElementById("TxResult").value;
  var LOT_NO = document.getElementById("LotNo").value;
  var WRK_ROW_ID = document.getElementById("WRK_ROW_ID").value;
  var Depo = localStorage.getItem("ACTIVE_STATION");
  $.ajax({
    url:
      "/AddOns/Partner/Servis/MasaServis.cfc?method=SaveBelge&AMOUNT=" +
      AMOUNT +
      "&WRK_ROW_ID=" +
      WRK_ROW_ID +
      "&LOT_NUMARASI=" +
      LOT_NO +
      "&DEPO=" +
      Depo,
    success: function (returnData) {
      var Obj = JSON.parse(returnData);
      alert(Obj.MESSAGE);
      getAOrder(MainOrderRowID);
    },
  });
}
function setStation(DEPARTMENT_ID, LOCATION_ID, STATION, FULL_STATION) {
  var StationObject = {
    DEPARTMENT_ID: DEPARTMENT_ID,
    LOCATION_ID: LOCATION_ID,
    STATION: STATION,
    FULL_STATION: FULL_STATION,
  };
  localStorage.setItem("ACTIVE_STATION", JSON.stringify(StationObject));

  $("#Location").text(FULL_STATION);
  CurrentStation = StationObject.STATION;
  getProducts(STATION);
}

function getProducts(STATION) {
  var qstr =
    "SELECT PRODUCT_NAME,STOCKS.PRODUCT_ID,STOCK_ID,PRODUCT_DETAIL FROM w3Toruntex_1.STOCKS LEFT JOIN w3Toruntex_1.PRODUCT_INFO_PLUS ON PRODUCT_INFO_PLUS.PRODUCT_ID=STOCKS.PRODUCT_ID WHERE PRODUCT_CATID NOT IN (26) AND PROPERTY1 LIKE '%" +
    STATION +
    "%'  ORDER BY STOCK_CODE";
  var q = wrk_query(qstr, "dsn3");
  var Control = $sipSelect[0].selectize;
  Control.clearOptions();
  for (let index = 0; index < q.PRODUCT_NAME.length; index++) {
    Control.addOption({
      PRODUCT_NAME: q.PRODUCT_NAME[index],
      PRODUCT_ID: q.PRODUCT_ID[index],
      STOCK_ID: q.STOCK_ID[index],
      PRODUCT_DETAIL: q.PRODUCT_DETAIL[index],
    });
  }
}
function LotVer(STATION) {
  var d = new Date();
  var Sdate = d.toLocaleString();
  var Sda = list_getat(Sdate, 1, " ");
  var ReturnValue = "";
  var Qstr = wrk_query("SELECT * FROM  PBS_LOT_NUMBER", "dsn3");
  console.log(Qstr);
  var Lot = Qstr.LOT_NO[0];
  var SifirSay = "";
  if (Lot.length == 1) SifirSay = "00000";
  else if (Lot.length == 2) SifirSay = "0000";
  else if (Lot.length == 3) SifirSay = "000";
  else if (Lot.length == 4) SifirSay = "00";
  else if (Lot.length == 5) SifirSay = "0";
  var KLB = "1";
  var SCK = "2";
  var GRB = "3";

  ReturnValue += eval(STATION);
  ReturnValue += list_getat(Sda, 1, ".");
  ReturnValue += list_getat(Sda, 2, ".");
  ReturnValue += list_getat(Sda, 3, ".");
  ReturnValue += SifirSay;
  ReturnValue += Lot;
  $.post("/AddOns/Partner/Servis/MasaServis.cfc?method=UpLot");
  return ReturnValue;
}
/**
 * TC Kimlik No Kontrolü :)
 */
/* 
function tck() {
  var tc = prompt("Tc Kimlik No Gir");
  var tca = tc.split("");
  var t1 = 0;
  var t2 = 0;
  var t3 = 0;
  var hata = true; 

  for (let i = 0; i < tca.length; i++) {
    if (i == 0 || i == 2 || i == 4 || i == 6 || i == 8) t1 += parseInt(tca[i]);

    if (i == 1 || i == 3 || i == 5 || i == 7) t2 += parseInt(tca[i]);

    if (i < tca.length - 1) t3 += parseInt(tca[i]);
  }
  var t1_ = (t1 * 7 - t2) % 10;
  var k1 = tc.substring(9, 10);

  if (t1_.toString() == k1) hata = false;
  else hata = true;

  var t2_ = t3.toString().charAt(t3.toString().length - 1);

  var k2 = tc.substring(10, 11);
  if (t2_.toString() == k2) hata = false;
  else hata = true;

  if (hata) {
    alert("Hatalı TC");
  } else alert("Giriş Başarılı");
  
}*/
