<style>
  :root {     
        --scroll-bar-color: #c5c5c5;
        --scroll-bar-bg-color: #f6f6f6;
    }
 #digerSiparisTbl>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {  
    FONT-SIZE: x-small;
}
#SiparisResultArea{
    scrollbar-width: thin;               
    overflow-y: scroll;   
    height:30vh;

}
.input-group {
    -ms-flex-wrap: nowrap !important;
     flex-wrap: nowrap !important; 
  
}
* {
        scrollbar-width: thin;
        scrollbar-color: var(--scroll-bar-color) var(--scroll-bar-bg-color);
    }

    /* Works on Chrome, Edge, and Safari */
    *::-webkit-scrollbar {
        width: 10px;
    }

    *::-webkit-scrollbar-track {
        background: var(--scroll-bar-bg-color);
    }

    *::-webkit-scrollbar-thumb {
        background-color: var(--scroll-bar-color);
        border-radius: 20px;
        border: 2px solid var(--scroll-bar-bg-color);
    }
</style>
<div class="row">
   
    <div class="col col-12" id="col_0002">
        <div style="position:absolute;height:100vh;left:0;background:white;z-index:9999;top:50px" class="col col-2" id="col_0001">
            <cf_box title="Duyurular">
                
                    <cf_big_list>
                        <thead>
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody  id="DuyuruArea">
    
                    </tbody>
                    </cf_big_list>
                
                <br>
                <div style="display:flex">
                    <span id="Sayfammm"></span>
                    <button class="btn btn-sm btn-primary" style="border-radius: 0.375rem !important;" id="eksiEl" onclick="GetDuyurus('all')">Tümünü Göster</button>
                  
                </div>
            </cf_box>
        </div>
<div class="row" >
    <div class="col col-10">
        <button class="btn btn-lg btn-link" onclick="$('#col_0001').toggle(500)" id="BtnORk">≡</button>
    </div>
    <div class="col col-2">
        <table style="width: 100%;">
            <tbody>
                <tr>   
                    <td>
                        <button class="btn btn-lg btn-outline-dark" id="Location">

                        </button>
                    </td>                 
                    <td style="text-align: center;" id="butonAre">             
                        
                        <!---<button type="button" class="btn btn-lg btn-outline-primary" onclick="OpenLogIn()">Kullanıcı Girişi</button>---->
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="row" >
    <div class="col col-12">                
        <cf_grid_list style="width:100%">
            <tr>
                <td style="font-size: 20px" id="OrderLocation"></td>
                <td style="font-size: 20px" id="Complate"></td>
                <td style="font-size: 20px" id="Customer"></td>
                <td style="font-size: 20px" id="Country"></td>
                <td style="font-size: 20px" id="Color">
                    <div style="display: flex;justify-content: space-between;">
                        <span style="font-size: 20px" id="RenkYazi" style="width: 50%;display: block;"></span> 
                        <span id="color1" style="display:block;border: solid 0.5px black;background: none;width: 25%;">&nbsp;&nbsp;&nbsp;</span> 
                        <span id="color2" style="display:block;border: solid 0.5px black;background: red;width: 25%;">&nbsp;&nbsp;&nbsp;</span>
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
                 
                <option value="">Ürün Seçiniz</option>
                   
                
            
            </select>
        </div>
<div id="SiparisDataArea">
    
</div>
        <div style="display:flex;flex-direction: column;">
            <button type="button" class="btn btn-lg btn-success" onclick="Yazdir()" style="margin-bottom: 5px;border-radius: 0.375rem !important;">Yazdir/Üret</button>
            <button type="button" class="btn btn-lg btn-danger" style="position: fixed;bottom: 0;right: 0;width: 300px;margin-bottom: 20px;margin-right: 20px;border-radius: 0.375rem !important;" onclick="Iptal()">İptal</button>
            <input type="hidden" name="WRK_ROW_ID" id="WRK_ROW_ID">
            <input type="hidden" name="LotNo" id="LotNo">
            <input type="hidden" name="SIP_DEPO" id="SIP_DEPO">
        </div>
<hr>
        <div  class="" style="height:25vh;overflow-y: scroll;padding:3px" id="DigerSiparis">
            
        </div>
</div>

<div class="col-6">
   <div style="display:flex;justify-content: space-between;">
    <div class="form-group" style="width:50%">
        <label>Paket İçerik</label>
        <input style="font-size:20pt" type="text" class="form-control" readonly="" id="paketIcerik">
    </div>
    <div class="form-group" style="width:50%">
        <label>Paket KG</label>
        <input style="font-size:20pt" type="text" class="form-control" id="paketKG">
    </div>
</div>
    <hr>
    <div class="row">
        <div class="col col-3"></div>
        <div class="col col-6">
            <input type="text" class="form-control" id="TxResult" value="0" style="text-align: right;font-size: 25pt;">
            <table class="table table-bordered" style="font-size: 14pt;width: 100%;">
                <tbody>
                    <tr>
                        <td onclick="Yaz(9)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">9</td>
                        <td onclick="Yaz(8)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">8</td>
                        <td onclick="Yaz(7)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">7</td>
                        <td onclick="Yaz(-1)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">◄</td>
                    </tr>
                    <tr>
                        <td onclick="Yaz(4)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">4</td>
                        <td onclick="Yaz(5)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">5</td>
                        <td onclick="Yaz(6)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">6</td>
                        <td onclick="Yaz(-2)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">C</td>
                    </tr>
                    <tr>
                        <td onclick="Yaz(1)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">1</td>
                        <td onclick="Yaz(2)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">2</td>
                        <td onclick="Yaz(3)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">3</td>
                        <td onclick="Yaz(-3)" class="bg-danger text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">X</td>
                    </tr>
                    <tr>
                        <td onclick="Yaz(0)" class="bg-dark text-white" colspan="2" style="font-size: 40pt;width: 50%;text-align: center;border-radius:0.375rem">0</td>            
                        <td onclick="Yaz(-4)" class="bg-dark text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">,</td>
                        <td onclick="Yaz(-5)" class="bg-success text-white" style="font-size: 40pt;width: 25%;text-align: center;border-radius:0.375rem">&#x2713;</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col col-3"></div>
    </div>
</div>
    <div class="col col-3">
        <div style="height:30vh;overflow-y: scroll;" id="OrderData">
            <cf_big_list class="table table-striped table-lg tableFixHead" SHOW_FS="0">
                <thead>
                  <tr>
                    <th scope="col">Ürün</th>
                    <th scope="col">Miktar</th>
                    <th scope="col">Üretilen</th>
                    
                  </tr>
                </thead>
                <tbody id="sipres">
                 
                </tbody>
              </cf_big_list>
        </div>
        <div style="height:20vh;overflow-y: scroll;" id="ProductionData">
            
        </div>
    </div>
</div>
<div class="row">
    <div class="col col-12">
   <table class="table">
    <tr>
        <td style="font-size: 14pt">
            <strong>Üretim Notu</strong>
        </td>
        <td style="font-size: 14pt" id="AA1" colspan="3">

        </td>
    </tr>
    <tr>
        <td style="font-size: 14pt">
            <strong>Açıklama</strong>
        </td>
        <td style="font-size: 14pt" id="AA2">

        </td>
        <td style="font-size: 14pt">
            <strong>Açıklama</strong>
        </td>
        <td style="font-size: 14pt" id="AA3">

        </td>
    </tr>
   </table>
   <div style="display: flex;justify-content: center;">
    <div class="alert alert-primary" id="uretimCount" style="display: block;width: 100px;height: 100px;font-size: 40pt;text-align: center;">0</div>
    </div>
    </div>
</div>
</div>
</div>
<cfoutput>
    <script>
        var currentDatePBS="#dateFormat(now(),"dd.mm.yyyy")#";
    </script>
    <script>
        var currentDatePBS="#dateFormat(now(),"dd.mm.yyyy")#";
        var dsn="#dsn#";
        var dsn1="#dsn1#";
        var dsn2="#dsn2#";
        var dsn3="#dsn3#";
    </script>
    </cfoutput>
    
<script src="/AddOns/Partner/js/Operator.js"></script>
<script src="/JS/sselec/selectize/dist/js/standalone/selectize.js"></script>
<link rel="stylesheet" href="/JS/sselec/selectize/dist/css/selectize.bootstrap5.css">