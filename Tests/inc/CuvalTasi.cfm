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
var ValidStyle="color: green; font-weight: bold; background: #b5e8b573;";
var InValidStyle="color: red; font-weight: bold; background: #ff7a7a66;";
var AktifSiparisSureci=259;

    function SearchBarcode(el,ev){
        if(ev.keyCode==13){
            var UrunBarkodu=el.value;
            UrunBarkodu=ReplaceAll(UrunBarkodu,"||","|")
            var UrunKodu=list_getat(UrunBarkodu,1,"|");
            var LotNo=list_getat(UrunBarkodu,2,"|");
            var Agirlik=list_getat(UrunBarkodu,3,"|");
            var Qstr1="SELECT ORDERS.DELIVER_DEPT_ID,ORDERS.LOCATION_ID,ORR.WRK_ROW_ID,ORR.STOCK_ID FROM "+dsn3+".ORDER_ROW as ORR"
            Qstr1+=" INNER JOIN "+dsn3+".ORDERS ON ORDERS.ORDER_ID=ORR.ORDER_ID"
            Qstr1+=" WHERE ORR.WRK_ROW_ID=( SELECT  DISTINCT PBS_RELATION_ID FROM "+dsn2+".STOCKS_ROW where LOT_NO='"+LotNo+"')"
            var QueryResult_1=wrk_query(Qstr1);
            if(QueryResult_1.recordcount>0){
                el.setAttribute("style",ValidStyle); 
                document.getElementById("txtFromDeptLocation").setAttribute("style",ValidStyle);                
                var Qstr2="SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.DEPARTMENT_ID,SL.LOCATION_ID FROM STOCKS_LOCATION as SL "
                Qstr2+=" INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID  WHERE SL.DEPARTMENT_ID="+QueryResult_1.DELIVER_DEPT_ID[0]+" AND SL.LOCATION_ID="+QueryResult_1.LOCATION_ID[0];
                var QueryResult_2=wrk_query(Qstr2)
                $("#txtFromDeptLocation").val(QueryResult_2.DEPARTMENT_HEAD[0]+" "+QueryResult_2.COMMENT[0])
                $("#txtFromDeptId").val(QueryResult_2.DEPARTMENT_ID[0])
                $("#txtFromLocId").val(QueryResult_2.LOCATION_ID[0])
                $("#FROM_STOCK_ID").val(QueryResult_1.STOCK_ID[0])
                $("#FROM_WRK_ROW_ID").val(QueryResult_1.WRK_ROW_ID[0])
                $("#exitr").show(500);
                $("#txtToDeptLocation").focus();
            }else{
                el.setAttribute("style",InValidStyle); 
            }          
        }
    }
    function searchDepo(el,ev) {
        if(ev.keyCode==13){
            var STOCK_ID=$("#FROM_STOCK_ID").val();
            var Qstr1="SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.LOCATION_ID,SL.DEPARTMENT_ID FROM w3Toruntex.STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID WHERE 1=1 AND COMMENT ='"+el.value+"'"
           // var Qstr1="SELECT * FROM w3Toruntex.STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D WHERE 1=1 AND COMMENT ='"+el.value+"'";
            var QueryResult_1=wrk_query(Qstr1);
            if(QueryResult_1.recordcount>0){
                

                var Qstr2="SELECT O.ORDER_ID,ORDER_NUMBER,ORDER_HEAD,ORR.WRK_ROW_ID,ORR.STOCK_ID FROM "+dsn3+".ORDERS AS O"
                Qstr2+=" INNER JOIN "+dsn3+".ORDER_ROW AS ORR ON ORR.ORDER_ID=O.ORDER_ID "
                Qstr2+=" WHERE O.ORDER_STAGE="+AktifSiparisSureci+" AND O.DELIVER_DEPT_ID="+QueryResult_1.DEPARTMENT_ID[0]+" AND O.LOCATION_ID="+QueryResult_1.LOCATION_ID[0]+"  AND ORR.STOCK_ID="+STOCK_ID
          //  var Qstr2="SELECT ORDER_ID,ORDER_NUMBER,ORDER_HEAD FROM "+dsn3+".ORDERS WHERE ORDER_STAGE=259 AND DELIVER_DEPT_ID="+QueryResult_1.DEPARTMENT_ID[0]+" AND LOCATION_ID="+QueryResult_1.LOCATION_ID[0];
                var QueryResult_2=wrk_query(Qstr2);
               if(QueryResult_2.recordcount>0){
                el.setAttribute("style",ValidStyle); 
                document.getElementById("txtToDeptLocation").setAttribute("style",ValidStyle);   
                    $("#txtToDeptId").val(QueryResult_1.DEPARTMENT_ID[0])
                    $("#txtToLocId").val(QueryResult_1.LOCATION_ID[0])
                    $("#txtToDeptLocation").val(QueryResult_1.DEPARTMENT_HEAD[0]+"-"+QueryResult_1.COMMENT[0])
                    $("#TO_STOCK_ID").val(STOCK_ID)
                    $("#TO_WRK_ROW_ID").val(QueryResult_2.WRK_ROW_ID[0])
                    $("#btnKayit").show();}else{
                        el.setAttribute("style",InValidStyle); 
                document.getElementById("txtToDeptLocation").setAttribute("style",InValidStyle);   
                    }
            }else{
                el.setAttribute("style",InValidStyle); 
            }
        }
    }
    function Kaydet() {
        var FROM_DEPARTMENT_ID=$("#txtFromDeptId").val()
        var FROM_LOCATION_ID=$("#txtFromLocId").val()
        var FROM_WRK_ROW_ID=$("#FROM_WRK_ROW_ID").val()
        var FROM_STOCK_ID=$("#FROM_STOCK_ID").val()

        var TO_DEPARTMENT_ID=$("#txtToDeptId").val()
        var TO_LOCATION_ID=$("#txtToLocId").val()
        var TO_WRK_ROW_ID=$("#TO_WRK_ROW_ID").val()
        var TO_STOCK_ID=$("#TO_STOCK_ID").val()

        var FormDatam={
            FROM_DEPARTMENT_ID:FROM_DEPARTMENT_ID,
            FROM_LOCATION_ID:FROM_LOCATION_ID,
            FROM_WRK_ROW_ID:FROM_WRK_ROW_ID,
            FROM_STOCK_ID:FROM_STOCK_ID,
            TO_DEPARTMENT_ID:TO_DEPARTMENT_ID,
            TO_LOCATION_ID:TO_LOCATION_ID,
            TO_WRK_ROW_ID:TO_WRK_ROW_ID,
            TO_STOCK_ID:TO_STOCK_ID
        };
        console.log(FormDatam)
        SendFormData("",FormDatam)
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
function SendFormData(uri, BasketData) {
  var mapForm = document.createElement("form");
  mapForm.target = "Map";
  mapForm.method = "POST"; // or "post" if appropriate
  mapForm.action = uri;

  var mapInput = document.createElement("input");
  mapInput.type = "hidden";
  mapInput.name = "data";
  mapInput.value = JSON.stringify(BasketData);
  mapForm.appendChild(mapInput);

  document.body.appendChild(mapForm);

  map = window.open(
    uri,
    "Map",
    "status=0,title=0,height=600,width=800,scrollbars=1"
  );

  if (map) {
    mapForm.submit();
  } else {
    alert("You must allow popups for this map to work.");
  }
}

</script>

<!----

    Barkod Okut Çıkış Deposunu WrkQueryile getir 
    Giriş Depo Barkodu Okut wrlk query ile Giriş Depo bilgilerini getir

---->