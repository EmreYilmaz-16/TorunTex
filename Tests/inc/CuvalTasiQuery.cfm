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
    <cfset form.process_cat=255>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset amount_other="">
   <cfset unit_other="">  
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
		FROM STOCKS_ROW WHERE LOT_NO = '#FormData.FROM_LOT_NO#'
		)     
</cfquery>
<!----
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