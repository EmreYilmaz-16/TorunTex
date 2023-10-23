<cf_box title="Üretim Ağacı" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfdump var="#attributes#">    
    <cfquery name="getShelwes" datasource="#dsn3#">
        select * from PRODUCT_PLACE_ROWS AS PPR 
        LEFT JOIN PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=PPR.PRODUCT_PLACE_ID
        WHERE PPR.STOCK_ID=#attributes.STOCK_ID#

    </cfquery>
        <input type="hidden" name="PRODUCT_PLACE_ID" id="PRODUCT_PLACE_ID">
        <input type="hidden" name="STORE_ID" id="STORE_ID">
        <input type="hidden" name="LOCATION_ID" id="LOCATION_ID">
        <input type="text" name="Search" id="Search">
        <div id="resultDiv">
        </div>
    <cfdump var="#getShelwes#">
    <script>
        var Masalar=[
            <cfoutput query="getShelwes">
                {
                    PRODUCT_PLACE_ID:#PRODUCT_PLACE_ID#,
                    SHELF_CODE:'<cfif len(STORE_ID) eq 1>0#STORE_ID#<cfelse>#STORE_ID#</cfif>-<cfif len(LOCATION_ID) eq 1>0#LOCATION_ID#<cfelse>#LOCATION_ID#</cfif>-#SHELF_CODE#',
                    STORE_ID:#STORE_ID#,
                    LOCATION_ID:#LOCATION_ID#
                },
            </cfoutput>
        ]
        console.log(Masalar);
    function SearchRaf(keyword) {
        var YeniArr=null
        if(keyword.length>3){
             YeniArr=Masalar.filter(p=>p.SHELF_CODE.indexOf(keyword) !=-1)}else if(keyword.length==0){
                YeniArr=Masalar; 
        }
        createRafElem(YeniArr)
    }
    function createRafElem(){

    }
    </script>

</cf_box>