<cfset alowed_list="593,146,144,145">
<cfif not listFind(alowed_list,session.ep.userid)>
    <cf_box title="Toplu Taşıma">
    <div class="alert alert-danger">
        Bu Sayfayı Görüntülemeye Yetkili Değilsiniz !
    </div>
    <button class="btn btn-outline-danger" onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')" type="button">Kapat</button>
</cf_box>
    <cfabort>
</cfif>
<cf_box title="Toplu Taşıma">
<cfparam name="attributes.MODAL_ID" default="0">
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
        SELECT SUM(STOCK_IN-STOCK_OUT),LOT_NO,STOCK_ID,PRODUCT_ID FROM w3Toruntex_2024_1.STOCKS_ROW WHERE STORE=#listGetAt(attributes.LOC_OUT,1,"-")# AND STORE_LOCATION=#listGetAt(attributes.LOC_OUT,2,"-")#  GROUP BY LOT_NO,STOCK_ID,PRODUCT_ID HAVING SUM(STOCK_IN-STOCK_OUT)>0
    </cfquery>
    <cfdump var="#getLOTS#">



    <cfset attributes.fis_type = get_process_type.PROCESS_TYPE>

<cfset ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
<cfset attributes.fis_date=now()>
<cfset attributes.fis_date_h=0>
<cfset attributes.fis_date_m=0>

<cfset attributes.PROD_ORDER = ''>  
<cfset attributes.PROD_ORDER_NUMBER = ''>  
<cfset attributes.PROJECT_HEAD = ""> 
<cfset attributes.PROJECT_HEAD_IN = "">  
<cfset attributes.PROJECT_ID = "">  
<cfset attributes.PROJECT_ID_IN = ""> 
<cfset attributes.member_type='' >
<cfset attributes.member_name='' >
<cfset ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
<cfset ATTRIBUTES.FIS_DATE_H  ="00">
<cfset ATTRIBUTES.FIS_DATE_M  ="0">
<cfset attributes.rows_=getLOTS.recordCount>
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
        <cfset 'attributes.row_unique_relation_id#ix#'="">
        <cfset "attributes.amount_other#ix#"=1>
        <cfset "attributes.unit_other#ix#"="Adet">
        <cfset "attributes.lot_no#ix#"=LOT_NO>
        <cfset ix=ix+1>
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
<cfabort>
</cfif>

<cfquery name="getDoluDepolar" datasource="#dsn#">
    select STORE_LOCATION,STORE,COMMENT,COUNT(*) from (
SELECT T.*,SL.COMMENT FROM (
select SUM(STOCK_IN-STOCK_OUT) VB,LOT_NO,STORE,STORE_LOCATION from #dsn2#.STOCKS_ROW WHERE STORE IN(14,15) GROUP BY LOT_NO,STORE,STORE_LOCATION


) AS T 

LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=T.STORE AND SL.LOCATION_ID=T.STORE_LOCATION
WHERE VB>0



) as TT  GROUP BY STORE_LOCATION,STORE,COMMENT HAVING COUNT(*) >0


ORDER BY COMMENT
</cfquery>

<cfquery name="getTDepolar" datasource="#dsn#">
    select COMMENT,DEPARTMENT_ID as STORE,LOCATION_ID AS STORE_LOCATION from w3Toruntex.STOCKS_LOCATION where DEPARTMENT_ID IN (15)
</cfquery>

<table class="table">
    <tr>
        <td>            
            <div class="form-group">
                <select name="FromLocationId" id="FromLocationId">
                    <option value="">Seçiniz</option>
                    <cfoutput query="getDoluDepolar">
                        <option value="#STORE#-#STORE_LOCATION#">#COMMENT#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>            
            <div class="form-group">
                <select name="ToLocationId" id="ToLocationId">
                    <option value="">Seçiniz</option>
                    <cfoutput query="getTDepolar">
                        <option <CFIF STORE_LOCATION NEQ 15> style="color:red" disabled</CFIF> value="#STORE#-#STORE_LOCATION#">#COMMENT#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>
            <button onclick="Tasi('<cfoutput>#attributes.modal_id#</cfoutput>')" class="btn btn-outline-success" type="button">Taşıma Yap</button>
            <button class="btn btn-outline-danger" onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')" type="button">Kapat</button>
            
        </td>
    </tr>
</table>

<script>
    function Tasi(params) {
        var FromLocationId=$("#FromLocationId").val();
        var ToLocationId=$("#ToLocationId").val();
        var LOC_IN=ToLocationId
        var LOC_OUT=FromLocationId
        
        if(LOC_IN.length>0 && LOC_OUT.length>0){
        $.ajax({
            url:"/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=64&tasima=1",
            data:{
                LOC_IN:LOC_IN,
                LOC_OUT:LOC_OUT
            }
        }).done(function (params) {
            alert("Taşıma Başarılı");
            closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')
        })
    }else{
        alert("Seçilmemiş Depolar Var")
    } 

    }

    
</script>


</cf_box>