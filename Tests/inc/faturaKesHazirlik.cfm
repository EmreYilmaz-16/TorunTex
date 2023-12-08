<cfquery name="getCekiListesi" datasource="#dsn3#">
    SELECT * FROM w3Toruntex_1.SEVKIYAT_SEPET_ROW_PBS SSRP
LEFT JOIN w3Toruntex_1.SEVKIYAT_SEPET_ROW_READ_PBS AS SSRRP ON SSRP.SEPET_ROW_ID=SSRRP.SEPET_ROW_ID
WHERE SEPET_ID=#attributes.SEPET_ID# ORDER BY PRODUCT_ID
</cfquery>

<CFSET attributes.ROW_=getCekiListesi.recordCount>
<CFSET IX=1>
<cfloop query="getCekiListesi">
    <cfset "attributes.PRODUCT_ID#IX#"=PRODUCT_ID>
</cfloop>