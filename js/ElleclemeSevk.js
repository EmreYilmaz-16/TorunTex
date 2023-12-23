function getShelves(el) {
  var DEPARTMENT_ID = list_getat(el.value, 1, "-");
  var LOCATION_ID = list_getat(el.value, 2, "-");
 var Res= wrk_query(
    "SELECT SHELF_CODE,PRODUCT_PLACE_ID FROM PRODUCT_PLACE WHERE STORE_ID=" +
      DEPARTMENT_ID +
      " AND LOCATION_ID=" +
      LOCATION_ID,
    "DSN3"
  );
  $("#SHELF").html('<option value="">Seçiniz</option>')
  for (let index = 0; index < Res.SHELF_CODE.length; index++) {
    var opt=document.createElement("option");
    opt.setAttribute("value",Res.PRODUCT_PLACE_ID[i]);
    opt.innerText=Res.SHELF_CODE[i];
    document.getElementById("SHELF").appendChild(opt);
    
  }

}
