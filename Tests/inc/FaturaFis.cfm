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
	FROM w3Toruntex_2023_1.STOCK_FIS AS SF
	INNER JOIN w3Toruntex_2023_1.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	INNER JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID = SF.PROJECT_ID
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
                SEVK_TARIHI:"#SEVK_TARIHI#",
                STOCK_ID:#STOCK_ID#,
                MIKTAR:#MIKTAR#,
                SEVK_TARIHI:"#BIRIM#",
                MIKTAR:#MIKTAR2#,
                SEVK_TARIHI:"#BIRIM2#",
                KONTEYNER_NO:"#KONTEYNER_NO#",
                BEYANNAME_NO:"#BEYANNAME_NO#",
                GECEN_SURE:#GECEN_SURE#,
                KULLANILAN:#KULLANILAN#,
                KALAN:#KALAN#
            },
        </cfloop>
    ]
</script>
</cfoutput>
<table>
    <tr>
        <td>
            <div class="form-group">
                <label>Beyanname</label>
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
        <th>
            Beyanname No
        </th>
        <th>
            Beyanname Tarihi
        </th>
        <th>
            Miktar
        </th>

    </tr>
</thead>
<tbody id="Sepetim">

</tbody>
</cf_big_list>


<script>
    function Ekle(INVOICE_ID,DSN2,EMPLOYEE_ID) {
        var B=document.getElementById("BEYAN").value;
        var FIS_ID=list_getat(B,1,"-")
        var STOCK_ID=list_getat(B,2,"-")
        var AMOUNT=document.getElementById("KULLAN").value;
      return arguments;
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
                var tr=document.createElement("tr");
                var td=document.createElement("td");
                td.innerText=""

            }
        })
        
    }
</script>