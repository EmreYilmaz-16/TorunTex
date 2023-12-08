<cfquery name="getHarekets" datasource="#dsn2#">
SELECT * FROM STOCK_FIS
</cfquery>
<cfset fis_sayisi=0>
<cfloop query="getHarekets">
    <cfset fis_sayisi=fis_sayisi+1>
    <cfset attributes.del_fis =1>
    <cfset attributes.process_cat=PROCESS_CAT>
    <cfset attributes.cat=PROCESS_TYPE>
    <cfset attributes.type_id=PROCESS_TYPE>
    <cfset attributes.UPD_ID=UPD_ID>
    <cfset attributes.old_process_type=PROCESS_TYPE>
    <cfset attributes.FIS_NO =FIS_NUMBER>
    <cfset form.process_cat=PROCESS_CAT>
    <cfset form.cat=PROCESS_TYPE>
    <cfset form.type_id=PROCESS_TYPE>
    <cfset form.UPD_ID=UPD_ID>
    <cfset form.old_process_type=PROCESS_TYPE>
    <cfinclude template="/v16/stock/query/upd_fis_1_pbs.cfm">        
</cfloop>