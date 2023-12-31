<cfquery name="getHarekets" datasource="#dsn2#">
SELECT * FROM STOCK_FIS AS SF WHERE  PROCESS_CAT=294 <cfif isDefined("attributes.SEPET_ID")>
    AND FIS_ID IN(SELECT FIS_ID FROM w3Toruntex_1.SEPET_FIS_RELATIONS WHERE SEPET_ID=#attributes.SEPET_ID# )
</cfif>
</cfquery>

<cfset fis_sayisi=0>
<cfloop query="getHarekets">
    <cfset fis_sayisi=fis_sayisi+1>
    <cfset attributes.del_fis =1>
    <cfset attributes.process_cat=PROCESS_CAT>
    <cfset attributes.cat=FIS_TYPE>
    <cfset attributes.type_id=FIS_TYPE>
    <cfset attributes.UPD_ID=FIS_ID>
    <cfset attributes.old_process_type=FIS_TYPE>
    <cfset attributes.FIS_NO =FIS_NUMBER>
    <cfset form.process_cat=PROCESS_CAT>
    <cfset form.cat=FIS_TYPE>
    <cfset form.type_id=FIS_TYPE>
    <cfset form.UPD_ID=FIS_ID>
    <cfset form.old_process_type=FIS_TYPE>
    <cfinclude template="/v16/stock/query/upd_fis_1_pbs.cfm">        
</cfloop>