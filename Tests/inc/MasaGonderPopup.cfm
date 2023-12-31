<cf_box title="Masaya Gönder" scroll="1" collapsable="1" resize="1" popup_box="1">
    
    <cfquery name="getShelwes" datasource="#dsn3#">
        select * from PRODUCT_PLACE_ROWS AS PPR 
        LEFT JOIN PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=PPR.PRODUCT_PLACE_ID
        WHERE PPR.STOCK_ID=#attributes.STOCK_ID#

    </cfquery>
    <div style="display:none">
        <input type="hidden" name="PRODUCT_PLACE_ID" id="PRODUCT_PLACE_ID">
        <input type="hidden" name="STORE_ID" id="STORE_ID">
        <input type="hidden" name="LOCATION_ID" id="LOCATION_ID">
        <div class="form-group">
        <label>Seçili Raf</label>
        <div class="input-group">
            <input type="Text" name="Raf" id="Raf" readonly placeholder="Seçili Raf" class="form-control form-control-sm" style="color:green !important">
            <button class="btn btn-outline-warning" onclick="clearMasa()" type="button" id="button-addon2"><span class="icn-md icon-remove"></span></button>
        </div>
        
    </div>
</div>
    <div class="form-group">
        <label>Miktar</label>
        <div class="input-group">
            <input type="text" name="We" id="We" placeholder="Miktar" class="form-control form-control-sm" style="color:green !important">
            <button class="btn btn-outline-primary" onclick="lookUpW()" type="button" id="button-addon2"><span class="icn-md icon-search"></span></button>
        </div>
        
    </div>
        <br>
        <input type="hidden" name="Search" class="form-control form-control-sm" id="Search" placeholder="Ara" onkeyup="SearchRaf(this.value)">
        <div id="resultDiv" class="list-group" style="heigth:20vh;display:none">
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
            a.setAttribute("class","list-group-item list-group-item-action");
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
        var regexp = /^\d+(\.\d{1,2})?$/;
        var Agirlik=$("#We").val();
        var ss=regexp.test(Agirlik);
if(ss==true){
        var O={
            RAF_DATA:SelectedRaf,
            STOCK_ID:STOCK_ID,
            AMOUNT:Agirlik,            
        };
        console.table(O)
        $.ajax({
            url:"/AddOns/Partner/Servis/MasaServis.cfc?method=SendMasa",
            data:JSON.stringify(O),
            success:function (retDat) {
                
            }
        })}
        else{
            alert("Ağırlık Numerik Olmalı")
        }
    }
    function clearMasa() {
        $("#Raf").val("");
        SelectedRaf=null;
    }
    </script>

</cf_box>