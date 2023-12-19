<cfdump var="#attributes#">
<cfset FormData=deserializeJSON(attributes.data)>
<cfdump var="#FormData#">
<cfset i=1>
<cfset attributes.ROWW="">
<cfset qty=FormData.FROM_AMOUNT>
<cfset "attributes.STOCK_ID#i#"=FormData.FROM_STOCK_ID>
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
<cfinclude template="StokFisQuery.cfm">

<cfquery name="UPDA" datasource="#DSN2#">
  UPDATE 
STOCKS_ROW SET PBS_RELATION_ID='#FormData.TO_WRK_ROW_ID#'
WHERE LOT_NO = '#FormData.FROM_LOT_NO#'
	AND STOCKS_ROW_ID = (
		SELECT MAX(STOCKS_ROW_ID)
		FROM STOCKS_ROW WHERE LOT_NO = '#FormData.FROM_LOT_NO#' AND STOCK_IN <>0    
		)  
</cfquery>

<cfquery name="INS" datasource="#DSN2#">
  INSERT INTO TASIMA_SEPET(EMPLOYEE_ID,FIS_ID,IS_ACTIVE,RECORD_DATE)
  VALUES(#session.ep.userid#,#GET_ID.MAX_ID#,1,GETDATE());
</cfquery>

<cfquery name="GIRIS_DEPO" datasource="#DSN#">
  SELECT D.DEPARTMENT_HEAD,SL.COMMENT FROM STOCK_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID
  WHERE D.DEPARTMENT_ID=#FormData.TO_DEPARTMENT_ID# AND SL.LOCATION_ID=#FormData.TO_LOCATION_ID#
</cfquery>
<cfquery name="CIKIS_DEPO" datasource="#DSN#">
  SELECT D.DEPARTMENT_HEAD,SL.COMMENT FROM STOCK_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID
  WHERE D.DEPARTMENT_ID=#FormData.FROM_DEPARTMENT_ID# AND SL.LOCATION_ID=#FormData.FROM_LOCATION_ID#
</cfquery>
<cfquery name="getProduct" datasource="#dsn3#">
  SELECT * FROM STOCKS WHERE STOCK_ID=#FormData.FROM_STOCK_ID#
</cfquery>
<cfset FROM_ORDER_NO="">
<cfset TO_ORDER_NO="">
<cfif LEN(FormData.FROM_WRK_ROW_ID)>
  <cfquery name="getorder" datasource="#dsn3#">
    SELECT ORDER_NUMBER FROM ORDERS AS O INNER JOIN ORDER_ROW AS ORR ON ORR.ORDER_ID=O.ORDER_ID WHERE ORR.WRK_ROW_ID='#FormData.FROM_WRK_ROW_ID#'
  </cfquery>
  <CFSET FROM_ORDER_NO=getorder.ORDER_NUMBER>
</cfif>

<cfif LEN(FormData.TO_WRK_ROW_ID)>
  <cfquery name="getorder" datasource="#dsn3#">
    SELECT ORDER_NUMBER FROM ORDERS AS O INNER JOIN ORDER_ROW AS ORR ON ORR.ORDER_ID=O.ORDER_ID WHERE ORR.WRK_ROW_ID='#FormData.TO_WRK_ROW_ID#'
  </cfquery>
  <CFSET TO_ORDER_NO=getorder.TO_WRK_ROW_ID>
</cfif>

<cfoutput>
<script>
  window.opener.sepeteEkle("#getProduct.PRODUCT_CODE#","#getProduct.PRODUCT_NAME#",#FormData.FROM_AMOUNT#,"KG","#CIKIS_DEPO.DEPARTMENT_HEAD#-#CIKIS_DEPO.COMMENT#","#GIRIS_DEPO.DEPARTMENT_HEAD#-#GIRIS_DEPO.COMMENT#","#FormData.FROM_LOT_NO#",1,"#FormData.FROM_UNIT2#",#GET_ID.MAX_ID#,"#attributes.FIS_NO#","#FROM_ORDER_NO#","#TO_ORDER_NO#")
this.close();
</script>
</cfoutput>
<!----
  w3Toruntex_2023_1.TASIMA_SEPET(ID INT PRIMARY KEY IDENTITY(1,1),EMPLOYEE_ID INT,FIS_ID INT,IS_ACTIVE BIT,RECORD_DATE DATETIME)
<cfscript>
    structClear(attributes);
</cfscript>

<cfset i=1>
<cfset attributes.ROWW="">
<cfset qty=FormData.TO_AMOUNT>
<cfset "attributes.STOCK_ID#i#"=FormData.TO_STOCK_ID>
<cfset "attributes.amount_other#i#"="">
<cfset "attributes.unit_other#i#"="">
<cfset "attributes.lot_no#i#"="#FormData.TO_LOT_NO#">
<cfset "attributes.QUANTITY#i#"=FormData.TO_AMOUNT>
<cfset "attributes.uniq_relation_id_#i#"=FormData.TO_WRK_ROW_ID>
<cfset "attributes.PBS_RELATION_ID#i#"=FormData.TO_WRK_ROW_ID>
<cfset attributes.ROWW="#attributes.ROWW#,#i#">
<cfset attributes.department_out ="">
    <cfset attributes.LOCATION_OUT="">
    <cfset attributes.department_in=FormData.TO_DEPARTMENT_ID>
    <cfset attributes.LOCATION_IN =FormData.TO_LOCATION_ID>
    <cfset form.process_cat=87>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset amount_other="">
   <cfset unit_other="">  
   <cfset attributes.wodate="1">
   <cfset attributes.clot=1>
   <cfset arguments.LOT_NUMARASI=FormData.TO_LOT_NO>
<cfinclude template="StokFisQuery.cfm">
---->