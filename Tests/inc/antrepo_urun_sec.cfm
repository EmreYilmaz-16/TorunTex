<cfquery name="getdata" datasource="#dsn3#">
    SELECT * FROM  (
SELECT SUM(AMOUNT) AS A,SUM(AMOUNT2) AS A2,T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PP.PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID FROM (
SELECT SUM(AMOUNT) AMOUNT ,SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM (
SELECT SR.AMOUNT, UNIT ,SR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,ROW_PROJECT_ID AS PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM #DSN2#.SHIP_ROW AS SR
	LEFT JOIN #DSN2#.SHIP AS S ON S.SHIP_ID=SR.SHIP_ID
	WHERE 1=1
AND S.DEPARTMENT_IN=13 

) AS T2 GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2
UNION ALL
SELECT -1* SUM(AMOUNT) AMOUNT,-1* SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM (
SELECT SFR.AMOUNT,UNIT,SFR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM #DSN2#.STOCK_FIS_ROW AS SFR 
	LEFT JOIN #DSN2#.STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID
WHERE SF.DEPARTMENT_OUT=13

) AS T GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2

) AS T2
LEFT JOIN #DSN#.PRO_PROJECTS AS PP ON PP.PROJECT_ID=T2.PROJECT_ID
LEFT JOIN #DSN3#.STOCKS AS  S ON S.STOCK_ID=T2.STOCK_ID
LEFT JOIN #DSN3#.PRODUCT_PLACE AS PS ON PS.PRODUCT_PLACE_ID=T2.SHELF_NUMBER
GROUP BY T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID) AS TS WHERE A>0 AND SHELF_NUMBER=#attributes.SHELF_NUMBER#
</cfquery>
<cfdump var="#getdata#">
<cf_big_list>
    <thead>
    <tr>
        <th>Ürün K.</th>
        <th>Ürün</th>
        <th>Beyanname</th>
        <th>Konteyner No</th>
        <th>Miktar</th>
        <th>Çuval</th>
        <th></th>
    </tr>
</thead>
<tbody>
<cfoutput query="getdata">
    <tr>
        <td id="PRODUCT_CODE_#CURRENTROW#">#PRODUCT_CODE#</td>
        <td id="PRODUCT_NAME_#CURRENTROW#">#PRODUCT_NAME#</td>
        <td id="PROJECT_HEAD_#CURRENTROW#">#PROJECT_HEAD#</td>
        <td id="KONTEYNER_ND_#CURRENTROW#">#LOT_NO#</td>
        <td>
            <div class="form-group">
                <input type="text" name="A_#CURRENTROW#" value="#A#" data-rid="#CURRENTROW#" id="A_#CURRENTROW#" readonly="yes" data-stm="#A# KG">
            </div>
        </td>
        <td>
            <div class="form-group">
                <input type="text" name="A2_#CURRENTROW#" value="#A2#" data-rid="#CURRENTROW#" id="A2_#CURRENTROW#"  data-stm="#A2#" onchange="hasapEt(this,event)">
            </div>
        </td>
        <td>
            <button type="button" class="btn btn-sm btn-success" onclick="satirEkle(this,#CURRENTROW#,#STOCK_ID#,#PROJECT_ID#,'#LOT_NO#')">Ekle</button>
        </td>
    </tr>
</cfoutput>
</tbody>
</cf_big_list>


<!----------
    var td = document.createElement("td");
    var input = document.createElement("input");
    input.value = commaSplit(Res.A[index]);
    input.setAttribute("type", "text");
    input.setAttribute("readonly", "yes");
    input.setAttribute("data-rid", index);
    input.setAttribute("id", "A_" + index);
    input.setAttribute("data-stm", Res.A[index]);
    td.appendChild(input);
    tr.appendChild(td);

    var td = document.createElement("td");
    var input = document.createElement("input");
    input.value = Res.A2[index];
    input.setAttribute("type", "text");
    input.setAttribute("onchange", "hasapEt(this,event)");
    input.setAttribute("data-rid", index);
    input.setAttribute("id", "A2_" + index);
    input.setAttribute("data-stm", Res.A2[index]);
    td.appendChild(input);
    tr.appendChild(td);
var btn = document.createElement("button");
    btn.innerText = "Ekle";
    btn.setAttribute("class", "btn btn-sm btn-success");
    td.appendChild(btn);
    tr.appendChild(td);
    btn.setAttribute(
      "onclick",
      "satirEkle(this," + index + "," + Res.STOCK_ID[index] + ")"
    );

    +----------->