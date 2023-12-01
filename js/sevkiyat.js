/**
 * YAPILACAK BUNLARI YAPMAN LAZIM
 * UYARI BUNLARDA UYARILAR
 * BILGI BUNLAR HEP BILGI
 * TAMAM BUNLAR TAMAM
 * TESTET BUNLAR TEST EDILECEK
 * DIKKAT BUNLARA DIKKAT EDILECEK
 * TEMIZLE BUNLARDA TEMIZLENECEK
 * @param {*} el
 * @param {*} ev
 */
function islemYap(el, ev) {
  if (ev.keyCode == 13) {
    //console.log(el.value)
    var SEPET_DEPARTMAN_ID = document.getElementById("DEPARTMENT_ID").value;
    var SEPET_LOCATION_ID = document.getElementById("LOCATION_ID").value;
    var SEPET_ORDER_ID = document.getElementById("ORDER_ID").value;
    var SEPET_ID = document.getElementById("SEPET_ID").value;
    var UrunBarkodu = el.value;
    UrunBarkodu = ReplaceAll(UrunBarkodu, "||", "|");
    var UrunKodu = list_getat(UrunBarkodu, 1, "|");
    var LotNo = list_getat(UrunBarkodu, 2, "|");
    var Agirlik = list_getat(UrunBarkodu, 3, "|");
    var OSX = {
      UrunKodu: UrunKodu,
      LotNo: LotNo,
      Agirlik: Agirlik,
      SEPET_DEPARTMAN_ID: SEPET_DEPARTMAN_ID,
      SEPET_LOCATION_ID: SEPET_LOCATION_ID,
      SEPET_ORDER_ID: SEPET_ORDER_ID,
      SEPET_ID: SEPET_ID,
    };
    //BILGI LOT NO DAHA ÖNCESİNDE OKUTULMUŞ MU KONTROLÜ
    var Res1 = wrk_query(
      "SELECT * FROM SEVKIYAT_SEPET_ROW_READ_PBS WHERE LOT_NO='" + LotNo + "'",
      "dsn3"
    );
    console.log(Res1);
    if (Res1.recordcount == 0) {
      //BILGI LOT_NO DAN STOK VERİSİNE ULAŞMAK İÇİN BURASI VAR
      var QueryString =
        "SELECT * FROM ( SELECT SUM(SR.STOCK_IN-SR.STOCK_OUT) AS SSSR,SR.PRODUCT_ID,SR.STOCK_ID,S.PRODUCT_NAME,SR.STORE,SR.STORE_LOCATION ,SR.PBS_RELATION_ID,SL.COMMENT FROM w3Toruntex_2023_1.STOCKS_ROW AS SR";
      QueryString +=
        " INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SR.STORE_LOCATION AND SL.DEPARTMENT_ID=SR.STORE WHERE LOT_NO='" +
        LotNo +
        " INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID' GROUP BY SR.PRODUCT_ID,SR.STORE,SR.STORE_LOCATION ,SR.PBS_RELATION_ID,SL.COMMENT,SR.STOCK_ID,S.PRODUCT_NAME ) AS TTTS WHERE SSSR<>0";
      var Res2 = wrk_query(QueryString, "dsn2");
      console.log(Res2);
      OSX.STOCK_LOCATION_ID = Res2.STORE_LOCATION[0];
      OSX.STOCK_DEPARTMENT_ID = Res2.STORE[0];
      OSX.PRODUCT_ID = Res2.PRODUCT_ID[0];
      OSX.STOCK_ID = Res2.STOCK_ID[0];
      OSX.PBS_RELATION_ID = Res2.PBS_RELATION_ID[0];

      var SL_1 = OSX.SEPET_DEPARTMAN_ID + "-" + OSX.SEPET_LOCATION_ID;
      var SL_2 = OSX.STOCK_DEPARTMENT_ID + "-" + OSX.STOCK_LOCATION_ID;
      if (SL_1 == SL_2) {
        OSX.TASIMA = 0;
      } else {
        OSX.TASIMA = 1;
      }
      //BILGI SATIRDA VARMI
      var Satirim = document.getElementByProductId(OSX.PRODUCT_ID);
      if (Satirim != undefined) {
        OSX.SATIRDA = 1;
      } else {
        OSX.SATIRDA = 0;
      }
      //BILGI SİPARİŞTE BU ÜRÜN VARMI KONTROLÜ
      var QueryString =
        "SELECT * FROM ORDER_ROW WHERE ORDER_ID=" +
        SEPET_ORDER_ID +
        " AND PRODUCT_ID=" +
        OSX.PRODUCT_ID;
      var Res3 = wrk_query(QueryString, "dsn3");
      console.log(Res3);

      if (Res3.recordcount) {
        OSX.EXTRA_PRODUCT = 0;
        OSX.HAVE_SIPARIS = 1;
      } else {
        OSX.EXTRA_PRODUCT = 1;
        OSX.HAVE_SIPARIS = 0;
      }

      // BILGI Burada Taşıma İşlemleri Yapılıyor

      if (OSX.EXTRA_PRODUCT == 1) {
        // BILGI Ürünün Siparişte Olmama Durumu
        var TasimaVeri = {
          FROM_STOCK_ID: OSX.STOCK_ID,
          FROM_LOT_NO: OSX.LotNo,
          FROM_AMOUNT: OSX.Agirlik,
          FROM_WRK_ROW_ID: OSX.PBS_RELATION_ID,
          TO_DEPARTMENT_ID: OSX.SEPET_DEPARTMAN_ID,
          TO_LOCATION_ID: OSX.SEPET_LOCATION_ID,
          FROM_DEPARTMENT_ID: OSX.STOCK_DEPARTMENT_ID,
          FROM_LOCATION_ID: OSX.STOCK_LOCATION_ID,
          TO_WRK_ROW_ID: "",
        };
        var str = JSON.stringify(TasimaVeri);
        $.get(
          "/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=14&data=" +
            str
        ); /**/
        SepeteEkle(
          OSX.SEPET_ID,
          TasimaVeri.TO_WRK_ROW_ID,
          OSX.PRODUCT_ID,
          0,
          0
        );
        console.table(TasimaVeri);
      } else {
        // BILGI Ürünün Siparişteyse Ve Deposu Farklıysa
        if (OSX.TASIMA == 1) {
          var TasimaVeri = {
            FROM_STOCK_ID: OSX.STOCK_ID,
            FROM_LOT_NO: OSX.LotNo,
            FROM_AMOUNT: OSX.Agirlik,
            FROM_WRK_ROW_ID: OSX.PBS_RELATION_ID,
            TO_DEPARTMENT_ID: OSX.SEPET_DEPARTMAN_ID,
            TO_LOCATION_ID: OSX.SEPET_LOCATION_ID,
            FROM_DEPARTMENT_ID: OSX.STOCK_DEPARTMENT_ID,
            FROM_LOCATION_ID: OSX.STOCK_LOCATION_ID,
            TO_WRK_ROW_ID: Res3.WRK_ROW_ID[0],
          };
          var str = JSON.stringify(TasimaVeri);
          $.get(
            "/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=14&data=" +
              str
          ); /**/
          console.table(TasimaVeri);
        }
      }
      //YAPILACAK TAŞIMA SONRASI SEPET_ROW'A KAYIT EKLE
      //YAPILACAK SEPET_ROW_READINGS'E KAYIT EKLE
      if (OSX.SATIRDA != 1) {
        SatirEkle(OSX.PRODUCT_ID, OSX.PRODUCT_NAME, OSX.Agirlik);
      } else {
        SatirGuncelle(PRODUCT_ID, AMOUNT);
      }

      console.table(OSX);
    } else {
      alert("Bu Lot Numarası Daha Önce Okutulmuş");
    }
  }
}
//BILGI URUN ID'SI VERİLEN SATIRI BULMAK İÇİN KULLANILIR
document.getElementByProductId = function (idb) {
  var str = idb.toString();
  var el = $("*").find("* [data-product_id='" + str + "']")[0];
  return el;
};

function OkumaEkle(AMOUNT, AMOUNT2, LOT_NO, SEPET_ROW_ID) {}

function SepeteEkle(SEPET_ID, WRK_ROW_ID, PRODUCT_ID, AMOUNT, AMOUNT2) {
  var str =
    "INSERT INTO  w3Toruntex_1.SEVKIYAT_SEPET_ROW_PBS (SEPET_ID,WRK_ROW_ID,PRODUCT_ID,AMOUNT,AMOUNT2) VALUES (" +
    SEPET_ID +
    ",'" +
    WRK_ROW_ID +
    "'," +
    PRODUCT_ID +
    "," +
    AMOUNT +
    ",1) ";

}

function SatirEkle(PRODUCT_ID, PRODUCT_NAME, AMOUNT) {
  var tr = document.createElement("tr");
  var td = document.createElement("td");
  td.setAttribute("data-product_id", PRODUCT_ID);
  td.innerText = AMOUNT + "/" + "0";
  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText(1 + "/" + 0);
  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText = PRODUCT_NAME;
  tr.appendChild(td);
}

function SatirGuncelle(PRODUCT_ID, ARGA_AMOUNT) {
  var AMOUNT_ = document.getElementById("AMOUNT_" + PRODUCT_ID).innerText;
  var TOTAL_1 = list_getat(AMOUNT_, 2, "/").trim();
  var AMOUNT__ = list_getat(AMOUNT_, 1, "/").trim();
  var AMOUNT = parseFloat(AMOUNT__);

  var AMOUNT2_ = document.getElementById("AMOUNT2_" + PRODUCT_ID).innerText;
  var TOTAL_2 = list_getat(AMOUNT2_, 2, "/").trim();
  var AMOUNT2__ = list_getat(AMOUNT2_, 1, "/").trim();
  var AMOUNT2 = parseFloat(AMOUNT2__);

  var str_1 = (AMOUNT + ARGA_AMOUNT).toString() + "/" + TOTAL_1;
  document.getElementById("AMOUNT_" + PRODUCT_ID).innerText = str_1;
  var str_2 = (AMOUNT2 + 1).toString() + "/" + TOTAL_2;
  document.getElementById("AMOUNT2_" + PRODUCT_ID).innerText = str_2;
}
function wrk_query_pbs(str_query, data_source, maxrows) {
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
  callpage("/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=query_executer&isAjax=1");
  //alert(new_query);

  return new_query;
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