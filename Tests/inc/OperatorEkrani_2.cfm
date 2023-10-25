<div class="row">
    <div class="col col-9">
        <cf_seperator id="getP2" header="Duyurukar"  style="display:none;">
            <div id="getP2"  style="display:none;">
                <ul>
                    <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</li>
                    <li>Nunc mollis mauris nec laoreet consequat.</li>
                    <li>Donec porttitor magna in odio condimentum, vel efficitur lacus sodales.</li>
                </ul>
            </div>
    </div>
    <div class="col col-3">
        <table style="width: 100%;">
            <tbody>
                <tr>
                    <td style="text-align: center;">
                        <button type="button" class="btn btn-lg btn-outline-secondary" onclick="ShowStations()">KLB</button>                        
                    </td>
                    <td style="text-align: center;">                        
                        <button type="button" class="btn btn-lg btn-outline-primary" onclick="OpenLogIn()">Kullanıcı Girişi</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <div class="col col-12">                
        <cf_grid_list style="width:100%">
            <tr>
                <td id="Location">KLB</td>
                <td id="Complate">%80</td>
                <td id="Customer">Emre Cooop</td>
                <td id="Country">Türkiye</td>
                <td id="Color">
                    <div style="display: flex;">
                        <span style="width: 50%;display: block;">Şeffaf-Kırmızı</span> 
                        <span id="color1" style="display:block;border: solid 0.5px black;background: none;width: 25%;">&nbsp;&nbsp;&nbsp;</span> 
                        <span id="color1" style="display:block;border: solid 0.5px black;background: red;width: 25%;">&nbsp;&nbsp;&nbsp;</span>
                    </div>
                </td>
            </tr>
        </cf_grid_list>
    </div>
</div>
<div class="row">
    <div class="col col-3">
        
    <div class="form-group">
        <label>Ürün</label>
        <select class="form-control form-select sel" id="select_1" placeholder="Ürün Seçiniz" aria-label="Default select example">
            
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
          </select>
        </div>
        <div class="form-group">
            <label>Sipariş</label>
          <select class="form-control form-select sel" id="select_2" placeholder="Sipariş Seçiniz" aria-label="Default select example">
            
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
          </select>
        </div>
    </div>

<div class="col-6">
    <div class="form-group">
        <label>Paket İçerik</label>
        <input type="text" class="form-control" readonly="" id="paketIcerik">
    </div>
    <div class="form-group">
        <label>Paket KG</label>
        <input type="text" class="form-control" id="paketKG">
    </div>
    <hr>
    <div class="row">
        <div class="col col-3"></div>
        <div class="col col-6">
            <input type="text" class="form-control" id="TxResult" style="text-align: right;font-size: 25pt;">
            <table class="table table-bordered" style="font-size: 14pt;width: 100%;">
                <tbody>
                    <tr>
                        <td onclick="Yaz(9)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">9</td>
                        <td onclick="Yaz(8)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">8</td>
                        <td onclick="Yaz(7)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">7</td>
                        <td onclick="Yaz(-1)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">◄</td>
                    </tr>
                    <tr>
                        <td onclick="Yaz(4)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">4</td>
                        <td onclick="Yaz(5)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">5</td>
                        <td onclick="Yaz(6)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">6</td>
                        <td onclick="Yaz(-2)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">C</td>
                    </tr>
                    <tr>
                        <td onclick="Yaz(1)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">1</td>
                        <td onclick="Yaz(2)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">2</td>
                        <td onclick="Yaz(3)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">3</td>
                        <td onclick="Yaz(-3)" class="bg-danger text-white" style="font-size: 30pt;width: 25%;text-align: center;">X</td>
                    </tr>
                    <tr>
                        <td onclick="Yaz(0)" class="bg-dark text-white" colspan="2" style="font-size: 30pt;width: 50%;text-align: center;">0</td>            
                        <td onclick="Yaz(-4)" class="bg-dark text-white" style="font-size: 30pt;width: 25%;text-align: center;">,</td>
                        <td onclick="Yaz(-5)" class="bg-success text-white" style="font-size: 30pt;width: 25%;text-align: center;">&#x2713;</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col col-3"></div>
    </div>
</div>
    <div class="col col-3">
        <div style="height:30vh;overflow-y: scroll;" id="OrderData">
            <table class="table table-striped table-lg tableFixHead">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">First</th>
                    <th scope="col">Last</th>
                    <th scope="col">Handle</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                  </tr>
                </tbody>
              </table>
        </div>
    </div>
</div>
<div class="row">
    <div class="col col-12">

    </div>
</div>

<script>
    $(document).ready(function(){
    document.getElementById("wrk_main_layout").setAttribute("class","container-fluid");
    $(".sel").selectize();
})
function OpenLogIn() {
    openBoxDraggable('index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=10');
}

function wrk_query(str_query,data_source,maxrows)
{
	var new_query=new Object();
	var req;
	if(!data_source) data_source='dsn';
	if(!maxrows) maxrows=0;
	function callpage(url) {
		req = false;
		if(window.XMLHttpRequest)
			try
				{req = new XMLHttpRequest();}
			catch(e)
				{req = false;}
		else if(window.ActiveXObject)
			try {
				req = new ActiveXObject("Msxml2.XMLHTTP");
				}
			catch(e)
				{
				try {req = new ActiveXObject("Microsoft.XMLHTTP");}
				catch(e)
					{req = false;}
				}
		if(req)
			{
				function return_function_()
				{

				if (req.readyState == 4 && req.status == 200)
					try
						{
							eval(req.responseText.replace(/\u200B/g,''));
							new_query = get_js_query; //alert('Cevap:\n\n'+req.responseText);//
						}
					catch(e)
						{new_query = false;}
				}
			req.open("post", url+'&xmlhttp=1', false);
			req.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			req.setRequestHeader('pragma','nocache');
			if(encodeURI(str_query).indexOf('+') == -1) // + isareti encodeURI fonksiyonundan gecmedigi icin encodeURIComponent fonksiyonunu kullaniyoruz. EY 20120125
				req.send('str_sql='+encodeURI(str_query)+'&data_source='+data_source+'&maxrows='+maxrows);
			else
				req.send('str_sql='+encodeURIComponent(str_query)+'&data_source='+data_source+'&maxrows='+maxrows);
			return_function_();
			}
		
	}
	
	//TolgaS 20070124 objects yetkisi olmayan partnerlar var diye fuseaction objects2 yapildi
	callpage('/index.cfm?fuseaction=objects2.emptypopup_get_js_query&isAjax=1');
	//alert(new_query);
	
	return new_query;
}
function Yaz(sayi){
    if(sayi>0){
        TxResult.value+=sayi
    }else if(sayi<0){
        if(sayi==-1) TxResult.value =TxResult.value.substr(0, TxResult.value.length-1);
        if(sayi==-2) TxResult.value ="";
        if(sayi==-3) TxResult.value ="";
        if(sayi==-4) TxResult.value ="";
        if(sayi==-5) TxResult.value +=",";
    }
}
</script>
<script src="/JS/sselec/selectize/dist/js/standalone/selectize.js"></script>
<link rel="stylesheet" href="/JS/sselec/selectize/dist/css/selectize.bootstrap5.css">