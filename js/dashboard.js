var ctx = document.getElementById("CompanyTotalSales");
var ctx2 = document.getElementById("DailyTotalSales");
var ctx3 = document.getElementById("ProductCatTotalSales");
var ctx4 = document.getElementById("CountryTotalSales");
var ctx5 = document.getElementById("CompanySalesPerctange");
var ctx6 = document.getElementById("CountrySalesPerctange");

var CompanyTotalSales = "";
var DailyTotalSales = "";
var ProductCatTotalSales = "";
var CountryTotalSales = "";
var CompanySalesPerctange="";
var CountrySalesPerctange="";
$(document).ready(function () {
  document
    .getElementById("wrk_main_layout")
    .setAttribute("class", "container-fluid");
    CreateCharts();
});

function LoadDefault() {
  var Vq = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE GROUP BY NICKNAME,COMPANY_ID ORDER BY AMOUNT"
  );
  var Vq2 = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,GUN FROM MY_TEMP_TABLE WHERE YIL=2024 AND AY=1 GROUP BY GUN ORDER BY GUN"
  );
  var Vq3 = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,PRODUCT_CAT FROM MY_TEMP_TABLE GROUP BY PRODUCT_CAT ORDER BY AMOUNT "
  );
  var Vq4 = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,COUNTRY_NAME FROM MY_TEMP_TABLE GROUP BY COUNTRY_NAME ORDER BY AMOUNT "
  );
  var Vq5=wrk_query("WITH CTE1 AS(SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE GROUP BY NICKNAME,COMPANY_ID ),CTE2 AS (SELECT CTE1.*,(SELECT SUM(AMOUNT) FROM CTE1) AS TOPLAM_MIKTAR FROM CTE1) SELECT CTE2.*,CONVERT(DECIMAL(18,2),(AMOUNT*100)/CTE2.TOPLAM_MIKTAR) AS YUZDE FROM CTE2")
  
  var Vq6=wrk_query("WITH CTE1 AS(SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,COUNTRY_NAME FROM MY_TEMP_TABLE GROUP BY COUNTRY_NAME ),CTE2 AS (SELECT CTE1.*,(SELECT SUM(AMOUNT) FROM CTE1) AS TOPLAM_MIKTAR FROM CTE1) SELECT CTE2.*,CONVERT(DECIMAL(18,2),(AMOUNT*100)/CTE2.TOPLAM_MIKTAR) AS YUZDE FROM CTE2")
  //
  var Gunler = [];
  var Miktarlar = [];
  var Fiyatlar = [];
  for (let i = 0; i < 31; i++) {
    var Gun = Vq2.GUN.findIndex((p) => p == i);
    var O = new Object();
    if (Gun == -1) {
      Gunler.push(i);
      Miktarlar.push(0);
      Fiyatlar.push(0);
    } else {
      Gunler.push(i);
      Miktarlar.push(parseFloat(Vq2.AMOUNT[Gun]));
      Fiyatlar.push(parseFloat(Vq2.T[Gun]));
    }
  }
  DailyTotalSales.data.datasets[0].data = Miktarlar;
  DailyTotalSales.data.datasets[1].data = Fiyatlar;
  DailyTotalSales.data.labels = Gunler;
  DailyTotalSales.update();

  CompanyTotalSales.data.datasets[0].data = Vq.AMOUNT;
  CompanyTotalSales.data.datasets[1].data = Vq.T;
  CompanyTotalSales.data.labels = Vq.NICKNAME;
  CompanyTotalSales.update();

  ProductCatTotalSales.data.datasets[0].data = Vq3.AMOUNT;
  ProductCatTotalSales.data.datasets[1].data = Vq3.T;
  ProductCatTotalSales.data.labels = Vq3.PRODUCT_CAT;
  ProductCatTotalSales.update();

  CountryTotalSales.data.datasets[0].data = Vq4.AMOUNT;
  CountryTotalSales.data.datasets[1].data = Vq4.T;
  CountryTotalSales.data.labels = Vq4.COUNTRY_NAME;
  CountryTotalSales.update();
}
function CreateCharts() {
  var Vq = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE GROUP BY NICKNAME,COMPANY_ID ORDER BY AMOUNT"
  );
  var Vq2 = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,GUN FROM MY_TEMP_TABLE WHERE YIL=2024 AND AY=1 GROUP BY GUN ORDER BY GUN"
  );
  var Vq3 = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,PRODUCT_CAT FROM MY_TEMP_TABLE GROUP BY PRODUCT_CAT ORDER BY AMOUNT "
  );
  var Vq4 = wrk_query(
    "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,COUNTRY_NAME FROM MY_TEMP_TABLE GROUP BY COUNTRY_NAME ORDER BY AMOUNT "
  );
  var Vq5=wrk_query("WITH CTE1 AS(SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE GROUP BY NICKNAME,COMPANY_ID ),CTE2 AS (SELECT CTE1.*,(SELECT SUM(AMOUNT) FROM CTE1) AS TOPLAM_MIKTAR FROM CTE1) SELECT CTE2.*,CONVERT(DECIMAL(18,2),(AMOUNT*100)/CTE2.TOPLAM_MIKTAR) AS YUZDE FROM CTE2")
  
  var Vq6=wrk_query("WITH CTE1 AS(SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,COUNTRY_NAME FROM MY_TEMP_TABLE GROUP BY COUNTRY_NAME ),CTE2 AS (SELECT CTE1.*,(SELECT SUM(AMOUNT) FROM CTE1) AS TOPLAM_MIKTAR FROM CTE1) SELECT CTE2.*,CONVERT(DECIMAL(18,2),(AMOUNT*100)/CTE2.TOPLAM_MIKTAR) AS YUZDE FROM CTE2")
  //
  var Gunler = [];
  var Miktarlar = [];
  var Fiyatlar = [];
  for (let i = 0; i < 31; i++) {
    var Gun = Vq2.GUN.findIndex((p) => p == i);
    var O = new Object();
    if (Gun == -1) {
      Gunler.push(i);
      Miktarlar.push(0);
      Fiyatlar.push(0);
    } else {
      Gunler.push(i);
      Miktarlar.push(parseFloat(Vq2.AMOUNT[Gun]));
      Fiyatlar.push(parseFloat(Vq2.T[Gun]));
    }
  }
  console.table(Gunler);
  console.table(Miktarlar);
  console.table(Fiyatlar);
  console.log(Vq);

  CompanyTotalSales = new Chart(ctx, {
    type: "bar",
    data: {
      labels: Vq.NICKNAME,
      datasets: [
        {
          label: "Toplam Satış Miktarı",
          data: Vq.AMOUNT,
          borderWidth: 1,
        },
        {
          label: "Toplam Satış Tutarı",
          data: Vq.T,
          borderWidth: 1,
        },
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      plugins: {
        title: {
          display: true,
          text: "Müşteri Satışları",
          padding: {
            top: 10,
            bottom: 30,
          },
        },
      },
    },
  });

  DailyTotalSales = new Chart(ctx2, {
    type: "bar",
    data: {
      labels: Gunler,
      datasets: [
        {
          label: "Toplam Satış Miktarı",
          data: Miktarlar,
          borderWidth: 1,
        },
        {
          label: "Toplam Satış Tutarı",
          data: Fiyatlar,
          borderWidth: 1,
        },
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      plugins: {
        title: {
          display: true,
          text: "Günlük Satışları",
          padding: {
            top: 10,
            bottom: 30,
          },
        },
      },
    },
  });
  //CountryTotalSales

  ProductCatTotalSales = new Chart(ctx3, {
    type: "bar",
    data: {
      labels: Vq3.PRODUCT_CAT,
      datasets: [
        {
          label: "Toplam Satış Miktarı",
          data: Vq3.AMOUNT,
          borderWidth: 1,
        },
        {
          label: "Toplam Satış Tutarı",
          data: Vq3.T,
          borderWidth: 1,
        },
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      plugins: {
        title: {
          display: true,
          text: "Ürün Kategori Satışları",
          padding: {
            top: 10,
            bottom: 30,
          },
        },
      },
    },
  });

  CountryTotalSales = new Chart(ctx4, {
    type: "bar",
    data: {
      labels: Vq4.COUNTRY_NAME,
      datasets: [
        {
          label: "Toplam Satış Miktarı",
          data: Vq4.AMOUNT,
          borderWidth: 1,
        },
        {
          label: "Toplam Satış Tutarı",
          data: Vq4.T,
          borderWidth: 1,
        },
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      plugins: {
        title: {
          display: true,
          text: "Ülkeye Göre Satışları",
          padding: {
            top: 10,
            bottom: 30,
          },
        },
      },
    },
  });
  CompanySalesPerctange = new Chart(ctx5, {
    type: "pie",
    data: {
      labels: Vq5.NICKNAME,
      datasets: [
        {
          label: "Toplam Satış %",
          data: Vq5.YUZDE,
          borderWidth: 1,
        }
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      plugins: {
        title: {
          display: true,
          text: "Müşteri Satış Yüzdeleri",
          padding: {
            top: 10,
            bottom: 30,
          },
        },
      },
    },
  });
  CountrySalesPerctange = new Chart(ctx6, {
    type: "pie",
    data: {
      labels: Vq6.COUNTRY_NAME,
      datasets: [
        {
          label: "Toplam Satış %",
          data: Vq6.YUZDE,
          borderWidth: 1,
        }
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
      plugins: {
        title: {
          display: true,
          text: "Ülke Satış Yüzdeleri",
          padding: {
            top: 10,
            bottom: 30,
          },
        },
      },
    },
  });
  //CountrySalesPerctange
}
function getDataWithCompany(company) {
  var COMPANY_ID = company.value;
  var sl = company.selectedIndex;
  var cname = [company.options[sl].innerText];

  if (COMPANY_ID.length > 0) {
    var Vq = wrk_query(
      "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE WHERE COMPANY_ID=" +
        COMPANY_ID +
        " GROUP BY NICKNAME,COMPANY_ID ORDER BY AMOUNT"
    );
    var Vq2 = wrk_query(
      "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,GUN FROM MY_TEMP_TABLE WHERE YIL=2024 AND AY=1 AND COMPANY_ID=" +
        COMPANY_ID +
        " GROUP BY GUN ORDER BY GUN"
    );
    var Vq3 = wrk_query(
      "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,PRODUCT_CAT FROM MY_TEMP_TABLE WHERE COMPANY_ID=" +
        COMPANY_ID +
        " GROUP BY PRODUCT_CAT ORDER BY AMOUNT "
    );
    var Vq4 = wrk_query(
      "SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,COUNTRY_NAME FROM MY_TEMP_TABLE WHERE COMPANY_ID=" +
        COMPANY_ID +
        " GROUP BY COUNTRY_NAME ORDER BY AMOUNT "
    );

    var Vq5=wrk_query("WITH CTE1 AS(SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE GROUP BY NICKNAME,COMPANY_ID ),CTE2 AS (SELECT CTE1.*,(SELECT SUM(AMOUNT) FROM CTE1) AS TOPLAM_MIKTAR FROM CTE1) SELECT CTE2.*,CONVERT(DECIMAL(18,2),(AMOUNT*100)/CTE2.TOPLAM_MIKTAR) AS YUZDE,100-CONVERT(DECIMAL(18,2),(AMOUNT*100)/CTE2.TOPLAM_MIKTAR) AS YUZDE_A FROM CTE2 WHERE COMPANY_ID="+COMPANY_ID);
    var Gunler = [];
    var Miktarlar = [];
    var Fiyatlar = [];
    for (let i = 0; i < 31; i++) {
      var Gun = Vq2.GUN.findIndex((p) => p == i);
      var O = new Object();
      if (Gun == -1) {
        Gunler.push(i);
        Miktarlar.push(0);
        Fiyatlar.push(0);
      } else {
        Gunler.push(i);
        Miktarlar.push(parseFloat(Vq2.AMOUNT[Gun]));
        Fiyatlar.push(parseFloat(Vq2.T[Gun]));
      }
    }
    DailyTotalSales.data.datasets[0].data = Miktarlar;
    DailyTotalSales.data.datasets[1].data = Fiyatlar;
    DailyTotalSales.data.labels = Gunler;
    DailyTotalSales.update();

    CompanyTotalSales.data.datasets[0].data = Vq.AMOUNT;
    CompanyTotalSales.data.datasets[1].data = Vq.T;
    CompanyTotalSales.data.labels = cname;
    CompanyTotalSales.update();

    ProductCatTotalSales.data.datasets[0].data = Vq3.AMOUNT;
    ProductCatTotalSales.data.datasets[1].data = Vq3.T;
    ProductCatTotalSales.data.labels = Vq3.PRODUCT_CAT;
    ProductCatTotalSales.update();

    CountryTotalSales.data.datasets[0].data = Vq4.AMOUNT;
    CountryTotalSales.data.datasets[1].data = Vq4.T;
    CountryTotalSales.data.labels = Vq4.COUNTRY_NAME;
    CountryTotalSales.update();

    var CrData=[];
    CrData.push(Vq5.YUZDE)
    CrData.push(Vq5.YUZDE_A)
    var CnData=[];
    CnData.push(Vq5.NICKNAME)
    CnData.push("Diğerleri")
    CompanySalesPerctange.data.datasets[0].data =CrData;
    CompanySalesPerctange.data.labels =CnData;
    CompanySalesPerctange.update();
    /*
var CompanyTotalSales = "";
var DailyTotalSales = "";
var ProductCatTotalSales = "";
var CountryTotalSales = "";
var CompanySalesPerctange="";
var CountrySalesPerctange="";


*/
  } else {
    LoadDefault();
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
