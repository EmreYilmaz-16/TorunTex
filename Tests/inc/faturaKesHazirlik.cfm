<cfquery name="getCekiListesi" datasource="#dsn3#">
 SELECT S.PRODUCT_NAME
	,S.STOCK_ID
    ,S.PRODUCT_ID
	,S.PRODUCT_CODE
	,S.PRODUCT_UNIT_ID
	,SSR.AMOUNT
	,ISNULL(SR.WRK_ROW_ID,'') WRK_ROW_ID
	,SSR.LOT_NO
	,PU.MAIN_UNIT
	,ORR.ORDER_ID
	,ORR.ORDER_ROW_ID
	,ISNULL(ISNULL(ORR.PRICE,P.PRICE) ,0)AS PRICE
	,ISNULL(ISNULL(ORR.OTHER_MONEY,P.MONEY),'TL') AS OTHER_MONEY
    ,ISNULL(ISNULL(ORR.TAX,20),0) AS TAX
	,C.COMPANY_ID
    ,C.NICKNAME
	,O.ORDER_NUMBER
    ,O.SHIP_ADDRESS_ID
    ,O.EMPLOYEE_ID
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
<cfset attributes.process_cat=36><!----//UYARI process_cat DEĞERİ DEĞİŞEBİLİR KONTROL ET----->
<cfset form.process_cat=36><!----//UYARI process_cat DEĞERİ DEĞİŞEBİLİR KONTROL ET----->

<cfset attributes.ACTIVE_PERIOD =session.ep.period_id>
<cfset form.serial_number= "PINV">
<cfset form.serial_no= randRange(0, 1000000, "CFMX_COMPAT")>
<cfset attributes.EMPLOYEE_ID=session.EP.userid>
<cfset attributes.basket_id=2> <!----//UYARI BASKET ID DEĞERİ DEĞİŞEBİLİR KONTROL ET----->
<cfset attributes.sale_product=1>
<cfset form.sale_product=1>
<cfset attributes.INVOICE_DATE =dateformat(now(),"dd/mm/yyyy")>
<cfset attributes.INVOICE_DATE_H =timeFormat(now(),"hh")>
<cfset attributes.INVOICE_DATE_M =timeFormat(now(),"mm")>
<cfset attributes.ship_address_id=getCekiListesi.SHIP_ADDRESS_ID>
<cfset attributes.EMPO_ID=getCekiListesi.EMPLOYEE_ID>
<CFSET attributes.department_id=getCekiListesi.DELIVER_DEPT_ID>
<CFSET attributes.location_id=getCekiListesi.LOCATION_ID>
<cfset DELIVER_GET ="Admin">
<cfset ibnm=1>
<cfloop query="getMoney">
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
<cfloop query="getCekiListesi">

    <cfset "attributes.PRODUCT_ID#IX#"=PRODUCT_ID>
    <cfset "attributes.STOCK_ID#IX#"=STOCK_ID>
    <cfset AKTIF_BIRIM=arrayFilter(MYARR,function(item){
        return item.MONEY=="#getCekiListesi.OTHER_MONEY#"
    })>
    <CFSET TL_FIYAT=PRICE*AKTIF_BIRIM[1].RATE2>    
    <CFSET "attributes.PRICE#IX#"=TL_FIYAT>
    
    <CFSET NET_TOTAL=AMOUNT*TL_FIYAT>
    <CFSET "attributes.row_nettotal#IX#"=NET_TOTAL>     <!-----//BILGI NET      TOTAL       ---->
    <CFSET TAX_TOTAL=((NET_TOTAL*TAX)/ 100)>
    <CFSET "attributes.row_taxtotal#IX#"=TAX_TOTAL>     <!-----//BILGI TAX      TOTAL       ---->
    <CFSET GROSS_TOTAL=NET_TOTAL+TAX_TOTAL>
    <CFSET "attributes.row_lasttotal#IX#"=GROSS_TOTAL>  <!-----//BILGI GROSS    TOTAL       ---->
    <CFSET "attributes.tax#IX#"=TAX>                    <!-----//BILGI TAX                  ---->
    <CFSET "attributes.other_money_#IX#"=OTHER_MONEY>   <!-----//BILGI DIGER PARA BIRIMI                  ---->
    <CFSET "attributes.other_money_value_#IX#"=NET_TOTAL/AKTIF_BIRIM[1].RATE2>  <!-----//BILGI OTHER_MONEY_VALUE                  ---->
    <CFSET "attributes.other_money_gross_total#IX#"=GROSS_TOTAL/AKTIF_BIRIM[1].RATE2>  <!-----//BILGI OTHER_MONEY_GROSS_TOTAL                  ---->
    <CFSET "attributes.price_other#IX#"=TL_FIYAT/AKTIF_BIRIM[1].RATE2>
    <CFSET MAIN_GROSS_TOTAL=MAIN_GROSS_TOTAL+GROSS_TOTAL>
    <CFSET MAIN_NET_TOTAL=MAIN_NET_TOTAL+GROSS_TOTAL>
    <CFSET MAIN_TAX_TOTAL=MAIN_TAX_TOTAL+TAX_TOTAL>
</cfloop>
<CFSET MAIN_OTHER_MONEY=AKTIF_MUSTERI_PARA_BIRIMI[1].MONEY>
<CFSET MAIN_OTHER_MONEY_VALUE=(MAIN_NET_TOTAL/AKTIF_MUSTERI_PARA_BIRIMI[1].RATE2)>

<cfset form.basket_net_total=MAIN_NET_TOTAL>
<cfset form.basket_gross_total=MAIN_GROSS_TOTAL>
<cfset form.basket_tax_total=MAIN_TAX_TOTAL>
<cfset form.basket_otv_total="">
<cfset form.genel_indirim="">
<cfinclude template="/V16/invoice/query/add_invoice_sale.cfm">
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