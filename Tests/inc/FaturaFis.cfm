
<cfparam name="attributes.INVOICE_ID" default="77">
<cfquery name="getBeyans" datasource="#dsn2#">   
SELECT * FROM (
	SELECT SF.FIS_ID
		,SF.FIS_DATE AS SEVK_TARIHI
		,SFR.STOCK_ID AS STOCK_ID
		,SFR.AMOUNT AS MIKTAR
		,SFR.UNIT AS BIRIM
		,SFR.AMOUNT2 AS MIKTAR2
		,SFR.UNIT2 AS BIRIM2
		,SFR.LOT_NO AS KONTEYNER_NO
		,PP.PROJECT_HEAD AS BEYANNAME_NO
		,DATEDIFF(DAY, SF.FIS_DATE, GETDATE()) AS GECEN_SURE	
		,ISNULL(SUM(SFF.AMOUNT),0) AS KULLANILAN
		,SFR.AMOUNT-ISNULL(SUM(SFF.AMOUNT),0) AS KALAN
	FROM #dsn2#.STOCK_FIS AS SF
	INNER JOIN #dsn2#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	LEFT JOIN #dsn#.PRO_PROJECTS AS PP ON PP.PROJECT_ID = SF.PROJECT_ID
	LEFT  JOIN #dsn2#.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID=SF.FIS_ID AND SFF.STOCK_ID=SFR.STOCK_ID
	WHERE DEPARTMENT_OUT = 13
	GROUP BY
	SF.FIS_ID
		,SF.FIS_DATE 
		,SFR.STOCK_ID
		,SFR.AMOUNT 
		,SFR.UNIT 
		,SFR.AMOUNT2
		,SFR.UNIT2 
		,SFR.LOT_NO
		,PP.PROJECT_HEAD
) AS T WHERE T.KALAN>0
UNION ALL
SELECT * FROM (
	SELECT SF.FIS_ID
		,SF.FIS_DATE AS SEVK_TARIHI
		,SFR.STOCK_ID AS STOCK_ID
		,SFR.AMOUNT AS MIKTAR
		,SFR.UNIT AS BIRIM
		,SFR.AMOUNT2 AS MIKTAR2
		,SFR.UNIT2 AS BIRIM2
		,SFR.LOT_NO AS KONTEYNER_NO
		,PP.PROJECT_HEAD AS BEYANNAME_NO
		,DATEDIFF(DAY, SF.FIS_DATE, GETDATE()) AS GECEN_SURE	
		,ISNULL(SUM(SFF.AMOUNT),0) AS KULLANILAN
		,SFR.AMOUNT-ISNULL(SUM(SFF.AMOUNT),0) AS KALAN
	FROM w3Toruntex_2023_1.STOCK_FIS AS SF
	INNER JOIN w3Toruntex_2023_1.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	LEFT JOIN #dsn#.PRO_PROJECTS AS PP ON PP.PROJECT_ID = SF.PROJECT_ID
	LEFT  JOIN w3Toruntex_2023_1.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID=SF.FIS_ID AND SFF.STOCK_ID=SFR.STOCK_ID
	WHERE DEPARTMENT_OUT = 13
	GROUP BY
	SF.FIS_ID
		,SF.FIS_DATE 
		,SFR.STOCK_ID
		,SFR.AMOUNT 
		,SFR.UNIT 
		,SFR.AMOUNT2
		,SFR.UNIT2 
		,SFR.LOT_NO
		,PP.PROJECT_HEAD
) AS T WHERE T.KALAN>0

</cfquery>
<cfoutput>
<script>
    var BEYANNAME_DATA=[
        <cfloop query="getBeyans">
            {
                FIS_ID:#FIS_ID#,
                SEVK_TARIHI:"#dateformat(SEVK_TARIHI,'dd/mm/yyyy')#",
                STOCK_ID:#STOCK_ID#,
                MIKTAR:#MIKTAR#,
                BIRIM:"#BIRIM#",
                MIKTAR2:#MIKTAR2#,
                BIRIM2:"#BIRIM2#",                
                KONTEYNER_NO:"#KONTEYNER_NO#",
                BEYANNAME_NO:"#BEYANNAME_NO#",
                GECEN_SURE:#GECEN_SURE#,
                KULLANILAN:#KULLANILAN#,
                KALAN:#KALAN#
            },
        </cfloop>
    ];
    var dsn="#dsn#";
    var dsn1="#dsn1#";
    var dsn2="#dsn2#";
    var dsn3="#dsn3#";
</script>
</cfoutput>

<cf_box title="Kullanılan Beyannameler" scroll="1" collapsable="1" resize="1" popup_box="1">
<table>
    <tr>
        <td>
            <div class="form-group">
                <label>Elleçleme Stok Girişi</label>
                <select name="BEYAN" id="BEYAN">
                    <cfoutput query="getBeyans">
                        <option value="#FIS_ID#-#STOCK_ID#">#BEYANNAME_NO#  - #KONTEYNER_NO# - #GECEN_SURE# Gün - #KALAN# #BIRIM#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>
            <div class="form-group">
            <label>Miktar</label>
            <input type="number" name="KULLAN" id="KULLAN">
        </div>
        </td>
        <td>
            <button type="button" class="btn btn-success" onclick="Ekle(<cfoutput>#attributes.INVOICE_ID#,'#dsn2#',#session.ep.userid#</cfoutput>)">Ekle</button>
        </td>
    </tr>
</table>
<cf_big_list>
    <thead>
    <tr>
        <th>Beyanname No</th>
        <th>Antrepo Çıkış Tarihi</th>
        <th>Miktar</th>
    </tr>
</thead>
<cfquery name="GETFISFAT" datasource="#DSN2#">
    SELECT 
        SF.FIS_ID
		,SF.FIS_DATE AS SEVK_TARIHI
		,SFR.STOCK_ID AS STOCK_ID
		,SFR.AMOUNT AS MIKTAR
		,SFR.UNIT AS BIRIM
		,SFR.AMOUNT2 AS MIKTAR2
		,SFR.UNIT2 AS BIRIM2
		,SFR.LOT_NO AS KONTEYNER_NO
		,PP.PROJECT_HEAD AS BEYANNAME_NO
		,SFF.AMOUNT
FROM #dsn2#.STOK_FIS_FATURA AS SFF
INNER JOIN #dsn2#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID=SFF.FIS_ID AND SFR.STOCK_ID=SFF.STOCK_ID
INNER JOIN #dsn2#.STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID
INNER JOIN #dsn#.PRO_PROJECTS AS PP ON PP.PROJECT_ID = SF.PROJECT_ID
WHERE FATURA_ID=#attributes.INVOICE_ID#
</cfquery>
<tbody id="Sepetim">
    <cfoutput query="GETFISFAT">
        <tr>
            <td>#BEYANNAME_NO#</td>
            <td>#dateFormat(SEVK_TARIHI,"dd/mm/yyyy")#</td>
            <td>#AMOUNT#</td>
        </tr>
</cfoutput>
</tbody>
</cf_big_list>
</cf_box>
<script>
    


    function Ekle(INVOICE_ID,DSN2,EMPLOYEE_ID) {
        var B=document.getElementById("BEYAN").value;
        var FIS_ID=list_getat(B,1,"-")
        var STOCK_ID=list_getat(B,2,"-")
        var AMOUNT=document.getElementById("KULLAN").value;
        $.ajax({
            url:"/AddOns/Partner/Servis/GeneralFunctions.cfc?method=SaveFatFis",
            data:{
                FIS_ID:FIS_ID,
                STOCK_ID:STOCK_ID,
                AMOUNT:AMOUNT,
                INVOICE_ID:INVOICE_ID,
                DSN2:DSN2,
                EMPLOYEE_ID:EMPLOYEE_ID
            },
            success:function (returnData) {
                
                console.log(returnData);
                var Beyan=BEYANNAME_DATA.find(p=>p.FIS_ID==FIS_ID)
                var tr=document.createElement("tr");
                var td=document.createElement("td");                
                td.innerText=Beyan.BEYANNAME_NO;
                tr.appendChild(td);
                var td=document.createElement("td");                
                td.innerText=Beyan.SEVK_TARIHI;
                tr.appendChild(td);
                var td=document.createElement("td");                
                td.innerText=AMOUNT;
                tr.appendChild(td);
                document.getElementById("Sepetim").appendChild(tr);
                LoadBeyannameData()
            }
        })
        
    }
    function LoadBeyannameData() {
        $.ajax({
            url:"/AddOns/Partner/Servis/GeneralFunctions.cfc?method=getBeyannameler",
            data:{
                dsn:dsn,
                dsn2:dsn2
            },
            success:function (returnData) {
                var obj=JSON.parse(returnData)
                $("#BEYAN").html("");
                for (let index = 0; index < obj.length; index++) {
                    const element = obj[index];
                    var opt=document.createElement("option");
                    opt.value=element.FIS_ID+"-"+element.STOCK_ID;
                    opt.innerText=element.BEYANNAME_NO+" - "+element.KONTEYNER_NO+" - "+element.GECEN_SURE+" Gün - "+element.KALAN+" "+element.BIRIM;
                    document.getElementById("BEYAN").appendChild(opt);
                    
                }
            }
        })
    }
</script>
