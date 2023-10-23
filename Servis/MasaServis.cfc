<cfcomponent>
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
   <cfset lot_no="">
   <cfset attributes.ROWW=" ,">
<CFSET attributes.STOCK_ID=FormData.STOCK_ID>
<cfinclude template="../Tests/inc/StokFisQuery.cfm">

    </cffunction>
</cfcomponent>