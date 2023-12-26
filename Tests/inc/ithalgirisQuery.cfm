<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    
    <cfquery name="GETMAXID" datasource="#DSN2#">
        SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
    </cfquery>
    <cfset attributes.rows_=attributes.ROW_COUNT>
    <cfset SHIP_NUMBER='IMG-#GETMAXID.MXIDD#'>
    <cfset attributes.ACTIVE_PERIOD=session.ep.period_id>
    
    <cfquery name="GETMAXID" datasource="#DSN2#">
        SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
    </cfquery>
    <cfquery name="getper" datasource="#dsn#">
        SELECT * FROM SETUP_PERIOD WHERE PERIOD_YEAR=#attributes.IV_DATE# AND OUR_COMPANY_ID=1
    </cfquery>
      <cfset DELIVER_IN_DEPT=listGetAt(attributes.DEP_LOC,1,"-")>
      <cfset DELIVER__IN_LOC=listGetAt(attributes.DEP_LOC,2,"-")>
      <cfset PROCESS__IN_TYPE=811>
      <cfquery name="GETSHIP_ROW" datasource="#DSN2#">
        SELECT * FROM SHIP_ROW WHERE SHIP_ID=#GETMAXID.MXIDD#
      </cfquery>
<cfset attributes.process_cat=117>
<cfset form.process_cat=117>
<cfset attributes.ship_date=now()>
<cfset attributes.deliver_date_frm=now()>

<cfset attributes.department_in_id=DELIVER_IN_DEPT> <!---- mal kabul----->
<cfset attributes.location_in_id=DELIVER__IN_LOC> <!---- mal kabul----->

<cfset attributes.location_id =1>
<cfset attributes.DEPARTMENT_ID =11> 

<cfset attributes.DELIVER_DATE_H =0>
<cfset attributes.deliver_date_m =0>

<cfset form.BASKET_RATE2=1>
<cfset form.BASKET_NET_TOTAL=0>
<cfset form.BASKET_RATE1=0>
<cfset form.basket_money="TL">
<cfquery name="getMaxIDsh" datasource="#dsn2#">
    SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
</cfquery>
<CFSET SHIP_NUMBER='IMG-0000#getMaxIDsh.MXIDD#'>

<cfloop from="1" to="#attributes.ROW_COUNT#" index="i">
    <cfset 'attributes.deliver_date#i#'=now()>
<cfquery name="getProductInfo" datasource="#dsn3#">
    SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2,S.PRODUCT_ID FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
 WHERE S.PRODUCT_ID=#evaluate("attributes.PRODUCT_ID_#i#")#
</cfquery>
<!----
<cfif isdefined('attributes.to_shelf_number#i#') and len(evaluate('attributes.to_shelf_number#i#')) and isdefined('attributes.to_shelf_number_txt#i#') and len(evaluate('attributes.to_shelf_number_txt#i#'))>#evaluate('attributes.to_shelf_number#i#')#<cfelse>NULL</cfif>,
    ----->
<cfset 'attributes.product_name#i#'=getProductInfo.PRODUCT_NAME>
<cfset 'attributes.stock_id#i#'=getProductInfo.STOCK_ID>
<cfset 'attributes.product_id#i#'=getProductInfo.PRODUCT_ID>
<cfset 'attributes.amount#i#'=evaluate('attributes.AMOUNT_#i#')>
<cfset 'attributes.unit#i#'=getProductInfo.MAIN_UNIT>
<cfset 'attributes.amount2#i#'=evaluate('attributes.AMOUNT2_#i#')>
<cfset 'attributes.unit#i#'="Çuval">
<cfset 'attributes.unit_id#i#'=getProductInfo.PRODUCT_UNIT_ID>
<cfset 'attributes.tax#i#'=0>
<cfset 'attributes.price#i#'=0>
<cfset 'attributes.row_lasttotal#i#'=0>
<cfset 'attributes.row_nettotal#i#'=0>
<cfset 'attributes.row_taxtotal#i#'=0>
<cfset 'attributes.lot_no#i#'="#evaluate('attributes.LOT_NO_#i#')#">
<cfset 'attributes.price_other#i#'=0>
<cfset 'attributes.spect_id#i#'="">
<cfset 'attributes.to_shelf_number#i#'="#evaluate('attributes.SHELF_ID_#i#')#">
<cfset 'attributes.to_shelf_number_txt#i#'="#evaluate('attributes.SHELF_ID_#i#')#">

<CFSET 'attributes.wrk_row_relation_id#i#' ="#evaluate('attributes.WRK_ROW_ID_#i#')#">
<cfset 'attributes.awrk_row_id#i#'="PBS#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">

</cfloop>
<cfquery name="getper" datasource="#dsn#">
    SELECT * FROM SETUP_PERIOD WHERE PERIOD_YEAR=#attributes.IV_DATE# AND OUR_COMPANY_ID=1
</cfquery>
<CFSET import_invoice_id="#attributes.INVOICE_ID#;#getper.PERIOD_ID#">
<cfquery name="GETK" datasource="#DSN#">
    select DISTINCT MONEY,RATE1,RATE2 from #DSN#.MONEY_HISTORY where VALIDATE_DATE=(select max(VALIDATE_DATE) FROM #DSN#.MONEY_HISTORY )
UNION
SELECT 'TL' AS MONEY,1 AS RATE1,1 AS RATE2
</cfquery>
<CFSET attributes.kur_say=GETK.recordCount>
<CFSET K=1>
<cfloop query="GETK">
    <CFSET "attributes.txt_rate2_#K#"=RATE2>
    <CFSET "attributes.txt_rate1_#K#"=RATE1>
    <CFSET "attributes.hidden_rd_money_#K#"=MONEY>
    <CFSET K=K+1>
</cfloop>
<CFSET attributes.BASKET_MONEY ="TL">
<cfinclude template="/V16/stock/query/add_stock_in_from_customs_PBS.cfm">
<cfquery name="GETMAXID" datasource="#DSN2#">
    SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
</cfquery>

<cfset DELIVER_IN_DEPT=1>
<cfset DELIVER__IN_LOC=2>
<cfset PROCESS__IN_TYPE=811>
<cfquery name="GETSHIP_ROW" datasource="#DSN2#">
  SELECT * FROM SHIP_ROW WHERE SHIP_ID=#GETMAXID.MXIDD#
</cfquery>
<CFLOOP query="GETSHIP_ROW" >
<cfquery name="getProductInfo" datasource="#dsn3#">
SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,S.PRODUCT_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2 FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
WHERE S.PRODUCT_ID=#PRODUCT_ID#
</cfquery>
<cfquery name="INS3" datasource="#DSN2#">
INSERT INTO STOCKS_ROW (STOCK_ID,PRODUCT_ID,UPD_ID,PROCESS_TYPE,STOCK_IN,STORE,STORE_LOCATION,LOT_NO,PROCESS_DATE,PROCESS_TIME) VALUES(#getProductInfo.STOCK_ID#,#getProductInfo.PRODUCT_ID#,#SHIP_ID#,#PROCESS__IN_TYPE#,1,#DELIVER_IN_DEPT#,#DELIVER__IN_LOC#,'#LOT_NO#',CONVERT(DATE,GETDATE()),GETDATE())
</cfquery>

</CFLOOP> 

<cfquery name="UP" datasource="#DSN2#">
    UPDATE SHIP_ROW SET IMPORT_INVOICE_ID=#attributes.INVOICE_ID#,IMPORT_PERIOD_ID=#getper.PERIOD_ID#  WHERE SHIP_ID=#GETMAXID.MXIDD#
</cfquery>

        <cfquery name="UP" datasource="#DSN2#">
            UPDATE INVOICE_SHIPS SET IMPORT_INVOICE_ID=#attributes.INVOICE_ID#,IMPORT_PERIOD_ID=#getper.PERIOD_ID# WHERE SHIP_ID=#GETMAXID.MXIDD#
        </cfquery>
<script>
  window.location.href="/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=36";
</script>
</cfif>