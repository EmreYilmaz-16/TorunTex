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
$(document).ready(function () {
  var lnk = document.getElementsByTagName("link");
  for (let index = 0; index < lnk.length; index++) {
    var l = lnk[index];
    var href = l.getAttribute("href");
    if (href.indexOf("gui_custom") != -1) {
      l.remove();
    }
  }
  if (SevkStatus == 1) {
    //$("#BARKOD").focus();
    document.getElementById("BARKOD").setAttribute("disabled", "true");
  } else {
    $("#BARKOD").focus();
  }

  //AdS AdK
  $("#AdS").text(ToplamKg);
  $("#AdK").text(ToplamAdet);
});
document.addEventListener("click", function (event) {
  // Tıklanan öğe metin kutusu değilse, metin kutusuna odaklan
  var qrcodeInput=document.getElementById("BARKOD")
  if (event.target !== qrcodeInput) {
    qrcodeInput.focus();
  }
});
// YAPILACAK
//INC WRK_QUERY,document.getElementByProductId,SepeteEkle,OkumaEkle,SatirEkle, SatirGuncelle
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
        " INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SR.STORE_LOCATION AND SL.DEPARTMENT_ID=SR.STORE  INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID WHERE LOT_NO='" +
        LotNo +
        "' GROUP BY SR.PRODUCT_ID,SR.STORE,SR.STORE_LOCATION ,SR.PBS_RELATION_ID,SL.COMMENT,SR.STOCK_ID,S.PRODUCT_NAME ) AS TTTS WHERE SSSR<>0";
      var Res2 = wrk_query(QueryString, "dsn2");
      if(Res2.recordcount==0){
        $("#LastRead").text(
          OSX.LotNo + " - " + UrunKodu + " - " + OSX.Agirlik + "Kg."
        );
        
        document.getElementById("LastRead").setAttribute("class", "text-dark");
        document.getElementById("LastRead").setAttribute("style","text-decoration: line-through;")
        $("#BARKOD").val("");
        $("#BARKOD").focus();
        alert("Lot Numarası Bulunamadı !");
        return false;
      }
      console.log(Res2);
      OSX.STOCK_LOCATION_ID = Res2.STORE_LOCATION[0];
      OSX.STOCK_DEPARTMENT_ID = Res2.STORE[0];
      OSX.PRODUCT_ID = Res2.PRODUCT_ID[0];
      OSX.STOCK_ID = Res2.STOCK_ID[0];
      OSX.PBS_RELATION_ID = Res2.PBS_RELATION_ID[0];
      OSX.PRODUCT_NAME = Res2.PRODUCT_NAME[0];
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
        /*SepeteEkle(
          OSX.SEPET_ID,
          TasimaVeri.TO_WRK_ROW_ID,
          OSX.PRODUCT_ID,
          0,
          0
        );*/
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
      //TAMAM TAŞIMA SONRASI SEPET_ROW'A KAYIT EKLE
      //TAMAM
      //TAMAM SEPET_ROW_READINGS'E KAYIT EKLE
      //TAMAM
      if (OSX.SATIRDA != 1) {
        var GENERATEDKEY = SepeteEkle(
          OSX.SEPET_ID,
          "",
          OSX.PRODUCT_ID,
          OSX.Agirlik,
          1
        );
        OkumaEkle(OSX.Agirlik, 1, OSX.LotNo, GENERATEDKEY);
        SatirEkle(OSX.PRODUCT_ID, OSX.PRODUCT_NAME, OSX.Agirlik);
      } else {
        SatirGuncelle(OSX.PRODUCT_ID, OSX.Agirlik, OSX.LotNo);
      }

      console.table(OSX);
      var x = document.getElementById("myAudio");
      x.play();

      var Ads = parseFloat(document.getElementById("AdS").innerText);
      Ads += parseFloat(OSX.Agirlik);
      document.getElementById("AdS").innerText = Ads;
      var AdK = parseFloat(document.getElementById("AdK").innerText);
      AdK += 1;
      document.getElementById("AdK").innerText = AdK;
      $("#LastRead").text(
        OSX.LotNo + " - " + OSX.PRODUCT_NAME + " - " + OSX.Agirlik + "Kg."
      );
      document.getElementById("LastRead").setAttribute("class", "text-success");
    } else {
      var QueryString =
        "SELECT * FROM ( SELECT SUM(SR.STOCK_IN-SR.STOCK_OUT) AS SSSR,SR.PRODUCT_ID,SR.STOCK_ID,S.PRODUCT_NAME,SR.STORE,SR.STORE_LOCATION ,SR.PBS_RELATION_ID,SL.COMMENT FROM w3Toruntex_2023_1.STOCKS_ROW AS SR";
      QueryString +=
        " INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SR.STORE_LOCATION AND SL.DEPARTMENT_ID=SR.STORE  INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID WHERE LOT_NO='" +
        LotNo +
        "' GROUP BY SR.PRODUCT_ID,SR.STORE,SR.STORE_LOCATION ,SR.PBS_RELATION_ID,SL.COMMENT,SR.STOCK_ID,S.PRODUCT_NAME ) AS TTTS WHERE SSSR<>0";
      var Res2 = wrk_query(QueryString, "dsn2");
      alert("Bu Lot Numarası Daha Önce Okutulmuş");

      $("#LastRead").text(
        OSX.LotNo + " - " + Res2.PRODUCT_NAME[0] + " - " + OSX.Agirlik + "Kg."
      );
      document.getElementById("LastRead").setAttribute("class", "text-danger");
    }
    $("#BARKOD").val("");
    $("#BARKOD").focus();
    /*
    <span class="input-group-text" ><span id="AdS"></span>KG</span> 
    <span class="input-group-text" ><span id="AdK"></span>Ad</span>*/
  }
}
//BILGI URUN ID'SI VERİLEN SATIRI BULMAK İÇİN KULLANILIR
document.getElementByProductId = function (idb) {
  var str = idb.toString();
  var el = $("*").find("* [data-product_id='" + str + "']")[0];
  return el;
};

function OkumaEkle(AMOUNT, AMOUNT2, LOT_NO, SEPET_ROW_ID) {
  var str =
    "INSERT INTO SEVKIYAT_SEPET_ROW_READ_PBS (SEPET_ROW_ID,LOT_NO,AMOUNT,AMOUNT2) VALUES (" +
    SEPET_ROW_ID +
    ",'" +
    LOT_NO +
    "'," +
    AMOUNT +
    "," +
    AMOUNT2 +
    ")";
  var QueryResult = GetAjaxQuery(str, "dsn3");
  console.log(QueryResult);
  if (QueryResult.RECORDCOUNT > 0) {
    return QueryResult.RESULT.GENERATEDKEY;
  } else {
    return false;
  }
}
//BILGI SEPETE EKLEMEK İÇİN INSERT SORGUSU SEPET_ROW_ID DONER
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
  var QueryResult = GetAjaxQuery(str, "dsn3");
  if (QueryResult.RECORDCOUNT > 0) {
    return QueryResult.RESULT.GENERATEDKEY;
  } else {
    return false;
  }
}
//BILGI YALNIZCA HTML OLARAK SATIR EKLER
function SatirEkle(PRODUCT_ID, PRODUCT_NAME, AMOUNT, SEPET_ROW_ID) {
  var tr = document.createElement("tr");
  tr.setAttribute("class", "bg-danger");
  tr.setAttribute("data-fromSiparis", 0);
  var td = document.createElement("td");

  td.innerText = AMOUNT + "/" + "0";
  td.setAttribute("id", "AMOUNT_" + PRODUCT_ID);
  tr.appendChild(td);
  var td = document.createElement("td");
  td.setAttribute("id", "AMOUNT2_" + PRODUCT_ID);
  td.innerText = 1 + "/" + 0;
  tr.appendChild(td);
  var td = document.createElement("td");
  td.setAttribute("id", "PRODUCT_NAME_" + PRODUCT_ID);
  td.innerText = PRODUCT_NAME;
  tr.appendChild(td);
  tr.setAttribute("data-product_id", PRODUCT_ID);
  tr.setAttribute("data-SEPET_ROW_ID", SEPET_ROW_ID);
  document.getElementById("Sepetim").appendChild(tr);
}
//BILGI VAR OLAN SATIRI GUNCELLER
//DIKKAT BU METOD OKUMDA DA KAYIT ETTIGINDEN YANLIŞ OLMAMASI İÇİN DAHA ÖNCESİNDE OKUMA KAYIT ETMEDİĞİNE EMİN OL
//UYARI SATIR DEĞERLERİ HTML OLARAK GÜNCELLENİR VERİ SUNUCUDAN DEĞİL CLİENT TARAFINDAKİ VERİDİR
//TESTET SUNUCU CLIENT VERI KARŞILAŞTIRMASINI YAP
function SatirGuncelle(PRODUCT_ID, ARGA_AMOUNT, LotNo) {
  var AMOUNT_ = document.getElementById("AMOUNT_" + PRODUCT_ID).innerText;
  var TOTAL_1 = list_getat(AMOUNT_, 2, "/").trim();
  var AMOUNT__ = list_getat(AMOUNT_, 1, "/").trim();
  var AMOUNT = parseFloat(AMOUNT__);

  var AMOUNT2_ = document.getElementById("AMOUNT2_" + PRODUCT_ID).innerText;
  var TOTAL_2 = list_getat(AMOUNT2_, 2, "/").trim();
  var AMOUNT2__ = list_getat(AMOUNT2_, 1, "/").trim();
  var AMOUNT2 = parseFloat(AMOUNT2__);
  var SEPET_ROW_ID = document
    .getElementByProductId(PRODUCT_ID)
    .getAttribute("data-SEPET_ROW_ID");
  var str_1 = (AMOUNT + parseFloat(ARGA_AMOUNT)).toString() + "/" + TOTAL_1;
  document.getElementById("AMOUNT_" + PRODUCT_ID).innerText = str_1;
  var str_2 = (AMOUNT2 + 1).toString() + "/" + TOTAL_2;
  document.getElementById("AMOUNT2_" + PRODUCT_ID).innerText = str_2;
  var AMOUNT2_ = document.getElementById("AMOUNT2_" + PRODUCT_ID).innerText;
  var TOTAL_2 = list_getat(AMOUNT2_, 2, "/").trim();
  var AMOUNT2__ = list_getat(AMOUNT2_, 1, "/").trim();
  var AMOUNT2 = parseFloat(AMOUNT2__);
  var toplam = parseFloat(TOTAL_2);
  var isFromSip = parseInt(
    document
      .getElementById("ROW_" + PRODUCT_ID)
      .getAttribute("data-fromSiparis")
  );
  if (isFromSip == 1) {
    if (AMOUNT2 > toplam) {
      document
        .getElementById("ROW_" + PRODUCT_ID)
        .setAttribute("class", "bg-primary");
    } else if (AMOUNT2 == toplam) {
      document
        .getElementById("ROW_" + PRODUCT_ID)
        .setAttribute("class", "bg-success");
    }
  } else {
    document
      .getElementById("ROW_" + PRODUCT_ID)
      .setAttribute("class", "bg-danger");
  }
  OkumaEkle(ARGA_AMOUNT, 1, LotNo, SEPET_ROW_ID);
}
//BILGI PBS JS QUERY
//DIKKAT BÜTÜN METODLAR SERBEST 'INSERT,UPDATE,DELETE,EXEC,TRUNCATE GIBI GIBI'
function GetAjaxQuery(str_query, data_source, maxrows) {
  var CompanyInfo = new Object();
  var url =
    "/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=query_executer&isAjax=1";
  var myAjaxConnector = GetAjaxConnector();
  if (myAjaxConnector) {
    data =
      "str_sql=" +
      encodeURIComponent(str_query) +
      "&data_source=" +
      data_source +
      "&maxrows=" +
      maxrows;
    myAjaxConnector.open("post", url + "&xmlhttp=1", false);
    myAjaxConnector.setRequestHeader(
      "If-Modified-Since",
      "Sat, 1 Jan 2000 00:00:00 GMT"
    );
    myAjaxConnector.setRequestHeader("pragma", "nocache");
    myAjaxConnector.setRequestHeader(
      "Content-Type",
      "application/x-www-form-urlencoded; charset=utf-8"
    );
    myAjaxConnector.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    myAjaxConnector.send(data);
    if (myAjaxConnector.readyState == 4 && myAjaxConnector.status == 200) {
      try {
        CompanyInfo = eval(
          myAjaxConnector.responseText.replace(/\u200B/g, "")
        )[0];
      } catch (e) {
        CompanyInfo = false;
      }
    }
  }
  return CompanyInfo;
}
function SevkiyatKapa(el, IID) {
  var str =
    "UPDATE w3Toruntex_1.SEVKIYAT_SEPET_PBS set IS_CLOSED=1 ^ISNULL(IS_CLOSED,0) WHERE SEPET_ID=" +
    IID;
  var res = GetAjaxQuery(str, "dsn3");
  console.log(res);
  if (el.getAttribute("data-status") == "1") {
    el.setAttribute("data-status", "0");
    el.setAttribute("class", "form-control btn btn-warning");
    el.innerText = "Sevkiyat Açık";
    document.getElementById("BARKOD").removeAttribute("disabled");
    $("#BARKOD").focus();
  } else {
    el.setAttribute("data-status", "1");
    el.setAttribute("class", "form-control btn btn-danger");
    el.innerText = "Sevkiyat Kilitli";
    document.getElementById("BARKOD").setAttribute("disabled", "true");
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
function EksiislemYap(el,ev){
  if(ev.keyCode==13){
    var UrunBarkodu = el.value;
    UrunBarkodu = ReplaceAll(UrunBarkodu, "||", "|");
    var UrunKodu = list_getat(UrunBarkodu, 1, "|");
    var LotNo = list_getat(UrunBarkodu, 2, "|");
    var Agirlik = list_getat(UrunBarkodu, 3, "|");
    var SEPET_ID = document.getElementById("SEPET_ID").value;
    //var Lot_No="11976001082"
//var SepetId=1;
//var User_ID=12;
var Res=wrk_query("SELECT SRR.LOT_NO,SRR.SEPET_ROW_ID,SRR.AMOUNT,SSR.PRODUCT_ID,S.PRODUCT_NAME FROM SEVKIYAT_SEPET_ROW_READ_PBS AS SRR INNER JOIN SEVKIYAT_SEPET_ROW_PBS AS  SSR ON SSR.SEPET_ROW_ID=SRR.SEPET_ROW_ID INNER JOIN STOCKS AS S ON S.PRODUCT_ID=SSR.PRODUCT_ID  WHERE SRR.LOT_NO='"+LotNo+"' AND SSR.SEPET_ID="+SEPET_ID,"DSN3");
if(Res.recordcount>0){
	var Str1="INSERT INTO w3Toruntex_1.SEVKIYAT_SEPET_CIKAN (LOT_NO,SEPET_ROW_ID,AMOUNT,SEPET_ID,PRODUCT_ID,RECORD_EMP,RECORD_DATE) VALUES ('"+LotNo+"',"+Res.SEPET_ROW_ID[0]+","+Res.AMOUNT[0]+","+SEPET_ID+","+Res.PRODUCT_ID[0]+","+UserId+",GETDATE())"
	var Str2=	"DELETE FROM SEVKIYAT_SEPET_ROW_READ_PBS WHERE LOT_NO='"+LotNo+"'";
  GetAjaxQuery(Str1,"DSN3")
  GetAjaxQuery(Str2,"DSN3")
  window.location.reload();
}else{
alert(LotNo+" Lot Numaralı Ürün Bulunamadı")
}
  }
  
}