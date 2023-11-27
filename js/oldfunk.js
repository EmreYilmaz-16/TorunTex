function getOrders(product_id) {
  if (localStorage.getItem("ACTIVE_STATION") != null) {
    var RS = localStorage.getItem("ACTIVE_STATION");
    var ls = JSON.parse(RS);
    $.ajax({
      url:
        "/AddOns/Partner/servis/MasaServis.cfc?method=getOrders&PRODUCT_ID=" +
        product_id +
        "&STATION=" +
        ls.STATION,
      success: function (retDat) {
        console.log(retDat);
        var arr = JSON.parse(retDat);
        if (arr.length != 0) {
          console.log(arr);
          var control = $select[0].selectize;
          control.clear();
          control.clearOptions();
          for (let i = 0; i < arr.length; i++) {
            /* var opt=document.createElement("option");
               opt.setAttribute("value",arr[i].ORDER_ROW_ID);
               opt.innerText=arr[i].ORDER_NUMBER;
               document.getElementById("select_2").appendChild(opt);*/
            control.addOption({
              ORDER_ROW_ID: arr[i].ORDER_ROW_ID,
              ORDER_NUMBER: arr[i].ORDER_NUMBER,
              NICKNAME: arr[i].NICKNAME,
              ORDER_HEAD: arr[i].ORDER_HEAD,
            });
          }
        } else {
          TemizleCanim();
        }
      },
    });
  } else {
    alert("Giriş Yapınız");
  }
}
