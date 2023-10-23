<cf_box title="Üretim Ağacı" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfdump var="#attributes#">    
    <cfquery name="getShelwes" datasource="#dsn3#">
        select * from PRODUCT_PLACE_ROWS AS PPR 
        LEFT JOIN PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=PPR.PRODUCT_PLACE_ID
        WHERE PPR.STOCK_ID=#attributes.STOCK_ID#

    </cfquery>
    <cfdump var="#getShelwes#">
    <script>
        var Masalar=[
            <cfoutput query="getShelwes">
                {
                    PRODUCT_PLACE_ID:#PRODUCT_PLACE_ID#,
                    SHELF_CODE:'#STORE_ID#-#LOCATION_ID#-#SHELF_CODE#'
                },
            </cfoutput>
        ]
        console.log(Masalar);
    </script>
</cf_box>