
<cfparam name="attributes.clot" default="0">
<cfset attributes.department_in =listGetAt(attributes.IN_STORE,1,"-")>
<cfset attributes.LOCATION_IN=listGetAt(attributes.IN_STORE,2,"-")>
<cfset attributes.department_out=listGetAt(attributes.OUT_STORE,1,"-")>
<cfset attributes.LOCATION_OUT =listGetAt(attributes.OUT_STORE,2,"-")>
<cfset form.process_cat=303>
<cfset attributes.process_cat = form.process_cat>

<cfset attributes.ACTIVE_PERIOD =session.ep.period_id>
<cfquery name="SS" datasource="#DSN3#">
    UPDATE GENERAL_PAPERS SET STOCK_FIS_NUMBER=STOCK_FIS_NUMBER+1 WHERE STOCK_FIS_NUMBER IS NOT NULL
    select STOCK_FIS_NO,STOCK_FIS_NUMBER from GENERAL_PAPERS
</cfquery>

<cfinclude template="/v16/stock/query/check_our_period.cfm"> 
<cfinclude template="/v16/stock/query/get_process_cat.cfm">

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
<cfset attributes.rows_=listLen(attributes.row)>

<cfloop list="#attributes.row#" item="ix">
    <cfset STOCK_ID = evaluate("form.stock_id_" & ix)>
    <cfset LOT_NO = evaluate("form.lot_no_" & ix)>
    <cfset BAKIYE = evaluate("form.bakiye_" & ix)>

    <cfquery name="getSinfo" datasource="#dsn3#">                            
        select PRODUCT_UNIT.MAIN_UNIT,STOCKS.PRODUCT_UNIT_ID,STOCKS.TAX,STOCKS.PRODUCT_ID,STOCKS.IS_INVENTORY from #dsn3#.STOCKS 
        left join #dsn3#.PRODUCT_UNIT on PRODUCT_UNIT.PRODUCT_ID=STOCKS.PRODUCT_ID and IS_MAIN=1                            
        where STOCK_ID=#STOCK_ID#
    </cfquery>
    <cfset 'attributes.stock_id#ix#' = STOCK_ID>
    <cfset 'attributes.amount#ix#' = BAKIYE>
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