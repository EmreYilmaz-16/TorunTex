<cfset attributes.agirlikHesapla=0>
<script>
var Dsn3="<cfoutput>#dsn3#</cfoutput>";
    $(document).on('ready',function(){
   /* var fatid=getParameterByName('order_id');
    var btn=document.createElement("span")
    btn.setAttribute("class","input-group-addon btnPointer icon-ellipsis")
    btn.setAttribute("style","background:#6a6a6a;color:white")
    btn.setAttribute("onclick","pencereac(1,"+fatid+")")
    $($(document.getElementById("item-deliver_dept_name")).find(".input-group").find("span")).remove();
    $(document.getElementById("item-deliver_dept_name")).find(".input-group")[0].appendChild(btn)*/
    try{
        basketManager.getBasketJSON();
        var Div=document.createElement("div")
        Div.setAttribute("style","display:flex;justify-content: flex-end;")
        $(Div).html("<code style='color:red'>Basket Versiyon 2'de Butonlar Çalışmaz !</code>")
        document.getElementById("detail_inv_menu").prepend(Div)
    }catch{
        SayfayaButonEkle();
    }
    
    })
    
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
    function AyniUrunKontrol() {
        var Arr = new Array();
        //window.basket.items
        var Hata = false;
        for (let index = 0; index < window.basket.items.length; index++) {
            var BasketItem = window.basket.items[index];
            var Pid = BasketItem.PRODUCT_ID;
        // console.log(BasketItem.PRODUCT_ID);
            //console.log(Arr.find((p) => p == Pid));
            if (Arr.find((p) => p == Pid)) {
            Hata = true;
            } else {
            Arr.push(Pid);
            }
        }
        if (Hata) {
            alert("Sepette Aynı Olan Ürünler Var");
            return false;
        } else {
            return true;
        }
    }
    function SatirAgirliklariniYaz(satir_id="") {
        if(satir_id != ""){
            var index=satir_id
            var BasketItem = window.basket.items[index];
            console.log(BasketItem);
            var Sel = document.createElement("select");
            $(Sel).html(BasketItem.BASKET_EXTRA_INFO_);
            console.log(Sel);
            $(Sel).val(BasketItem.BASKET_EXTRA_INFO);
            var PKG_ = Sel.options[Sel.selectedIndex].innerText;
            var PKG = parseInt(PKG_);
            console.log(PKG);
            var Res = PKG * BasketItem.AMOUNT_OTHER;
            console.log(Res);
            window.basket.items[index].AMOUNT = Res;
            hesapla("Amount", index);
        }else{
        for (let index = 0; index < window.basket.items.length; index++) {
            var BasketItem = window.basket.items[index];
            console.log(BasketItem);
            var Sel = document.createElement("select");
            $(Sel).html(BasketItem.BASKET_EXTRA_INFO_);
            console.log(Sel);
            $(Sel).val(BasketItem.BASKET_EXTRA_INFO);
            var PKG_ = Sel.options[Sel.selectedIndex].innerText;
            var PKG = parseInt(PKG_);
            console.log(PKG);
            var Res = PKG * BasketItem.AMOUNT_OTHER;
            console.log(Res);
            window.basket.items[index].AMOUNT = Res;
            hesapla("Amount", index);
        }}
    }
    function PaketAgirlikGetir() {
  for (let index = 0; index < window.basket.items.length; index++) {
    var BasketItem = window.basket.items[index];
    var Pid = BasketItem.PRODUCT_ID;
    var QueryResult = wrk_safe_query("getProductPackegeWeight", "dsn3", 1, Pid);
    console.log(QueryResult);
    var QueryResult_2 = wrk_safe_query(
      "getBasketInfoId",
      "dsn3",
      1,
      QueryResult.PROPERTY3[0]
    );
    
    document.getElementsByName("basket_extra_info")[index].value =
      QueryResult_2.BASKET_INFO_TYPE_ID[0];
      window.basket.items[index].BASKET_EXTRA_INFO=QueryResult_2.BASKET_INFO_TYPE_ID[0];
      <cfif attributes.agirlikHesapla eq 1>SatirAgirliklariniYaz(index);</cfif>
  }
 
}

    function SatirFiyatGetir() {
        var cid = document.getElementById("company_id").value; 
        for (let index = 0; index < window.basket.items.length; index++) {
            var BasketItem = window.basket.items[index];
            var Pid = BasketItem.PRODUCT_ID;
            var QueryResult = wrk_safe_query(
            "getCompanyRisk",
            "dsn",
            1,
            cid + "*" + Pid + "*"+Dsn3
            );
            if (QueryResult.recordcount > 0) {
            window.basket.items[index].PRICE_OTHER = QueryResult.PRICE[0];
            window.basket.items[index].OTHER_MONEY = QueryResult.MONEY[0];
            document.getElementsByName("other_money")[index].value=QueryResult.MONEY[0];
            hesapla("price_other", index);
            }
        }
    }    
    function pencereac(tip,idd){
        if(tip==2){
        windowopen('index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&ACTION_ID='+idd,'wide');}else if(tip==1){
            openBoxDraggable('index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=19');
        }else if(tip==3){
             windowopen('index.cfm?fuseaction=objects.popup_print_files_old&action=sales.list_order&action_id='+idd+'&print_type=73','wide');
        }else if(tip==4){
            windowopen('index.cfm?fuseaction=objects.popup_rekactions_prt&action=ORDER&action_id='+idd,'wide');
        }
    }
    function SayfayaButonEkle(){
        var Div=document.createElement("div")
var Btn=document.createElement("Button")
//Btn.innerText="Paket"
var Span=document.createElement("span")
Span.setAttribute("class","icn-md icon-filter");
Btn.appendChild(Span)
Btn.setAttribute("onclick","PaketAgirlikGetir()")
Btn.setAttribute("title","Paket Ağirliklarını Getir")
Btn.setAttribute("class"," ui-wrk-btn ui-wrk-btn-red")
Btn.setAttribute("type","button")
Div.appendChild(Btn)
var Btn=document.createElement("Button")
Btn.setAttribute("type","button")
//Btn.innerText="TıklaBeni 2"
var Span=document.createElement("span")
Span.setAttribute("class","icn-md icon-link");
Btn.appendChild(Span)
Btn.setAttribute("onclick","SatirAgirliklariniYaz()")
Btn.setAttribute("title","Satir Ağirliklarını Hesapla")
Btn.setAttribute("class"," ui-wrk-btn ui-wrk-btn-extra")
Div.appendChild(Btn)
var Btn=document.createElement("Button")
Btn.setAttribute("type","button")
//Btn.innerText="TıklaBeni 3"
var Span=document.createElement("span")
Span.setAttribute("class","icn-md icon-money");
Btn.appendChild(Span)
Btn.setAttribute("onclick","SatirFiyatGetir()")
Btn.setAttribute("title","Satir Fiyatlarını Getir")
Btn.setAttribute("class"," ui-wrk-btn ui-wrk-btn-warning")
Div.appendChild(Btn)
Div.setAttribute("style","display: flex;justify-content: flex-end;");
//var Div=document.createElement("div")
document.getElementById("add_offer_main_div").prepend(Div)

//SatirAgirliklariniYaz && PaketAgirlikGetir && SatirFiyatGetir
//icn-md icon-link
//icn-md icon-money
    }
    ///objects.popup_rekactions_prt
    </script>