<cfif isDefined("attributes.tasima")>
    <cfparam name="attributes.clot" default="0">
    <cfset attributes.department_in =listGetAt(attributes.LOC_IN,1,"-")>
    <cfset attributes.LOCATION_IN=listGetAt(attributes.LOC_IN,2,"-")>
    <cfset attributes.department_out=listGetAt(attributes.LOC_OUT,1,"-")>
    <cfset attributes.LOCATION_OUT =listGetAt(attributes.LOC_OUT,2,"-")>
    <cfset form.process_cat=294>
    <cfset attributes.process_cat = form.process_cat>

    <cfset attributes.ACTIVE_PERIOD =session.ep.period_id>
    <cfquery name="SS" datasource="#DSN3#">
        UPDATE GENERAL_PAPERS SET STOCK_FIS_NUMBER=STOCK_FIS_NUMBER+1 WHERE STOCK_FIS_NUMBER IS NOT NULL
        select STOCK_FIS_NO,STOCK_FIS_NUMBER from GENERAL_PAPERS
    </cfquery>
    <cfinclude template="/v16/stock/query/check_our_period.cfm"> 
    <cfinclude template="/v16/stock/query/get_process_cat.cfm">  
    
   <cfquery name="getLOTS" datasource="#dsn2#">
        SELECT SUM(STOCK_IN-STOCK_OUT),LOT_NO,STOCK_ID,PRODUCT_ID,SHELF_NUMBER FROM w3Toruntex_2024_1.STOCKS_ROW WHERE STORE=18 AND STORE_LOCATION=#listGetAt(attributes.LOC_OUT,2,"-")# AND SHELF_NUMBER IS NOT NULL GROUP BY LOT_NO,SHELF_NUMBER,STOCK_ID,PRODUCT_ID HAVING SUM(STOCK_IN-STOCK_OUT)>0
    </cfquery>
    <cfdump var="#getLOTS#">



    <cfset attributes.fis_type = get_process_type.PROCESS_TYPE>

<cfset ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
<cfset attributes.fis_date=now()>
<cfset attributes.fis_date_h=0>
<cfset attributes.fis_date_m=0>

<cfset attributes.PROD_ORDER = ''>  
<cfset attributes.PROD_ORDER_NUMBER = ''>  
<cfset attributes.PROJECT_HEAD = PROJECT_HEAD> 
<cfset attributes.PROJECT_HEAD_IN = PROJECT_HEAD_IN>  
<cfset attributes.PROJECT_ID = PROJECT_ID>  
<cfset attributes.PROJECT_ID_IN = PROJECT_ID_IN> 
<cfset attributes.member_type='' >
<cfset attributes.member_name='' >
<cfset ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
<cfset ATTRIBUTES.FIS_DATE_H  ="00">
<cfset ATTRIBUTES.FIS_DATE_M  ="0">
<cfset attributes.rows_=getSinfo.recordCount>
    <cfset ix=1>
    <cfloop query="getLOTS">
        <cfquery name="getSinfo" datasource="#dsn3#">                            
            select PRODUCT_UNIT.MAIN_UNIT,STOCKS.PRODUCT_UNIT_ID,STOCKS.TAX,STOCKS.PRODUCT_ID,STOCKS.IS_INVENTORY from #dsn3#.STOCKS 
            left join #dsn3#.PRODUCT_UNIT on PRODUCT_UNIT.PRODUCT_ID=STOCKS.PRODUCT_ID and IS_MAIN=1                            
            where STOCK_ID=#STOCK_ID#
        </cfquery>
        <cfset 'attributes.stock_id#ix#' = STOCK_ID>
        <cfset 'attributes.amount#ix#' = 1>
        <cfset 'attributes.unit#ix#' = getSinfo.MAIN_UNIT>
        <cfset 'attributes.unit_id#ix#' = getSinfo.PRODUCT_UNIT_ID>
        <cfset 'attributes.tax#ix#' = getSinfo.TAX>
        <cfset 'attributes.product_id#ix#' = getSinfo.PRODUCT_ID>
        <cfset 'attributes.is_inventory#ix#' = getSinfo.IS_INVENTORY>
        <cfset 'attributes.WRK_ROW_ID#ix#' = "#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">
        <cfset 'attributes.row_unique_relation_id#ix#'=ROW_UNIQ_RELATION>
        <cfset "attributes.amount_other#ix#"=1>
        <cfset "attributes.unit_other#ix#"="Adet">
        <cfset "attributes.lot_no#ix#"=LOT_NO>
    </cfloop>
    <cfset attributes.wodate=1>
    <cfif isDefined("attributes.wodate")>
  
        <cfinclude template="/v16/stock/query/add_ship_fis_1_PBSWoDate.cfm">    
        <cfinclude template="/v16/stock/query/add_ship_fis_2_PBSWoDate.cfm">
      <cfelse>
        <cfinclude template="/v16/stock/query/add_ship_fis_1_PBS.cfm">    
        <cfinclude template="/v16/stock/query/add_ship_fis_2_PBS.cfm">
      </cfif>
      
      
      <cfif isdefined("attributes.rows_")>            
          <cfinclude template="/v16/stock/query/add_ship_fis_3_PBS.cfm">
          <cfinclude template="/v16/stock/query/add_ship_fis_4_PBS.cfm">                    
      <cfelse>
          <cfquery name="ADD_STOCK_FIS_ROW" datasource="#dsn2#">
              INSERT INTO STOCK_FIS_ROW (FIS_NUMBER,FIS_ID) VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#FIS_NO#">,#GET_ID.MAX_ID#)
          </cfquery>
      </cfif>   
    
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