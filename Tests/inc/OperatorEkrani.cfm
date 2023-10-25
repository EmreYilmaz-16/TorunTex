<style>
    .tableFixHead          { overflow: auto; height: 100px; }
    .tableFixHead thead th { position: sticky; top: 0; z-index: 1;background:whitesmoke; }
</style>
<link rel="stylesheet" href="/JS/selectize.js-master/dist/css/selectize.css">
<div class="row">
    <div class="col col-12"></div>
</div>
<div class="row">
    <div class="col col-3"></div>
    <div class="col col-6">
        <div class="row">
            <div class="col col-12">
                <cf_seperator id="getP2" header="Duyurukar"  style="display:none;">
                    <div id="getP2"  style="display:none;">
                        <ul>
                            <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</li>
                            <li>Nunc mollis mauris nec laoreet consequat.</li>
                            <li>Donec porttitor magna in odio condimentum, vel efficitur lacus sodales.</li>
                        </ul>
                    </div>
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
    </div>
    <div class="col col-3">
        <table style="width: 100%;">
            <tbody>
                <tr>
                    <td style="text-align: center;">
                        <button type="button" class="btn btn-lg btn-outline-secondary" onclick="ShowStations()">KLB</button>                        
                    </td>
                    <td style="text-align: center;">                        
                        <button type="button" class="btn btn-lg btn-outline-primary" onclick="LogIn()">Kullanıcı Girişi</button>
                    </td>
                </tr>
            </tbody>
        </table>
        <hr>
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

<script>
    $(document).ready(function(){
    document.getElementById("wrk_main_layout").setAttribute("class","container-fluid");
}
function wrk_query(str_query,data_source,maxrows)
{
	/*console.log(str_query);
	alert('Bu sayfada wrk_query kullanılmıştır. İlgili kontrolü ajax yapısına çeviriniz.');
	return false;
	*/
	/*
	by  Workcube
	Created 20060315
	Modified 20060324
	Usage:
		my_query = query('SELECT COL1,COL2 FROM TABLE1 WHERE COL2=1');
		veya
		my_query = query('SELECT COL1,COL2 FROM TABLE1 WHERE COL2=1','dsn2');
		veya
		my_query = query('SELECT COL1,COL2 FROM TABLE1 WHERE COL2=1 ORDER BY COL2 DESC','dsn2',1);
		ifadesi ile my_query degiskeni cfquery ile donen sonucun tamamen aynisi bir javascript query degeri alir
		data_source : optional , default olarak 'dsn' kullaniliyor
		maxrows : optional , default olarak 0 ataniyor, 0 olunca query sonucundaki tum kayitlar gelir
	*/
	
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
})
</script>
<script src="/JS/selectize.js-master/src/selectize.js"></script>
