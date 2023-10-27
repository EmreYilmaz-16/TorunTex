<cfcomponent>
    <cfset dsn3="w3Toruntex_1">
    <cfset dsn="w3Toruntex">
    <cfset dsn3_alias="w3Toruntex_1">
    <cfset dsn2="w3Toruntex_2023_1">
    <cfset dsn2_alias="w3Toruntex_2023_1">
    <cffunction name="SendMasa" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfdump var="#arguments#">
        <cfset F=structKeyArray(arguments)>
        <cfset FormData=deserializeJSON(f[1])>
        <cfdump var="#FormData#">
        <cfif isDefined("FormData.RAF_DATA")>
            

        <cfelse>
            
        </cfif>
    <cfset attributes.LOCATION_IN=4>
    <cfset attributes.LOCATION_OUT=7>
    <cfset attributes.department_out=7>
    <cfset attributes.department_in =7>
    <cfset form.process_cat=90>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset attributes.QUANTITY=FormData.AMOUNT>
   <cfset attributes.uniq_relation_id_="">
   <cfset amount_other="">
   <cfset unit_other="">
   <cfset lot_no="">
   <cfset attributes.ROWW=" ,">
   <cfset attributes.wodate="1">
<CFSET attributes.STOCK_ID=FormData.STOCK_ID>
<cfinclude template="../Tests/inc/StokFisQuery.cfm">

    </cffunction>

    <cffunction name="getOrders" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="PRODUCT_ID">
        <cfquery name="GETDATA" datasource="#DSN3#">
            SELECT ORR.WRK_ROW_ID,ORR.ORDER_ROW_ID,ORR.PRODUCT_ID,O.ORDER_ID,C.COMPANY_ID,O.PRIORITY_ID,O.ORDER_HEAD,O.ORDER_NUMBER,C.NICKNAME,CONVERT(INT,SP.PRIORITY) AS PP FROM ORDER_ROW AS ORR
            LEFT JOIN ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
            LEFT JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
            LEFT JOIN #DSN#.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID=O.PRIORITY_ID
            WHERE ORR.PRODUCT_ID=#arguments.PRODUCT_ID#
        </cfquery>
<CFSET RETURNARR=arrayNew(1)>
<cfloop query="getOrders">
    <CFSET ITEM={
        WRK_ROW_ID=WRK_ROW_ID,
        ORDER_ROW_ID=ORDER_ROW_ID,
        PRODUCT_ID=PRODUCT_ID,
        ORDER_ID=ORDER_ID,
        COMPANY_ID=COMPANY_ID,
        PP=PP,
        ORDER_HEAD=ORDER_HEAD,
        ORDER_NUMBER=ORDER_NUMBER,
        NICKNAME=NICKNAME
    }>
    <cfscript>
        arrayAppend(RETURNARR,ITEM);
    </cfscript>
</cfloop>
<cfreturn replace(serializeJSON(RETURNARR),"//","")>
    </cffunction>
</cfcomponent>