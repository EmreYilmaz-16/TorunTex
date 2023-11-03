<div class="row">
    <div class="col col-9">
        <cf_seperator id="getP2" header="Duyurukar"  style="display:none;">
            <div id="getP2"  style="display:none;">
                <cfquery name="getDuyuru" datasource="#dsn#">
                    select CONT_HEAD,CONTENT_ID,* from CONTENT where ISNULL(CONVERT(DATE,VIEW_DATE_START),CONVERT(DATE,GETDATE()))<=CONVERT(DATE,getdate())  AND 
                        ISNULL(CONVERT(DATE,VIEW_DATE_FINISH),CONVERT(DATE,GETDATE()))>=CONVERT(DATE,getdate())
                </cfquery>
                <div class="list-group">
                    <cfoutput query="getDuyuru">
                    <a onclick="windowopen('/index.cfm?fuseaction=rule.dsp_rule&cntid=#CONTENT_ID#')" class="list-group-item-action">#CONT_HEAD#</a>                    
                </cfoutput>
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
                <td style="font-size: 20px" id="Location">KLB</td>
                <td style="font-size: 20px" id="Complate">%80</td>
                <td style="font-size: 20px" id="Customer">Emre Cooop</td>
                <td style="font-size: 20px" id="Country">Türkiye</td>
                <td style="font-size: 20px" id="Color">
                    <div style="display: flex;justify-content: space-between;">
                        <span style="font-size: 20px" id="RenkYazi" style="width: 50%;display: block;">Şeffaf-Kırmızı</span> 
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
        <div class="form-group">
            <label>Sipariş</label>
            <select class="form-control form-select sel" id="select_2" placeholder="Sipariş Seçiniz" aria-label="Default select example">            
                
            </select>
        </div>
        <div style="display:flex;flex-direction: column;">
            <button type="button" class="btn btn-lg btn-success" onclick="Yazdir()" style="margin-bottom: 5px;">Yazdir/Üret</button>
            <button type="button" class="btn btn-danger" onclick="Iptal()">İptal</button>
            <input type="hidden" name="WRK_ROW_ID" id="WRK_ROW_ID">
            <input type="hidden" name="LotNo" id="LotNo">
        </div>
<hr>
        <div style="height:25vh;overflow-y: scroll;" id="DigerSiparis">
            
        </div>
</div>

<div class="col-6">
   <div style="display:flex;justify-content: space-between;">
    <div class="form-group">
        <label>Paket İçerik</label>
        <input style="font-size:20pt" type="text" class="form-control" readonly="" id="paketIcerik">
    </div>
    <div class="form-group">
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
                    <th scope="col">Ürün</th>
                    <th scope="col">Miktar</th>
                    <th scope="col">Üretilen</th>
                    
                  </tr>
                </thead>
                <tbody id="sipres">
                 
                </tbody>
              </table>
        </div>
        <div style="height:20vh;overflow-y: scroll;" id="ProductionData">
            
        </div>
    </div>
</div>
<div class="row">
    <div class="col col-12">

    </div>
</div>

<script src="/AddOns/Partner/js/Operator.js"></script>
<script src="/JS/sselec/selectize/dist/js/standalone/selectize.js"></script>
<link rel="stylesheet" href="/JS/sselec/selectize/dist/css/selectize.bootstrap5.css">