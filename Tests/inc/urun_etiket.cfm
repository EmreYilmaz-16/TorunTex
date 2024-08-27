
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ürün Kartı</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous">
</script>


<cfparam name="form.masa_param" default="">
<cfparam name="form.detay_param" default="">




<cftry>
    <cfquery name="masa_getir" datasource="#dsn#">
    select DISTINCT(MASA) AS MASA from dbo.PRODUCTION_DAY_ALL ORDER BY MASA
        <!---select * from w3toruntex_product.product where IS_INVENTORY=1 AND PRODUCT_STATUS=1--->
    </cfquery>
    <cfcatch type="Database">
    <cfset errorMessage = "Database error: #cfcatch.message#">
    <cfoutput>#errorMessage#</cfoutput>
    </cfcatch>
</cftry>

<cftry>
    <cfquery name="urunleri_getir" datasource="#dsn#">
    SELECT        
P.PRODUCT_NAME, PC.PRODUCT_CAT, PIP.PROPERTY4 AS MASA, P.PRODUCT_DETAIL

FROM            
                     w3Toruntex_PRODUCT.PRODUCT P   LEFT JOIN
                     w3Toruntex_PRODUCT.product_cat PC ON PC.PRODUCT_CATID = P.PRODUCT_CATID LEFT JOIN
                     w3Toruntex_1.PRODUCT_INFO_PLUS PIP ON PIP.PRODUCT_ID = P.PRODUCT_ID 
                     WHERE 1 = 1
        <cfif form.masa_param neq "">
            AND MASA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.masa_param#">
        </cfif>
        <cfif form.detay_param neq "">
            AND PRODUCT_DETAIL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.detay_param#">
        </cfif>
        ORDER BY PRODUCT_NAME


<!---          SELECT DISTINCT(PRODUCT) as PRODUCT_NAME, PRODUCT_CAT, MASA, PRODUCT_DETAIL 
        FROM dbo.PRODUCTION_DAY_ALL
        WHERE 1 = 1
        <cfif form.masa_param neq "">
            AND MASA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.masa_param#">
        </cfif>
        <cfif form.detay_param neq "">
            AND PRODUCT_DETAIL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.detay_param#">
        </cfif>
        ORDER BY PRODUCT_NAME --->
    </cfquery>
<cfcatch type="Database">
<cfset errorMessage = "Database error: #cfcatch.message#">
<cfoutput>#errorMessage#</cfoutput>
</cfcatch>
</cftry>

<div class="row">

<div class="container mt-5">
    <div class="col-md-6">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Ürün Kartı Yazdırma Ekranı</h4>
                <div class="form-group">


                    <SELECT class="form-control form-select" name="masa_listesi" id="masa_listesi" onchange="updateMasaListesi()">
                        <option value="">Seçiniz</option>
                        <cfoutput query="masa_getir">
                            <option value="#MASA#">#MASA#</option>
                        </cfoutput>
                    </SELECT><br>

                    <SELECT class="form-control form-select" name="urun_listesi" id="urun_listesi" onchange="updateUrunListesi()">
                        <option value="">Seçiniz</option>
                        <cfoutput query="urunleri_getir">
                            <option value="#PRODUCT_NAME#">#PRODUCT_NAME# - #PRODUCT_DETAIL#</option>
                        </cfoutput>
                    </SELECT>
                <br>



                <input type="text" id="urun_detay" value=""> 
                <br><br>
                <input type="number" id="quantity" name="quantity" min="1" max="500" step="1" value="1">

                </div><br>
                <button class="btn btn-primary mt-2" id="yazdir" onclick="print()">Yazdır</button>
                <p></p>
                <br>


                <p id="demo"></p>
             


            </div>
        </div>



    </div>



</div>

</div>

<input type="hidden" id="masa_param" value="#masa_param#"> 
<input type="hidden" id="detay_param" value="#detay_param#"> 




<script>



function updateSelectedValue() {
    var product_name = document.getElementById("urun_listesi").value;
    document.getElementById("demo").innerHTML = product_name;
}


function updateUrunListesi() {
    var selectedOption2 = document.getElementById("urun_listesi").value;
    var urun_detay = document.getElementById("urun_detay");



    // Masa seçim kutusundan seçilen değere göre ürün listesini güncelle
    if (selectedOption2 !== '') {
        var filteredUrunler2 = [];
        <cfoutput query="urunleri_getir">
            if ("#PRODUCT_NAME#" === selectedOption2) {
                filteredUrunler2.push("#PRODUCT_DETAIL#");
            }
        </cfoutput>

        // Filtrelenmiş ürün listesini ekle
        filteredUrunler2.forEach(function(detay) {
            var option = document.createElement("option");
            option.text = detay;
            option.value = detay;
            urun_detay.value=detay;
        });
    }

}

// Seçim yapıldığında çalışacak JavaScript fonksiyonu
function updateMasaListesi() {
    var selectedOption = document.getElementById("masa_listesi").value;
    var urunListesi = document.getElementById("urun_listesi");

    // Urun seçim kutusunu temizle
    while (urunListesi.options.length > 1) {
        urunListesi.remove(1);
    }

    // Masa seçim kutusundan seçilen değere göre ürün listesini güncelle
    if (selectedOption !== '') {
        var filteredUrunler = [];
        <cfoutput query="urunleri_getir">
            if ("#MASA#" === selectedOption) {
                filteredUrunler.push("#PRODUCT_NAME#");
            }
        </cfoutput>

        // Filtrelenmiş ürün listesini ekle
        filteredUrunler.forEach(function(urun) {
            var option = document.createElement("option");
            option.text = urun;
            option.value = urun;
            urunListesi.add(option);
        });
    }

}


function print()
{
  var ip_addr = "192.168.0.64";
  var masa = document.getElementById("masa_listesi").value;
  var qr_code = document.getElementById("urun_listesi").value;
  var product_name = document.getElementById("urun_listesi").value;// var product_name = "KASHMIR-80";
  var product_note = document.getElementById("urun_detay").value;quantity
  var print_count = document.getElementById("quantity").value;


  var zpl = "^XA^XFE:kart.ZPL^FS"
  + "^CI28^FN1^FH\^FD" + masa + "^FS^CI27^"
  + "CI28^FN2^FH\^FD" + qr_code + "^FS^CI27" 
  + "^CI28^FN3^FH\^FD" + product_name + "^FS^CI27"
  + "^CI28^FN4^FH\^FD" + product_note + "^FS^CI27"
  + "^CI28^FN5^FH\^FD^FS^CI27"
  + "^CI28^FN6^FH\^FD^FS^CI27"
  + "^CI28^FN7^FH\^FD^FS^CI27"
  + "^CI28^FN8^FH\^FD^FS^CI27"
  + "^PQ" + print_count + ",0,1^XZ";
  var url = "http://"+ip_addr+"/pstprnt";
  var method = "POST";
  var async = true;
  var request = new XMLHttpRequest();

  request.onload = function () {
    var status = request.status; 
    var data = request.responseText; 
    output.innerHTML = "Status: " + status + "<br>" + data;
  }

  request.open(method, url, async);
  request.setRequestHeader("Content-Length", zpl.length);

  
  request.send(zpl);
}  
</script>

<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>



    