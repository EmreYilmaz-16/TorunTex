<table class="table" >
<tr>
    <td>
        <div class="form-group">
            <label>
                Ürün Barkodu
            </label>
        <input class="form-control" type="text" name="Barcode" onkeyup="SearchBarcode(this,event)">
        <input type="hidden" name="FROM_WRK_ROW_ID" id="FROM_WRK_ROW_ID">
        <input type="hidden" name="FROM_STOCK_ID" id="FROM_STOCK_ID">
        <input type="hidden" name="TO_WRK_ROW_ID" id="TO_WRK_ROW_ID">
        <input type="hidden" name="TO_STOCK_ID" id="TO_STOCK_ID">
        <input type="hidden" name="FROM_AMOUNT" id="FROM_AMOUNT">
        <input type="hidden" name="TO_AMOUNT" id="TO_AMOUNT">
        <input type="hidden" name="FROM_LOT_NO" id="FROM_LOT_NO">
        <input type="hidden" name="TO_LOT_NO" id="TO_LOT_NO">
        
    </div>
    </td>
    <td>
        <div class="form-group">
            <label>Çıkış Depo</label>
            <input type="text" class="form-control"  readonly name="txtFromDeptLocation" id="txtFromDeptLocation">
            <input type="hidden"  name="txtFromDeptId" id="txtFromDeptId">
            <input type="hidden"  name="txtFromLocId" id="txtFromLocId">
        </div>
    </td>
    <td id="exitr" style="display:none">
        <div class="form-group">
            <label>Giriş Depo</label>
            <input type="text" class="form-control"  name="txtDepoAdi" id="txtDepoAdi" placeholder="Giriş Depo" onkeyup="searchDepo(this,event)">
            <input type="text" class="form-control" readonly  name="txtToDeptLocation" id="txtToDeptLocation" >
            <input type="hidden"  name="txtToDeptId" id="txtToDeptId">
            <input type="hidden"  name="txtToLocId" id="txtToLocId">
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

<script>
<cfoutput>
    var dsn="#dsn#";
    var dsn1="#dsn1#";
    var dsn2="#dsn2#";
    var dsn3="#dsn3#";
</cfoutput>


</script>

<cfscript src="/AddOns/Partner/js/CuvalTasi.js"></cfscript>
<!----

    Barkod Okut Çıkış Deposunu WrkQueryile getir 
    Giriş Depo Barkodu Okut wrlk query ile Giriş Depo bilgilerini getir

---->