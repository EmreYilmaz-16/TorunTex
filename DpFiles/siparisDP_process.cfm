
<script>
    function process_cat_dsp_function(){
        var Eet=AyniUrunKontrol();
        if(Eet){
            return true;
        }else{
            return false;
        }
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
</script>
