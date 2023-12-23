function getShelves(el) {
  var DEPARTMENT_ID = list_getat(el.value, 1, "-");
  var LOCATION_ID = list_getat(el.value, 2, "-");
  var Res = wrk_query(
    "SELECT SHELF_CODE,PRODUCT_PLACE_ID FROM PRODUCT_PLACE WHERE STORE_ID=" +
      DEPARTMENT_ID +
      " AND LOCATION_ID=" +
      LOCATION_ID,
    "DSN3"
  );
  $("#SHELF").html('<option value="">Seçiniz</option>');
  for (let index = 0; index < Res.SHELF_CODE.length; index++) {
    var opt = document.createElement("option");
    opt.setAttribute("value", Res.PRODUCT_PLACE_ID[index]);
    opt.innerText = Res.SHELF_CODE[index];
    document.getElementById("SHELF").appendChild(opt);
  }
}
function getShelfProducts(el) {
    var str="SELECT * FROM  (SELECT SUM(AMOUNT) AS A,SUM(AMOUNT2) AS A2,T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PP.PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID FROM ("
        str+=" SELECT SUM(AMOUNT) AMOUNT ,SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM (SELECT SR.AMOUNT, UNIT ,SR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,ROW_PROJECT_ID AS PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM "+dsn2+".SHIP_ROW AS SR"
        str+=" LEFT JOIN "+dsn2+".SHIP AS S ON S.SHIP_ID=SR.SHIP_ID WHERE 1=1 AND S.DEPARTMENT_IN=13 ) AS T2 GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 UNION ALL"
        str+=" SELECT -1* SUM(AMOUNT) AMOUNT,-1* SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM ( SELECT SFR.AMOUNT,UNIT,SFR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM "+dsn2+".STOCK_FIS_ROW AS SFR "
        str+=" LEFT JOIN "+dsn2+".STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID WHERE SF.DEPARTMENT_OUT=13 ) AS T GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2) AS T2"
        str+=" LEFT JOIN "+dsn+".PRO_PROJECTS AS PP ON PP.PROJECT_ID=T2.PROJECT_ID LEFT JOIN "+dsn3+".STOCKS AS  S ON S.STOCK_ID=T2.STOCK_ID LEFT JOIN "+dsn3+".PRODUCT_PLACE AS PS ON PS.PRODUCT_PLACE_ID=T2.SHELF_NUMBER"
        str+=" GROUP BY T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID) AS TS WHERE A>0 AND SHELF_NUMBER="+el.value
$("#URUNLER").html("");
  var Res = wrk_query(str, "dsn3");
  for (let index = 0; index < Res.recordcount; index++) {
    var tr=document.createElement("tr");
    var td=document.createElement("td");
    td.innerText=Res.PRODUCT_CODE[index];
    tr.appendChild(td);
    var td=document.createElement("td");
    td.innerText=Res.PRODUCT_NAME[index];
    tr.appendChild(td);
    var td=document.createElement("td");
    var input=document.createElement("input");
    input.value=commaSplit(Res.A[index])
    input.setAttribute("type","text");
    input.setAttribute("readonly","yes");
    td.appendChild(input);    
    tr.appendChild(td);

    var td=document.createElement("td");
    var input=document.createElement("input");
    input.value=Res.A2[index];
    input.setAttribute("type","text");
    input.setAttribute("onchange","hasapEt(this)");
    td.appendChild(input);    
    tr.appendChild(td);
    var td=document.createElement("td");
    td.innerText=Res.PROJECT_HEAD[index];
    tr.appendChild(td);
    var td=document.createElement("td");
    var btn=document.createElement("button");
    btn.innerText="Ekle"
    btn.setAttribute("class","btn btn-sm btn-success");
    td.appendChild(btn);
    tr.appendChild(td)
    document.getElementById("URUNLER").appendChild(tr);
  }
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
