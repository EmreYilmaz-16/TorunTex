<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div style="display:flex;flex-wrap: wrap;">
    <div style="width:50%">
        <canvas style="width:100%" id="CompanyTotalSales"></canvas>
    </div>
    <div style="width:50%">
        <canvas style="width:100%" id="DailyTotalSales"></canvas>
    </div>
    <div style="width:50%">
        <canvas style="width:100%" id="ProductCatTotalSales"></canvas>
    </div>
    <div style="width:50%">
        <canvas style="width:100%" id="CountryTotalSales"></canvas>
    </div>
</div>
<script>
    $(document).ready(function(){
        var Vq=wrk_query("SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE GROUP BY NICKNAME,COMPANY_ID ORDER BY AMOUNT")
        var Vq2=wrk_query("SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,GUN FROM MY_TEMP_TABLE WHERE YIL=2024 AND AY=1 GROUP BY GUN ORDER BY GUN")
        var Vq3=wrk_query("SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,PRODUCT_CAT FROM MY_TEMP_TABLE GROUP BY PRODUCT_CAT ORDER BY AMOUNT ")
        var Vq4=wrk_query("SELECT SUM(CONVERT(DECIMAL(18,2),AMOUNT))  AS AMOUNT ,CONVERT(DECIMAL(18,4),SUM(PRICE_OTHER*AMOUNT)) AS T,COUNTRY_NAME FROM MY_TEMP_TABLE GROUP BY COUNTRY_NAME ORDER BY AMOUNT ")
        //
        var Gunler=[];
        var Miktarlar=[];
        var Fiyatlar=[];
        for(let i=0;i<31;i++){
            var Gun=Vq2.GUN.findIndex(p=>p==i);
            var O=new Object();
            if(Gun==-1){
                Gunler.push(i);
                Miktarlar.push(0);
                Fiyatlar.push(0);
                                
            }else{
                Gunler.push(i);
                Miktarlar.push(parseFloat(Vq2.AMOUNT[Gun]));
                Fiyatlar.push(parseFloat(Vq2.T[Gun]));
            }
        }
        console.table(Gunler);
        console.table(Miktarlar);
        console.table(Fiyatlar);
       console.log(Vq);
       var ctx=document.getElementById("CompanyTotalSales");
        new Chart(ctx, {
					type: 'bar',
					data: {
						labels: Vq.NICKNAME,
						datasets: [{
							label: 'Toplam Satış Miktarı',
							data: Vq.AMOUNT,
							borderWidth: 1
						},
                        {
							label: 'Toplam Satış Tutarı',
							data: Vq.T,
							borderWidth: 1
						}
                    ]
					},
					options: {
						scales: {
							y: {
								beginAtZero: true
							}
						}
					}
				});
                var ctx2=document.getElementById("DailyTotalSales");
        new Chart(ctx2, {
					type: 'bar',
					data: {
						labels: Gunler,
						datasets: [{
							label: 'Toplam Satış Miktarı',
							data: Miktarlar,
							borderWidth: 1
						},
                        {
							label: 'Toplam Satış Tutarı',
							data: Fiyatlar,
							borderWidth: 1
						}
                    ]
					},
					options: {
						scales: {
							y: {
								beginAtZero: true
							}
						}
					}
				});
                //CountryTotalSales
                var ctx3=document.getElementById("ProductCatTotalSales");
        new Chart(ctx3, {
					type: 'bar',
					data: {
						labels: Vq3.PRODUCT_CAT,
						datasets: [{
							label: 'Toplam Satış Miktarı',
							data: Vq3.AMOUNT,
							borderWidth: 1
						},
                        {
							label: 'Toplam Satış Tutarı',
							data: Vq3.T,
							borderWidth: 1
						}
                    ]
					},
					options: {
						scales: {
							y: {
								beginAtZero: true
							}
						}
					}
				});
                var ctx4=document.getElementById("CountryTotalSales");
        new Chart(ctx4, {
					type: 'bar',
					data: {
						labels: Vq4.COUNTRY_NAME,
						datasets: [{
							label: 'Toplam Satış Miktarı',
							data: Vq4.AMOUNT,
							borderWidth: 1
						},
                        {
							label: 'Toplam Satış Tutarı',
							data: Vq4.T,
							borderWidth: 1
						}
                    ]
					},
					options: {
						scales: {
							y: {
								beginAtZero: true
							}
						}
					}
				});
    })


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

</script>