<table>
<tr>
    <td>
        <input type="text" name="Barcode" onkeyup="SearchBarcode(this,event)">
        <input type="hidden" name="FROM_WRK_ROW_ID" id="FROM_WRK_ROW_ID">
        <input type="hidden" name="TO_WRK_ROW_ID" id="TO_WRK_ROW_ID">
    </td>
    <td>
        <div class="form-group">
            <label>Çıkış Depo</label>
            <input type="text" readonly name="txtFromDeptLocation" id="txtFromDeptLocation">
            <input type="hidden"  name="txtFromDeptId" id="txtFromDeptId">
            <input type="hidden"  name="txtFromLocId" id="txtFromLocId">
        </div>
    </td>
    <td style="display:none">
        <div class="form-group">
            <label>Giriş Depo</label>
            <input type="text" name="txtToDeptLocation" id="txtToDeptLocation" onkeyup="searchDepo()">
            <input type="text"  name="txtToDeptId" id="txtToDeptId">
            <input type="text"  name="txtToLocId" id="txtToLocId">
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
    function SearchBarcode(el,ev){
        if(ev.keyCode==13){
            var UrunBarkodu=el.value;
            UrunBarkodu=ReplaceAll(UrunBarkodu,"||","|")
            var UrunKodu=list_getat(UrunBarkodu,1,"|");
            var LotNo=list_getat(UrunBarkodu,2,"|");
            var Agirlik=list_getat(UrunBarkodu,3,"|");
            var Qstr1="SELECT ORDERS.DELIVER_DEPT_ID,ORDERS.LOCATION_ID,ORDER_ROW.WRK_ROW_ID FROM "+dsn3+".ORDER_ROW"
            Qstr1+=" INNER JOIN "+dsn3+".ORDERS ON ORDERS.ORDER_ID=ORDER_ROW.ORDER_ID"
            Qstr1+=" WHERE WRK_ROW_ID=( SELECT  DISTINCT PBS_RELATION_ID FROM "+dsn2+".STOCKS_ROW where LOT_NO='"+LotNo+"')"
            var QueryResult_1=wrk_query(Qstr1);
            console.log(QueryResult_1);
        }
    }
</script>

<!----

    Barkod Okut Çıkış Deposunu WrkQueryile getir 
    Giriş Depo Barkodu Okut wrlk query ile Giriş Depo bilgilerini getir

---->