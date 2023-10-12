function SepeteEkle(PRODUCT_ID,STOCK_ID,PRODUCT_NAME){
    var tr=document.createElement("tr");
    var td=document.createElement("td");
    td.innerText=PRODUCT_NAME;
    var in1=document.createElement("input");
    in1.setAttribute("type","hidden");
    in1.setAttribute("name","PRODUCT_ID");
    in1.setAttribute("id","PRODUCT_ID");
    in1.value=PRODUCT_ID;
    td.appendChild(in1);
    var in1=document.createElement("input");
    in1.setAttribute("type","hidden");
    in1.setAttribute("name","STOCK_ID");
    in1.setAttribute("id","STOCK_ID");
    in1.value=STOCK_ID;
    td.appendChild(in1);
    tr.appendChild(td);
    var td=document.createElement("td");
    var in1=document.createElement("input");
    in1.setAttribute("type","text");
    in1.setAttribute("name","AMOUNT");
    in1.setAttribute("id","AMOUNT");
    in1.value=prompt("Miktar (KG)");
    td.appendChild(in1);
    tr.appendChild(td);
    document.getElementById("basket").appendChild(tr);
}