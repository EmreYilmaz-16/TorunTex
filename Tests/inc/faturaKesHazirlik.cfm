<cfquery name="getCekiListesi" datasource="#dsn3#">
 SELECT S.PRODUCT_NAME
	,S.STOCK_ID
    ,S.PRODUCT_ID
	,S.PRODUCT_CODE
	,S.PRODUCT_UNIT_ID
	,SSR.AMOUNT
	,ISNULL(SR.WRK_ROW_ID,'') WRK_ROW_ID
	,SSR.LOT_NO
    ,SSR.UNIT2
	,PU.MAIN_UNIT
	,ISNULL(O.ORDER_ID,0) ORDER_ID
	,ORR.ORDER_ROW_ID
	,ISNULL(ISNULL(ORR.PRICE,P.PRICE) ,0)AS PRICE
    ,CASE WHEN ORR.PRICE IS NOT NULL THEN 1 WHEN P.PRICE IS NOT NULL THEN 2 ELSE 3 END AS NERDEN_GELDIM
	,ISNULL(ISNULL(ORR.OTHER_MONEY,P.MONEY),'TL') AS OTHER_MONEY
    ,ISNULL(ISNULL(ORR.TAX,0),0) AS TAX
	,C.COMPANY_ID
    ,C.NICKNAME
	,O.ORDER_NUMBER
    ,O.SHIP_ADDRESS_ID
    ,O.EMPLOYEE_ID
    ,O.PROJECT_ID
    ,O.SHIP_ADDRESS
	,CC.PRICE_CAT    
    ,O.DELIVER_DEPT_ID
	,O.LOCATION_ID
    ,CC.MONEY AS MUSTERI_PARA_BIRIMI
	,CASE WHEN ORR.WRK_ROW_ID IS NULL THEN 0 ELSE 1 END AS IN_SIPARIS
FROM #DSN3#.SEVKIYAT_SEPET_ROW_PBS AS SR
LEFT JOIN #DSN3#.STOCKS AS S ON S.PRODUCT_ID = SR.PRODUCT_ID
LEFT JOIN #DSN3#.SEVKIYAT_SEPET_ROW_READ_PBS AS SSR ON SSR.SEPET_ROW_ID = SR.SEPET_ROW_ID
LEFT JOIN #DSN3#.PRODUCT_UNIT AS PU ON PU.PRODUCT_UNIT_ID = S.PRODUCT_UNIT_ID
	AND IS_MAIN = 1
LEFT JOIN #DSN3#.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID = SR.WRK_ROW_ID
LEFT JOIN #DSN3#.SEVKIYAT_SEPET_PBS AS SSP ON SSP.SEPET_ID = SR.SEPET_ID
LEFT JOIN #DSN3#.ORDERS AS O ON O.ORDER_ID = SSP.ORDER_ID
LEFT JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
LEFT JOIN #DSN#.COMPANY_CREDIT AS CC ON CC.COMPANY_ID = C.COMPANY_ID
LEFT JOIN #DSN3#.PRICE AS P ON P.PRICE_CATID = CC.PRICE_CAT
	AND P.PRODUCT_ID = S.PRODUCT_ID
WHERE SR.SEPET_ID = #attributes.SEPET_ID#  AND SSR.LOT_NO IS NOT NULL ORDER BY S.PRODUCT_ID
 

</cfquery>
<cfparam name="GUNCEL_KUR" default="0">
<CFIF GUNCEL_KUR EQ 1>
<cfquery name="getMoney" datasource="#dsn#">
    SELECT 
 (SELECT RATE1 FROM #DSN#.MONEY_HISTORY WHERE MONEY_HISTORY_ID=(
 SELECT MAX(MONEY_HISTORY_ID) FROM #DSN#.MONEY_HISTORY WHERE MONEY=SM.MONEY) )AS RATE1,
 (SELECT EFFECTIVE_SALE RATE2 FROM #DSN#.MONEY_HISTORY WHERE MONEY_HISTORY_ID=(
 SELECT MAX(MONEY_HISTORY_ID) FROM #DSN#.MONEY_HISTORY WHERE MONEY=SM.MONEY) )AS RATE2,
 SM.MONEY
 FROM #DSN#.SETUP_MONEY AS SM WHERE SM.PERIOD_ID=#session.ep.period_id#
 UNION 
    SELECT 1 AS RATE1,1 AS RATE2,'TL' AS MONEY
 </cfquery>
 <CFELSE>
    <cfquery name="getMoney" datasource="#dsn3#">
        SELECT MONEY_TYPE as MONEY,RATE2,RATE1 FROM #dsn3#.ORDER_MONEY WHERE ACTION_ID=#getCekiListesi.ORDER_ID#
    </cfquery>
 </CFIF>
<cfset MYARR=arrayNew(1)>
<cfloop query="getMoney">
    <cfset PARA_={
        MONEY=MONEY,
        RATE1=RATE1,
        RATE2=RATE2
    }>
    <cfscript>
        arrayAppend(MYARR,PARA_);
    </cfscript>
</cfloop>
<cfdump var="#getMoney#">

<CFSET attributes.ROW_=getCekiListesi.recordCount>
<CFSET attributes.rows_=getCekiListesi.recordCount>

<CFSET IX=1>
<CFSET MAIN_GROSS_TOTAL=0>
<CFSET MAIN_NET_TOTAL=0>
<CFSET MAIN_TAX_TOTAL=0>
<CFSET MAIN_OTHER_MONEY=0>
<CFSET MAIN_OTHER_MONEY_VALUE=0>
<CFSET MUSTERI_PARA_BIRIMI=getCekiListesi.MUSTERI_PARA_BIRIMI>
<CFSET AKTIF_MUSTERI_PARA_BIRIMI=arrayFilter(MYARR,function(item){
    return item.MONEY=="#MUSTERI_PARA_BIRIMI#"
})>

<cfset attributes.COMPANY_ID=getCekiListesi.COMPANY_ID>
<cfset attributes.comp_name=getCekiListesi.NICKNAME>
<cfset attributes.process_cat=69><!----//UYARI process_cat DEĞERİ DEĞİŞEBİLİR KONTROL ET----->
<cfset form.process_cat=69><!----//UYARI process_cat DEĞERİ DEĞİŞEBİLİR KONTROL ET----->

<cfset attributes.ACTIVE_PERIOD =session.ep.period_id>
<!----
<cfset form.serial_number= "PINV">
<cfset form.serial_no= randRange(0, 1000000, "CFMX_COMPAT")>
---->
<cfset AAserial_no= randRange(0, 1000000, "CFMX_COMPAT")>
<CFSET attributes.SHIP_NUMBER="PSH-#AAserial_no#">
<CFSET SHIP_NUMBER=attributes.SHIP_NUMBER>
<cfset attributes.EMPLOYEE_ID=session.EP.userid>
<cfset attributes.basket_id=2> <!----//UYARI BASKET ID DEĞERİ DEĞİŞEBİLİR KONTROL ET----->
<cfset attributes.sale_product=1>
<cfset form.sale_product=1>
<CFSET ADRES =getCekiListesi.SHIP_ADDRESS>
<cfset attributes.paper_number=2>
<cfset attributes.paper_printer_id=3>
<!---- Burası Fatura Yapar 
<cfset attributes.INVOICE_DATE =dateformat(now(),"dd/mm/yyyy")>
<cfset attributes.INVOICE_DATE_H =timeFormat(now(),"hh")>
<cfset attributes.INVOICE_DATE_M =timeFormat(now(),"mm")>
---->
<cfset attributes.SHIP_DATE =dateformat(now(),"dd/mm/yyyy")>
<cfset attributes.SHIP_DATE_H =timeFormat(now(),"hh")>
<cfset attributes.SHIP_DATE_M =timeFormat(now(),"mm")>
<cfset attributes.PARTNER_ID=getCekiListesi.COMPANY_ID>
<cfset attributes.PROJECT_ID =getCekiListesi.PROJECT_ID>
<cfset attributes.DELIVER_DATE_FRM =dateformat(now(),"dd/mm/yyyy")>
<cfset attributes.deliver_date_h =timeFormat(now(),"hh")>
<cfset attributes.deliver_date_m =timeFormat(now(),"mm")>

<cfset attributes.ship_address_id=getCekiListesi.SHIP_ADDRESS_ID>
<cfset attributes.EMPO_ID=getCekiListesi.EMPLOYEE_ID>
<CFSET attributes.department_id=getCekiListesi.DELIVER_DEPT_ID>
<CFSET attributes.location_id=getCekiListesi.LOCATION_ID>
<cfset attributes.note="">
<cfset form.BASKET_DISCOUNT_TOTAL =0>
<cfset DELIVER_GET ="Admin">
<cfset ibnm=1>
<cfloop query="getMoney">
    <cfset "attributes.hidden_rd_money_#ibnm#"=MONEY>
    <cfset "attributes._txt_rate1_#ibnm#"=RATE1>
    <cfset "attributes._txt_rate2_#ibnm#"=RATE2>
    <cfset "attributes.txt_rate1_#ibnm#"=RATE1>
    <cfset "attributes.txt_rate2_#ibnm#"=RATE2>
    <cfset ibnm=ibnm+1>
</cfloop>
<cfset attributes.basket_rate1=AKTIF_MUSTERI_PARA_BIRIMI[1].RATE1>
<cfset attributes.basket_rate2=AKTIF_MUSTERI_PARA_BIRIMI[1].RATE2>
<cfset form.basket_rate1=AKTIF_MUSTERI_PARA_BIRIMI[1].RATE1>
<cfset form.basket_rate2=AKTIF_MUSTERI_PARA_BIRIMI[1].RATE2>
<CFSET attributes.BASKET_MONEY =AKTIF_MUSTERI_PARA_BIRIMI[1].MONEY>
<CFSET FORM.BASKET_MONEY =AKTIF_MUSTERI_PARA_BIRIMI[1].MONEY>
<CFSET attributes.KUR_SAY=getMoney.recordCount>
<CFSET FORM.KUR_SAY=getMoney.recordCount>
<cfoutput>
<cfloop query="getCekiListesi">

    <cfset "attributes.PRODUCT_ID#IX#"=PRODUCT_ID>
    <cfset "attributes.STOCK_ID#IX#"=STOCK_ID>
    <CFSET "attributes.product_name#IX#"=PRODUCT_NAME>
    <CFSET "attributes.amount#IX#"=AMOUNT>
    <CFSET "attributes.unit#IX#"=MAIN_UNIT>
    <CFSET "attributes.unit_id#IX#"=PRODUCT_UNIT_ID>
    <CFSET "attributes.lot_no#IX#"=LOT_NO>
    <CFSET "attributes.otv_oran#IX#"="">
    <CFSET "attributes.row_bsmv_rate#IX#"=""> 
    <CFSET "form.row_otvtotal#IX#"=0>
    <CFSET "attributes.row_oiv_rate#IX#"=""> 
    <CFSET "attributes.row_tevkifat_rate#IX#"=""> 
    <CFSET "attributes.row_exp_center_id#IX#"="">
    <CFSET "attributes.row_exp_item_id#IX#"="">
    <CFSET "attributes.row_subscription_id#IX#"="">
    <cfset "attributes.row_ship_id#IX#"="#order_id#">
    <cfset "attributes.is_inventory#IX#"="1">
    <cfset AKTIF_BIRIM=arrayFilter(MYARR,function(item){
        return item.MONEY=="#getCekiListesi.OTHER_MONEY#"
    })>
    <CFIF NERDEN_GELDIM EQ 2>
        <CFSET TL_FIYAT=PRICE*AKTIF_BIRIM[1].RATE2>    
    <CFELSE>
        <CFSET TL_FIYAT=PRICE>    
    </CFIF>
    
    <CFSET "attributes.PRICE#IX#"=TL_FIYAT>
    <CFSET "attributes.price_other#IX#"=TL_FIYAT/AKTIF_BIRIM[1].RATE2>
    <CFSET "attributes.price_other#IX#"=NumberFormat(evaluate('attributes.price_other#IX#'), '9.99')>
    <div class="alert alert-success">
       <b> Ürün Adı  : #PRODUCT_NAME#</b> <br>
       Aktif ParaBirimi :  getCekiListesi.OTHER_MONEY <br>
       Rate 1=#AKTIF_BIRIM[1].RATE1#<br>
       Rate 2=#AKTIF_BIRIM[1].RATE2#<br>
       HESAPLANAN TL FİYATI=#TL_FIYAT# <BR>
       SİPARİŞTEN GELEN TL FİYATI=#PRICE#<br>
       DİĞER FİYAT : #NumberFormat(evaluate('attributes.price_other#IX#'), '9.99')#<br>
      Fiyat Kaynağı : <CFIF NERDEN_GELDIM EQ 1>Sipariş<cfelse>Fiyat Listesi</CFIF>
    </div>
    


    
    
    <CFSET NET_TOTAL=AMOUNT*TL_FIYAT>
    <CFSET "attributes.row_total#IX#"=NET_TOTAL> 
    <CFSET "attributes.row_nettotal#IX#"=NET_TOTAL>     <!-----//BILGI NET      TOTAL       ---->
    <CFSET TAX_TOTAL=((NET_TOTAL*TAX)/ 100)>
    <CFSET "attributes.row_taxtotal#IX#"=TAX_TOTAL>     <!-----//BILGI TAX      TOTAL       ---->
    <CFSET "form.row_taxtotal#IX#"=TAX_TOTAL>
    <CFSET GROSS_TOTAL=NET_TOTAL+TAX_TOTAL>
    <CFSET "attributes.row_lasttotal#IX#"=GROSS_TOTAL>  <!-----//BILGI GROSS    TOTAL       ---->
    <CFSET "attributes.tax#IX#"=TAX>                    <!-----//BILGI TAX                  ---->
    <CFSET "attributes.other_money_#IX#"=OTHER_MONEY>   <!-----//BILGI DIGER PARA BIRIMI                  ---->
    <CFSET "attributes.other_money_value_#IX#"=NET_TOTAL/AKTIF_BIRIM[1].RATE2>  <!-----//BILGI OTHER_MONEY_VALUE                  ---->
    <CFSET "attributes.other_money_gross_total#IX#"=GROSS_TOTAL/AKTIF_BIRIM[1].RATE2>  <!-----//BILGI OTHER_MONEY_GROSS_TOTAL                  ---->
    
    <CFSET "attributes.amount_other#IX#"=1>
    <CFSET "attributes.unit_other#IX#"=UNIT2>
    <CFSET "attributes.wrk_row_id#IX#"="#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">
    <CFSET MAIN_GROSS_TOTAL=MAIN_GROSS_TOTAL+GROSS_TOTAL>
    <CFSET MAIN_NET_TOTAL=MAIN_NET_TOTAL+GROSS_TOTAL>
    <CFSET MAIN_TAX_TOTAL=MAIN_TAX_TOTAL+TAX_TOTAL>
    <cfset IX=IX+1>
</cfloop>
</cfoutput>
<CFSET MAIN_OTHER_MONEY=AKTIF_MUSTERI_PARA_BIRIMI[1].MONEY>
<CFSET MAIN_OTHER_MONEY_VALUE=(MAIN_NET_TOTAL/AKTIF_MUSTERI_PARA_BIRIMI[1].RATE2)>

<cfset form.basket_net_total=MAIN_NET_TOTAL>
<cfset form.basket_gross_total=MAIN_GROSS_TOTAL>
<cfset form.basket_tax_total=MAIN_TAX_TOTAL>
<cfset form.basket_otv_total="">
<cfset form.genel_indirim=0>
<cfset attributes.basket_net_total=MAIN_NET_TOTAL>
<cfset attributes.basket_gross_total=MAIN_GROSS_TOTAL>
<cfset attributes.basket_tax_total=MAIN_TAX_TOTAL>
<cfset attributes.basket_otv_total="">
<cfset attributes.genel_indirim="">
<CFSET attributes.ORDER_ID=getCekiListesi.ORDER_ID>
<CFSET attributes.order_id_form="000">
<CFSET attributes.order_id_listesi=getCekiListesi.ORDER_ID>

<cfdump var="#getCekiListesi#">

<cfquery name="UP" datasource="#DSN3#">
    UPDATE #dsn3#.ORDERS SET ORDER_STAGE=262 WHERE ORDER_ID=#getCekiListesi.ORDER_ID#
</cfquery>

<cfinclude template="/V16/objects/functions/add_company_related_action.cfm">
<cfinclude template="/V16/stock/query/add_sale.cfm">
<cflocation url="/index.cfm?fuseaction=stock.form_add_sale&event=upd&ship_id=#first_ship_id#">

<!---- Burası Fatura Yapar 
<cfinclude template="/V16/objects/functions/add_company_related_action.cfm">
<cfinclude template="/V16/invoice/query/add_invoice_sale_PBS.cfm">
----->

<!----
    <cfif isdefined('attributes.amount_other#i#') and len(evaluate('attributes.amount_other#i#'))>#evaluate('attributes.amount_other#i#')#<cfelse>NULL</cfif>,
		<cfif isdefined('attributes.unit_other#i#') and len(evaluate('attributes.unit_other#i#'))><cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('attributes.unit_other#i#')#"><cfelse>NULL</cfif>,
<cfquery name="ORDERS_INVOICE_ADD" datasource="#dsn3#">
    INSERT INTO ORDERS_INVOCE(INVOICE_ID,ORDER_ID,PERIOD_ID,CHANGE_RESERVE_STATUS) VALUES(#first_invoice_id#,#getCekiListesi.ORDER_ID#,session.EP.userid,1)
</cfquery>
----->

<!------
    //TAMAM FATURA KAYDFETME TAMAMLANDI ANCAK SİPARİŞ BİLGİSİ ALMADIĞIM İÇİN FATURA SİPARİŞ BAĞLANTISINI MANUEL YAP 
    //TAMAM MANUEL YAPMAMA GEREK KALMADI ORDER_ID GÖNDERDEREREK BİRLEŞTİ ANCAK REZERV KONUSU 
    //SOR SİPARİŞTEKİ EŞLEŞMEYEN SATIRLARA NE OLACAK ? REZERV PROBLEMİ OLABİLİR

    ----->
<!-----
    		#form.basket_net_total#,
		#form.basket_gross_total#,
		#form.basket_tax_total#,
        
        NETTOTAL,
		GROSSTOTAL,
		TAXTOTAL,
    //BILGI HESAPLAMA 
GROS_TOTAL=SATIR TL TOPLAM
NET TOTAL
TAX TOTAL
OTHER_MONEY
OTHER_MONEY_VALUE

SATIR

PRICE TL FIYAT
PRICE_OTHER SATIR PARA BIRIMI TL'DEN FARKLIYSA KURLA HESAPLA
NET_TOTAL=MIKTAR*TL_FIYAT
TAX_TOTAL=(NET_TOTAL*KDV)/100
GROSS_TOTAL=NET_TOTAL+TAX_TOTAL
OTHER_MONEY_VALUE SATIR PARA BIRIMI TLDEN FARKLIYSA NET_TOTAL/KUR RATE 2 DEGILSE NET_TOTAL
OTHER_MONEY_GROSS_TOTAL= SATIR PARA BIRIMI TLDEN FARKLIYSA GROSS_TOTAL/KUR RATE 2 DEGILSE GROSS_TOTAL
GROSSTOTAL,
			NETTOTAL,
			TAXTOTAL,
#evaluate("attributes.row_lasttotal#i#")#,
			#evaluate("attributes.row_nettotal#i#")#,
			#evaluate("attributes.row_taxtotal#i#")#,

            other_money_
            other_money_value_
            other_money_gross_total
            price_other
            lot_no
----->