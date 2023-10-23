<cf_box title="Üretim Ağacı" scroll="1" collapsable="1" resize="1" popup_box="1">
    
    <cfquery name="getShelwes" datasource="#dsn3#">
        select * from PRODUCT_PLACE_ROWS AS PPR 
        LEFT JOIN PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=PPR.PRODUCT_PLACE_ID
        WHERE PPR.STOCK_ID=#attributes.STOCK_ID#

    </cfquery>
        <input type="hidden" name="PRODUCT_PLACE_ID" id="PRODUCT_PLACE_ID">
        <input type="hidden" name="STORE_ID" id="STORE_ID">
        <input type="hidden" name="LOCATION_ID" id="LOCATION_ID">
        <input type="Text" name="Raf" id="Raf" readonly placeholder="Seçili Raf" class="form-control form-control-sm" style="color:green !important">
        <br>
        <input type="text" name="Search" class="form-control form-control-sm" id="Search" placeholder="Ara" onkeyup="SearchRaf(this.value)">
        <div id="resultDiv" class="list-group" style="heigth:20vh">
        </div>
    <button class="btn btn-outline-success" onclick="KaydetCanim(<cfoutput>#attributes.STOCK_ID#</cfoutput>)">Gönder</button>
    
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
    $(document).ready(function(){
        createRafElem(Masalar);
    })
        function SearchRaf(keyword) {
        var YeniArr=null
        if(keyword.length>2){
             YeniArr=Masalar.filter(p=>p.SHELF_CODE.indexOf(keyword) !=-1)}else if(keyword.length==0){
                YeniArr=Masalar; 
        }
        createRafElem(YeniArr)
    }
    function createRafElem(arr){
        $("#resultDiv").html("");
        for(let i=0;i<arr.length;i++){
            var a=document.createElement("a");
            a.setAttribute("class","list-group-item");
            a.innerText=arr[i].SHELF_CODE
            a.setAttribute("data-PRODUCT_PLACE_ID",arr[i].PRODUCT_PLACE_ID)
            a.setAttribute("data-STORE_ID",arr[i].STORE_ID)
            a.setAttribute("data-LOCATION_ID",arr[i].LOCATION_ID)
            a.setAttribute("onclick","SelectRaf(this)")
            document.getElementById("resultDiv").appendChild(a);            
        }
    }
    var SelectedRaf=null;
    function SelectRaf(raf,STOCK_ID){
        var STORE_ID=raf.getAttribute("data-STORE_ID");
        var PRODUCT_PLACE_ID=raf.getAttribute("data-PRODUCT_PLACE_ID");
        var LOCATION_ID=raf.getAttribute("data-LOCATION_ID");        
        var O={
            STORE_ID:STORE_ID,
            PRODUCT_PLACE_ID:PRODUCT_PLACE_ID,
            LOCATION_ID:LOCATION_ID
        }
        $("#Raf").val(raf.innerText);
        SelectedRaf=O
    }
    function KaydetCanim(STOCK_ID) {
        
        var O={
            RAF_DATA:SelectedRaf,
            STOCK_ID:STOCK_ID
        };
        console.table(O)
    }
    </script>

</cf_box>