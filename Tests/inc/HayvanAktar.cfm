<cfif isDefined("attributes.tasima")>
    <cfquery name="getLOTS" datasource="#dsn2#">
        SELECT SUM(STOCK_IN-STOCK_OUT),LOT_NO,SHELF_NUMBER FROM w3Toruntex_2024_1.STOCKS_ROW WHERE STORE=18 AND STORE_LOCATION=#listGetAt(attributes.LOC_OUT,2,"-")# AND SHELF_NUMBER IS NOT NULL GROUP BY LOT_NO,SHELF_NUMBER HAVING SUM(STOCK_IN-STOCK_OUT)>0
    </cfquery>
    <cfdump var="#getLOTS#">
    <cfabort>
    <!----
    <cfset attributes.ROWW="">
<cfset qty=FormData.FROM_AMOUNT>
<cfset "attributes.STOCK_ID#i#"=FormData.TO_STOCK_ID>
<cfset "attributes.amount_other#i#"="">
<cfset "attributes.unit_other#i#"="">
<cfset "attributes.lot_no#i#"="#FormData.FROM_LOT_NO#">
<cfset "attributes.QUANTITY#i#"=FormData.FROM_AMOUNT>
<cfset "attributes.uniq_relation_id_#i#"=FormData.FROM_WRK_ROW_ID>
<cfset "attributes.PBS_RELATION_ID#i#"=FormData.FROM_WRK_ROW_ID>
<cfset attributes.ROWW="#attributes.ROWW#,#i#">
<cfset attributes.department_in ="#FormData.TO_DEPARTMENT_ID#">
    <cfset attributes.LOCATION_IN="#FormData.TO_LOCATION_ID#">
    <cfset attributes.department_out=FormData.FROM_DEPARTMENT_ID>
    <cfset attributes.LOCATION_OUT =FormData.FROM_LOCATION_ID>
    <cfset form.process_cat=294>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset amount_other="1">
   <cfset unit_other="#FormData.FROM_UNIT2#">  
   <cfset attributes.wodate="1">
   <cfset attributes.clot=1>
   <cfset arguments=structNew()>
   <cfset arguments.LOT_NUMARASI=FormData.FROM_LOT_NO>
<cfinclude template="StokFisQuery.cfm">----->
</cfif>

<div style="padding:10px">
<cf_box title="Canlı Hayvan Transfer">
<cfquery name="getDep" datasource="#dsn3#">
    SELECT DEPARTMENT_LOCATION,COMMENT FROM w3Toruntex.STOCKS_LOCATION WHERE DEPARTMENT_ID=18
</cfquery>
<script>
    var LocationArr=[
        <cfoutput query="getDep">
            {
                DEPARTMENT_LOCATION:"#DEPARTMENT_LOCATION#",
                COMMENT:"#COMMENT#",
            },
        </cfoutput>
    ]
</script>
<cf_grid_list>
    <tr>
        <td>    
            <div class="form-group">
                <label>Çıkış Lokasyonu</label>
                <select name="LOCATION_OUT" id="LOCATION_OUT" onchange="GetLocationIn(this)"></select>
            </div>
        </td>
    </tr>
    <tr>
        <td>    
            <div class="form-group">
                <label>Giriş Lokasyonu</label>
                <select name="LOCATION_IN" id="LOCATION_IN"></select>
            </div>
        </td>
    </tr>
<tr>
    <td>
        <button onclick="TransferEt()">Transfer Et</button>
    </td>
</tr>
</cf_grid_list>


</cf_box>

<script>
    $(document).ready(function (params) {
        for (let index = 0; index < LocationArr.length; index++) {
            const element = LocationArr[index];
            var Opt=document.createElement("option");
            Opt.value=element.DEPARTMENT_LOCATION;
            Opt.innerText=element.COMMENT;
            document.getElementById("LOCATION_OUT").appendChild(Opt)
        }
    })
    function GetLocationIn(el) {
        var Ox=LocationArr.filter(p=>p.DEPARTMENT_LOCATION != el.value)
       $("#LOCATION_IN").html("");
        for (let index = 0; index < Ox.length; index++) {
            const element = Ox[index];
            var Opt=document.createElement("option");
            Opt.value=element.DEPARTMENT_LOCATION;
            Opt.innerText=element.COMMENT;
            document.getElementById("LOCATION_IN").appendChild(Opt)
        }
    }
    function TransferEt() {
        var LOC_IN=$("#LOCATION_IN").val();
        var LOC_OUT=$("#LOCATION_OUT").val();
        $.ajax({
            url:"/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=62&tasima=1",
            data:{
                LOC_IN:LOC_IN,
                LOC_OUT:LOC_OUT
            }
        })
    }
</script>
</div>