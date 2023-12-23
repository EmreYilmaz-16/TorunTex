<cfdump var="#attributes#">


<cfabort>



<cfdump var="#FormData#">

<cfset attributes.LOCATION_IN=    3>
<cfset attributes.department_in = 7>

<cfset attributes.LOCATION_OUT=   listGetAt(attributes.DEP_LOC,2,"-")>
<cfset attributes.department_out= listGetAt(attributes.DEP_LOC,1,"-")>
<cfset form.process_cat=255>
<cfset attributes.process_cat = form.process_cat>
<cfset PROJECT_HEAD="">
<cfset PROJECT_HEAD_IN="">
<cfset PROJECT_ID="">
<cfset PROJECT_ID_IN="">
<cfset amount_other="">
<cfset unit_other="">
<cfset ROWC=0>
<cfloop array="#FormData.ROWS#" item="it" index="i">
    <CFSET ROWC++>
  <cfset attributes.RAF_KODU_GIRIS=FormData.SHELFDATA.SHELF_CODE>
  <cfset attributes.RAF_ID_GIRIS=FormData.SHELFDATA.SHELF_ID>
  <CFSET "attributes.STOCK_ID#i#"=it.STOCK_ID>
  <CFSET "attributes.PRODUCT_ID#i#"=it.PRODUCT_ID>
  <cfset "attributes.lot_no#i#"=it.LOT_NO>
  <cfset "attributes.QUANTITY#i#"=it.AMOUNT>
</cfloop>
<cfset attributes.ROWW=" ,">
<cfset ROW_COUNT=ROWC>
<cfinclude template="StokFisQuery_3.cfm">