
<cfparam name="attributes.INVOICE_ID" default="77">
<cfquery name="GetPeriods" datasource="#DSN#">
    SELECT * FROM w3Toruntex.SETUP_PERIOD WHERE OUR_COMPANY_ID=1
</cfquery>
<cfset i=0>
<cfquery name="getBeyans" datasource="#dsn2#">   


SELECT T.*
	,PP.PROJECT_ID
	,PP.PROJECT_HEAD AS BEYANNAME_NO
	,DATEDIFF(DAY, T.SEVK_TARIHI, GETDATE()) AS GECEN_SURE
	,ISNULL(SUM(SFF.AMOUNT), 0) AS KULLANILAN
	,T.MIKTAR  - ISNULL(SUM(SFF.AMOUNT), 0) AS KALAN
FROM (
    <cfloop query="GetPeriods">
<cfset i=i+1>
	SELECT SF.PROJECT_ID
		,SFR.AMOUNT as MIKTAR 
		,SFR.AMOUNT2 AS MIKTAR2 
		,SF.FIS_ID
		,SF.FIS_DATE as SEVK_TARIHI
		,SFR.STOCK_ID
        ,SFR.UNIT AS BIRIM
        ,SFR.UNIT2 AS BIRIM2 
		,#PERIOD_ID# AS PERIOD_ID
		,SFR.LOT_NO AS KONTEYNER_NO 
	FROM w3Toruntex_#PERIOD_YEAR#_#OUR_COMPANY_ID#.STOCK_FIS AS SF
	INNER JOIN w3Toruntex_#PERIOD_YEAR#_#OUR_COMPANY_ID#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	WHERE DEPARTMENT_OUT = 13
	<cfif i lt GetPeriods.recordCount>
	UNION ALL
</cfif>
</cfloop>
	) AS T
LEFT JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID = T.PROJECT_ID
LEFT JOIN w3Toruntex_1.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID = T.FIS_ID
	AND SFF.FIS_PERIOD_ID = T.PERIOD_ID
	AND SFF.STOCK_ID = T.STOCK_ID
GROUP BY PP.PROJECT_ID
	,T.MIKTAR 
	,T.MIKTAR2 
	,T.FIS_ID
	,SEVK_TARIHI
	,T.STOCK_ID
	,PERIOD_ID
	,KONTEYNER_NO 
	,T.PROJECT_ID
	,PP.PROJECT_HEAD
,T.BIRIM
,T.BIRIM2 

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
                KALAN:#KALAN#,
                PERIOD_ID:#PERIOD_ID#
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
                        <option value="#FIS_ID#-#STOCK_ID#-#PERIOD_ID#">#BEYANNAME_NO#  - #KONTEYNER_NO# - #GECEN_SURE# Gün - #KALAN# #BIRIM#</option>
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
            <button type="button" class="btn btn-success" onclick="Ekle(<cfoutput>#attributes.INVOICE_ID#,'#dsn2#',#session.ep.userid#,#session.ep.PERIOD_ID#</cfoutput>)">Ekle</button>
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
<cfquery name="IH" datasource="#dsn3#">
    SELECT * FROM STOK_FIS_FATURA  where FATURA_ID=#attributes.INVOICE_ID# AND FATURA_PERIOD_ID=#session.EP.PERIOD_ID#
</cfquery>
<CFIF IH.recordCount>
<cfquery name="GETGETPER" datasource="#DSN3#">
    select SP.PERIOD_YEAR,SP.OUR_COMPANY_ID,SP.PERIOD_ID from w3Toruntex_1.STOK_FIS_FATURA AS SFF 
INNER JOIN w3Toruntex.SETUP_PERIOD as SP ON SP.PERIOD_ID=SFF.FIS_PERIOD_ID where FATURA_ID=#attributes.INVOICE_ID# AND FATURA_PERIOD_ID=#session.EP.PERIOD_ID#
</cfquery>
<CFELSE>
    <cfquery name="GETGETPER" datasource="#DSN#">
        select SP.PERIOD_YEAR,SP.OUR_COMPANY_ID,SP.PERIOD_ID from SETUP_PERIOD as SP WHERE OUR_COMPANY_ID=#session.EP.COMPANY_ID#
    
    </cfquery>   
</CFIF>
<cfdump var="#GETGETPER#">
<CFSET i=0>
<cfquery name="GETFISFAT" datasource="#DSN2#">


SELECT DISTINCT T.*
	,PP.PROJECT_ID
	,PP.PROJECT_HEAD AS BEYANNAME_NO
	,SFF.AMOUNT
FROM (
	<CFLOOP query="GETGETPER">
        <cfset i=i+1>
    SELECT SF.PROJECT_ID
    ,SFR.AMOUNT as MIKTAR 
		,SFR.AMOUNT2 AS MIKTAR2 
		,SF.FIS_ID
		,SF.FIS_DATE as SEVK_TARIHI
		,SFR.STOCK_ID
        ,SFR.UNIT AS BIRIM
        ,SFR.UNIT2 AS BIRIM2 
		,#PERIOD_ID# AS PERIOD_ID
		,SFR.LOT_NO AS KONTEYNER_NO 
	FROM w3Toruntex_#PERIOD_YEAR#_#OUR_COMPANY_ID#.STOCK_FIS AS SF
	INNER JOIN w3Toruntex_#PERIOD_YEAR#_#OUR_COMPANY_ID#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	WHERE DEPARTMENT_OUT = 13
	<cfif i lt GETGETPER.recordCount>
	UNION ALL
    </cfif>
</CFLOOP>
	) AS T
LEFT JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID = T.PROJECT_ID
LEFT JOIN w3Toruntex_1.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID = T.FIS_ID
	AND SFF.FIS_PERIOD_ID = T.PERIOD_ID
	AND SFF.STOCK_ID = T.STOCK_ID
WHERE FATURA_ID=#attributes.INVOICE_ID# AND FATURA_PERIOD_ID=#session.EP.PERIOD_ID#

  
  

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
    


    function Ekle(INVOICE_ID,DSN2,EMPLOYEE_ID,FAT_PERIOD_ID) {
        var B=document.getElementById("BEYAN").value;
        var FIS_ID=list_getat(B,1,"-")
        var STOCK_ID=list_getat(B,2,"-")
        var PERIOD_ID=list_getat(B,3,"-")
        var AMOUNT=document.getElementById("KULLAN").value;
        $.ajax({
            url:"/AddOns/Partner/Servis/GeneralFunctions.cfc?method=SaveFatFis",
            data:{
                FIS_ID:FIS_ID,
                STOCK_ID:STOCK_ID,
                AMOUNT:AMOUNT,
                INVOICE_ID:INVOICE_ID,
                DSN2:DSN2,
                DSN3:dsn3,
                EMPLOYEE_ID:EMPLOYEE_ID,
                PERIOD_ID:PERIOD_ID,
                FATURA_PERIOD_ID:FAT_PERIOD_ID
                
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
