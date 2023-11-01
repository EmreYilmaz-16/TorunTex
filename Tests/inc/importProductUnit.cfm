<cfquery name="getProducts" datasource="#dsn3#">
    SELECT * FROM STOCKS WHERE PRODUCT_CODE LIKE 'PRO.%'
</cfquery>

<cfoutput query="getProducts">
    <cfquery name="GETPUN" datasource="#DSN1#">
        select * from PRODUCT_UNIT WHERE PRODUCT_ID=#PRODUCT_ID#
    </cfquery>
    <cfif GETPUN.recordCount eq 1>
    
    <cfquery name="INS" datasource="#dsn1#" result="RES">
    INSERT INTO w3Toruntex_product.PRODUCT_UNIT (ADD_UNIT,IS_ADD_UNIT,IS_MAIN,IS_SHIP_UNIT,MAIN_UNIT,MAIN_UNIT_ID,MULTIPLIER,PACKAGE_CONTROL_TYPE,PRODUCT_ID,RECORD_DATE,RECORD_EMP,UNIT_ID)
    SELECT ADD_UNIT,IS_ADD_UNIT,IS_MAIN,IS_SHIP_UNIT,MAIN_UNIT,MAIN_UNIT_ID,MULTIPLIER,PACKAGE_CONTROL_TYPE,#PRODUCT_ID#,GETDATE(),#session.ep.userid#,UNIT_ID FROM w3Toruntex_product.PRODUCT_UNIT WHERE PRODUCT_ID=6 AND IS_MAIN=0
</cfquery>
<cfdump var="#RES#">
</cfif>

</cfoutput>