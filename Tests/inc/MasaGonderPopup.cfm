<cf_box title="Üretim Ağacı" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfdump var="#attributes#">    
    <cfquery name="getShelwes" datasource="#dsn3#">
        select * from PRODUCT_PLACE_ROWS AS PPR 
        LEFT JOIN PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=PPR.PRODUCT_PLACE_ID
        WHERE PPR.STOCK_ID=#attributes.STOCK_ID#

    </cfquery>
    <cfdump var="#getShelwes#">
</cf_box>