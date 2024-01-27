<style>
.RESAB{
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.RESAS {
    font-size: 25pt;
    width: 25%;
    border: solid 1px;
    text-align: center;
    margin-left: auto;
    margin-right: auto;
}
  
    @media only screen and (max-width: 600px) {
  .RESAS {
    width:100%;
  }
  .RESAB{
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    flex-direction: column;
  }
}
</style>
<cf_box title="Çuval Taşı">

    <table class="table" >
        <tr>
            <td id="exitr">
                <div class="form-group">
                    <label>Giriş Depo</label>
                    <cfquery name="getDepo" datasource="#dsn3#">
           <!---    SELECT COMMENT,SL.DEPARTMENT_ID,SL.LOCATION_ID,'Sipariş Depo' AS SD FROM #DSN#.STOCKS_LOCATION AS SL WHERE SL.DEPARTMENT_ID=14---->
           SELECT * FROM (
 SELECT COMMENT,SL.DEPARTMENT_ID,SL.LOCATION_ID ,'Sipariş Depo' AS SD
,(SELECT COUNT(*) FROM #dsn3#.ORDERS WHERE DELIVER_DEPT_ID=SL.DEPARTMENT_ID AND LOCATION_ID=SL.LOCATION_ID AND ORDER_STAGE<>262) AS AKTIF

 FROM #dsn#.STOCKS_LOCATION AS SL WHERE SL.DEPARTMENT_ID=14
 UNION  ALL 
        SELECT COMMENT,SL.DEPARTMENT_ID,SL.LOCATION_ID,'Genel Depo' AS SD ,1 AS AKTIF FROM #DSN#.STOCKS_LOCATION AS SL WHERE SL.DEPARTMENT_ID=15
 ) AS T WHERE AKTIF >0
       
        
                    </cfquery>
                    <SELECT name="txtDepoAdi" id="txtDepoAdi" onchange="this.setAttribute('disabled','true')" <!--- onchange="searchDepo_2(this)"---->>
                        <option value="">Seçiniz</option>
                        
                        <cfoutput query="getDepo" group="DEPARTMENT_ID">
                            <optgroup label="#SD#">
                            <cfoutput>
                            <option value="#COMMENT#">#COMMENT#</option>
                        </cfoutput>
                    </optgroup>
                        </cfoutput>
                    </SELECT>
                    <input type="hidden" class="form-control"  name="txtDepoAdi" id="txtDepoAdi" placeholder="Giriş Depo" onkeyup="searchDepo(this,event)">
                    <input type="text" class="form-control" readonly  name="txtToDeptLocation" id="txtToDeptLocation" >
                    <input type="hidden"  name="txtToDeptId" id="txtToDeptId">
                    <input type="hidden"  name="txtToLocId" id="txtToLocId">
                </div>
            </td>
            <td style="vertical-align: middle;align-content: center;">
                <div class="RESAB">
                    <div><button class="btn btn-warning" onclick="window.location.reload()">Yeni Depo Seç</button></div>
                        <div class="RESAS" >
                            <span id="OkutulanCuval">0</span><span>&nbsp;Ad. </span>
                        </div>
                        <div class="RESAS">
                            <span id="OkutulanKg">0</span><span>&nbsp;Kg. </span>
                        </div>
                </div>
    </td>
        </tr>
<tr>
    <td>
        <div class="form-group">
            <label>
                Ürün Barkodu
            </label>
        <input class="form-control" type="text" name="Barcode" id="Barcode" onkeyup="SearchBarcode(this,event)">
        <input type="hidden" name="FROM_WRK_ROW_ID" id="FROM_WRK_ROW_ID">
        <input type="hidden" name="FROM_STOCK_ID" id="FROM_STOCK_ID">
        <input type="hidden" name="TO_WRK_ROW_ID" id="TO_WRK_ROW_ID">
        <input type="hidden" name="TO_STOCK_ID" id="TO_STOCK_ID">
        <input type="hidden" name="FROM_AMOUNT" id="FROM_AMOUNT">
        <input type="hidden" name="TO_AMOUNT" id="TO_AMOUNT">
        <input type="hidden" name="FROM_LOT_NO" id="FROM_LOT_NO">
        <input type="hidden" name="TO_LOT_NO" id="TO_LOT_NO">
        <input type="hidden" name="FROM_UNIT2" id="FROM_UNIT2">        
    </div>
    <div id="LastBarcode"></div>
    </td>
    <td>
        <div class="form-group">
            <label>Çıkış Depo</label>
            <input type="text" class="form-control"  readonly name="txtFromDeptLocation" id="txtFromDeptLocation">
            <input type="hidden"  name="txtFromDeptId" id="txtFromDeptId">
            <input type="hidden"  name="txtFromLocId" id="txtFromLocId">
            
        </div>
    </td>
    
</tr>
<tr>
    <td colspan="3">
        <div style="display:flex">
            <button style="display:none" id="btnKayit" class="form-control btn btn-sm btn-outline-success" onclick="Kaydet()">Kaydet</button>
        </div>
    </td>
</tr>
</table>
<cf_big_list>
    <thead>
    <tr>
        
            <th>
                Lot No
            </th>
            <th>
                Ürün
            </th>
            
            <th>
                Miktar
            </th>
            <th>
                Miktar 2
            </th>
            <th>
                Depo
            </th>
            <th>
                Sipariş 
            </th>
            <th>            
            </th>
        
    </tr>
</thead>
<tbody id="Sepetim"> 
    
</tbody>
</cf_big_list>

<script>
<cfoutput>
    var dsn="#dsn#";
    var dsn1="#dsn1#";
    var dsn2="#dsn2#";
    var dsn3="#dsn3#";
</cfoutput>


</script>

<script src="/AddOns/Partner/js/CuvalTasi.js"></script>
<!----

    Barkod Okut Çıkış Deposunu WrkQueryile getir 
    Giriş Depo Barkodu Okut wrlk query ile Giriş Depo bilgilerini getir

---->
</cf_box>