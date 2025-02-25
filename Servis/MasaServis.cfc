﻿<cfcomponent>
    <cfset dsn3="w3Toruntex_1">
    <cfset dsn="w3Toruntex">
    <cfset dsn3_alias="w3Toruntex_1">
    <cfset dsn2="w3Toruntex_#year(now())#_1">
    <cfset dsn2_alias="w3Toruntex_#year(now())#_1">
    <cfset DSN1="w3Toruntex_product">
    <!----
        //BILGI MASALARA ÜRÜNÜ GÖNDERMEK İÇİN KULLANILIR
        //UYARI ESKİDE KALDI EĞER BİRGÜN SIEMENSİN PLC PROGRAMINA SCRİPT YAZMAK İSTERLERSE KULLANILACAK    
    ------>
    <cffunction name="SendMasa" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfdump var="#arguments#">
        <cfset F=structKeyArray(arguments)>
        <cfset FormData=deserializeJSON(f[1])>
        <cfdump var="#FormData#">
        <cfif isDefined("FormData.RAF_DATA")>
            

        <cfelse>
            
        </cfif>
    
    <cfset attributes.LOCATION_OUT=7>
    <cfset attributes.department_out=7>
    <cfset attributes.department_in =7>
    <cfset attributes.LOCATION_IN=4>
    <cfset form.process_cat=255>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset attributes.QUANTITY=FormData.AMOUNT>
   <cfset attributes.uniq_relation_id_="">
   <cfset amount_other="">
   <cfset unit_other="">
   <cfset lot_no="">
   <cfset attributes.ROWW=" ,">
   <cfset attributes.wodate="1">
<CFSET attributes.STOCK_ID=FormData.STOCK_ID>
<cfinclude template="../Tests/inc/StokFisQuery.cfm">

    </cffunction>
<!-------
    //BILGI ÜRÜN VE İSTASYONA BAĞLI OLARAK SİPARİŞLERİ GETİRİR    
-------->
<cffunction name="getOrders" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="PRODUCT_ID">
        <cfargument name="STATION">
        <cfquery name="GETDATA" datasource="#DSN3#">
            SELECT ORR.WRK_ROW_ID,ORR.ORDER_ROW_ID,ORR.PRODUCT_ID,O.ORDER_ID,C.COMPANY_ID,O.PRIORITY_ID,O.ORDER_HEAD,O.ORDER_NUMBER,C.NICKNAME,CONVERT(INT,SP.PRIORITY) AS PP FROM ORDER_ROW AS ORR
            LEFT JOIN ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
            LEFT JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
            LEFT JOIN #DSN#.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID=O.PRIORITY_ID
            WHERE ORR.PRODUCT_ID=#arguments.PRODUCT_ID# AND ORR.UNIT2 LIKE '%#arguments.STATION#%' and ORR.ORDER_ROW_CURRENCY IN (-5) 
        </cfquery>
<CFSET RETURNARR=arrayNew(1)>
<cfloop query="GETDATA">
    <CFSET ITEM={
        WRK_ROW_ID=WRK_ROW_ID,
        ORDER_ROW_ID=ORDER_ROW_ID,
        PRODUCT_ID=PRODUCT_ID,
        ORDER_ID=ORDER_ID,
        COMPANY_ID=COMPANY_ID,
        PP=PP,
        ORDER_HEAD=ORDER_HEAD,
        ORDER_NUMBER=ORDER_NUMBER,
        NICKNAME=NICKNAME
    }>
    <cfscript>
        arrayAppend(RETURNARR,ITEM);
    </cfscript>
</cfloop>
<cfreturn replace(serializeJSON(RETURNARR),"//","")>
    </cffunction>
<!----
//BILGI SİPARİŞ ROW IDSİ İLE BİRTANE SİPRAİŞ SATIRI DÖNER FORMDAKİ VERİLER BU METODLA DOLAR
    ------>
    <cffunction name="getAOrder" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="ORDER_ROW_ID">
        <cfquery name="GETDATA" datasource="#DSN3#">
       SELECT QUANTITY
	,UNIT
	,BASKET_EXTRA_INFO_ID
	,ORDER_ROW.AMOUNT2
	,UNIT2
	,DETAIL_INFO_EXTRA
	,PRODUCT_NAME2
	,PROPERTY1
	,PROPERTY2
	,PROPERTY3
	,PROPERTY4
	,PROPERTY5
	,PROPERTY6
	,ORDER_ROW_ID
	,WRK_ROW_ID
	,ORDER_ROW_CURRENCY
	,STOCKS.PRODUCT_ID
	,STOCKS.STOCK_ID
	,STOCKS.PRODUCT_NAME
	,STOCKS.PRODUCT_CODE
	,ORDER_ROW.ORDER_ID
	,O.ORDER_NUMBER
    ,ISNULL(O.SA_PACKAGE_COLOR,0) SA_PACKAGE_COLOR
	,STOCKS.PRODUCT_DETAIL
	,STOCKS.PRODUCT_DETAIL AA2
	,STOCKS.PRODUCT_DETAIL2 AA3
	,SC.COUNTRY_NAME
	,C.NICKNAME
	,O.DELIVER_DEPT_ID
	,O.SA_PRODUCTION_NOTE
	,O.LOCATION_ID
	,SLSL.COMMENT
	,(
		100 * ISNULL((
				SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
				FROM #dsn2#.STOCKS_ROW
				WHERE PBS_RELATION_ID = ORDER_ROW.WRK_ROW_ID
					AND STORE = O.DELIVER_DEPT_ID
					AND STORE_LOCATION = O.LOCATION_ID
				), 0) / QUANTITY
		) AS TAMAMLANMA
	,SBI_1.BASKET_INFO_TYPE AS A1
	,SBI_2.BASKET_INFO_TYPE AS A2
FROM #dsn3#.ORDER_ROW
LEFT JOIN #dsn3#.ORDER_INFO_PLUS ON ORDER_ROW.ORDER_ID = ORDER_INFO_PLUS.ORDER_ID
LEFT JOIN #dsn3#.STOCKS ON STOCKS.STOCK_ID = ORDER_ROW.STOCK_ID
LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID = ORDER_ROW.ORDER_ID
LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
LEFT JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = O.COUNTRY_ID
LEFT JOIN #dsn3#.SETUP_BASKET_INFO_TYPES AS SBI_1 ON ORDER_ROW.SELECT_INFO_EXTRA = SBI_1.BASKET_INFO_TYPE_ID
LEFT JOIN #dsn3#.SETUP_BASKET_INFO_TYPES AS SBI_2 ON ORDER_ROW.BASKET_EXTRA_INFO_ID = SBI_2.BASKET_INFO_TYPE_ID
LEFT JOIN #dsn#.STOCKS_LOCATION AS SLSL ON SLSL.LOCATION_ID = O.LOCATION_ID
	AND SLSL.DEPARTMENT_ID = O.DELIVER_DEPT_ID
WHERE ORDER_ROW.ORDER_ROW_ID = #arguments.ORDER_ROW_ID#    
        </cfquery>
   <cfquery name="GETDATA2" datasource="#DSN3#">
    select QUANTITY,UNIT,
    ISNULL(T1.STOCK_IN,0) AS R_AMOUNT,
    BASKET_EXTRA_INFO_ID,ORDER_ROW.AMOUNT2,UNIT2,DETAIL_INFO_EXTRA,PROPERTY1,PROPERTY2,PROPERTY3,PROPERTY4,PROPERTY5,PROPERTY6,ORDER_ROW_ID,WRK_ROW_ID,STOCKS.PRODUCT_ID,STOCKS.STOCK_ID,STOCKS.PRODUCT_NAME,STOCKS.PRODUCT_CODE
     from #dsn3#.ORDER_ROW 
     LEFT JOIN #dsn3#.ORDER_INFO_PLUS ON ORDER_ROW.ORDER_ID=ORDER_INFO_PLUS.ORDER_ID
     LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID=ORDER_ROW.ORDER_ID
     LEFT JOIN #dsn3#.STOCKS ON STOCKS.STOCK_ID=ORDER_ROW.STOCK_ID
     LEFT JOIN ((SELECT STOCK_ID, sum(STOCK_IN-STOCK_OUT) STOCK_IN, STORE, STORE_LOCATION  FROM #dsn2#.STOCKS_ROW WHERE STORE IS NOT NULL  GROUP BY STOCK_ID, STORE, STORE_LOCATION)) AS T1 
	 ON T1.STOCK_ID = w3toruntex_1.ORDER_ROW.STOCK_ID and T1.STORE=O.DELIVER_DEPT_ID and T1.STORE_LOCATION=O.LOCATION_ID
     where ORDER_ROW.ORDER_ID=#GETDATA.ORDER_ID#
 </cfquery>
 
 <CFSET ALL_ROWS=arrayNew(1)>
 <cfloop query="GETDATA2">
    <CFSET ITEM={
        QUANTITY=QUANTITY,
        UNIT=UNIT,
        BASKET_EXTRA_INFO_ID=BASKET_EXTRA_INFO_ID,
        AMOUNT2=AMOUNT2,
        UNIT2=UNIT2,
        DETAIL_INFO_EXTRA=DETAIL_INFO_EXTRA,        
        PROPERTY1=PROPERTY1,
        PROPERTY2=PROPERTY2,
        PROPERTY3=PROPERTY3,
        PROPERTY4=PROPERTY4,
        PROPERTY5=PROPERTY5,
        PROPERTY6=PROPERTY6,
        ORDER_ROW_ID=ORDER_ROW_ID,
        WRK_ROW_ID=WRK_ROW_ID,
        PRODUCT_ID=PRODUCT_ID,
        STOCK_ID=STOCK_ID,        
        PRODUCT_NAME=PRODUCT_NAME,
        PRODUCT_CODE=PRODUCT_CODE,
        R_AMOUNT=R_AMOUNT
        
    }>
    <cfscript>
        arrayAppend(ALL_ROWS,ITEM);
    </cfscript>
 </cfloop>
<cfloop query="GETDATA">
    <cfquery name="getRWX" datasource="#dsn#">
        SELECT OPTION_SETTINGS FROM w3Toruntex.EXTENDED_FIELDS WHERE CONTROLLER_NAME='WBO/controller/saleOrderController.cfm' AND FIELD_ID='SA_PACKAGE_COLOR' AND EVENT_LIST='add'
    </cfquery>
    <cfset AAA=deserializeJSON(getRWX.OPTION_SETTINGS)>
    <cfscript>
        VXX  = ArrayFilter(AAA, function(item) {
        return item.op_val =='#GETDATA.SA_PACKAGE_COLOR#';
    });
    </cfscript>
    <CFSET RETURN_ITEM={
        QUANTITY=QUANTITY,
        UNIT=UNIT,
        BASKET_EXTRA_INFO_ID=BASKET_EXTRA_INFO_ID,
        AMOUNT2=AMOUNT2,
        UNIT2=UNIT2,
        DETAIL_INFO_EXTRA=DETAIL_INFO_EXTRA,
        NICKNAME=NICKNAME,
        COUNTRY_NAME=COUNTRY_NAME,
        PROPERTY1=PROPERTY1,
        PROPERTY2=PROPERTY2,
        PROPERTY3=PROPERTY3,
        PROPERTY4=PROPERTY4,
        
        PROPERTY6=PROPERTY6,
        PRODUCT_NAME2=PRODUCT_NAME2,
        SA_PRODUCTION_NOTE=SA_PRODUCTION_NOTE,
        PRODUCT_DETAIL=PRODUCT_DETAIL,
        ORDER_ROW_ID=ORDER_ROW_ID,
        WRK_ROW_ID=WRK_ROW_ID,
        ORDER_ROW_CURRENCY=ORDER_ROW_CURRENCY,
        PRODUCT_ID=PRODUCT_ID,
        STOCK_ID=STOCK_ID,
        PRODUCT_NAME=PRODUCT_NAME,
        PRODUCT_CODE=PRODUCT_CODE,
        TAMAMLANMA=TAMAMLANMA,
        SIP_DEPO="#DELIVER_DEPT_ID#-#LOCATION_ID#",
        COMMENT=COMMENT,
        ORDER_NUMBER=ORDER_NUMBER,
        A1=A1,
        A2=A2,
        AA2=AA2,
        AA3=AA3
        
    }>
    <cfif arrayLen(Vxx)>
        <cfset RETURN_ITEM.PROPERTY5=Vxx[1].op_text>
    <cfelse>
        <cfset RETURN_ITEM.PROPERTY5="">
    </cfif>
    <cfscript>
        
    </cfscript>
</cfloop>
<cfset RETURN_ITEM.ALL_ROWS=ALL_ROWS>
<cfreturn replace(serializeJSON(RETURN_ITEM),"//","")>
    </cffunction>
<!---
    //BILGI TAŞIMA YAPMADA KULLANILIR
    //DIKKAT TAŞIMA YAPMA BİRDEN FAZLA YERDE KULLANILDI 
    //UYARI METHODDA DEĞİŞİKLİK YAPTIKTAN SONRA VERİ DOĞRULUĞUNU KONTROL ET
    ----->
    <cffunction name="SaveBelge" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="AMOUNT">
        <cfargument name="WRK_ROW_ID">
        <cfargument name="LOT_NUMARASI">
        <cfargument name="DEPO">       
        <cfargument name="SIP_DEPO">        
        <cfargument name="PRODUCT_ID">        
        <cfargument name="ISTASYON">     
        <cfargument name="UNIT2" default="">
        <CFSET MIKTARIM=arguments.AMOUNT>
        <CFSET MESSAGE="">
        <CFSET O=structNew()>
        <cftry>
            <cfif len(arguments.WRK_ROW_ID)>
        <cfquery name="getOI" datasource="#dsn3#">
            SELECT  * FROM ORDER_ROW WHERE WRK_ROW_ID='#arguments.WRK_ROW_ID#'
        </cfquery>
   
    <CFSET O.getOI=getOI> 
       
    <cfquery name="getORDER" datasource="#dsn3#">
    SELECT  ISNULL(SUM(STOCK_IN-STOCK_OUT),0) BAK,
            ISNULL(SUM(CASE WHEN STOCK_OUT>0 THEN -1 ELSE 1 END),0) AS BAK2 
    FROM    #dsn2#.STOCKS_ROW 
    WHERE   STORE=#listGetAt(arguments.SIP_DEPO,1,"-")# 
        AND STORE_LOCATION=#listGetAt(arguments.SIP_DEPO,2,"-")# 
        AND PRODUCT_ID='#arguments.PRODUCT_ID#'       
    </cfquery>
    <CFIF arguments.ISTASYON EQ "KLB">
        <cfif (getORDER.BAK2+1) GT getOI.AMOUNT2>
            <CFSET MESSAGE="ÜRETİM TAMAMLANMIŞTIR VEYA ÜRETİLEN MİKTAR İLE BİRLİKTE SİPARİŞ MİKTARI AŞILMAKTADIR">
            <cfset O.MESSAGE=MESSAGE>
            <cfset O.STATUS=0>
            <cfset O.STATUS_CODE=4>
            <cfreturn replace(serializeJSON(O),"//","")>
        </cfif>
    <cfelseif arguments.ISTASYON EQ "SCK">
        <cfif (getORDER.BAK) GT getOI.QUANTITY>
            <CFSET MESSAGE="ÜRETİM TAMAMLANMIŞTIR VEYA ÜRETİLEN MİKTAR İLE BİRLİKTE SİPARİŞ MİKTARI AŞILMAKTADIR">
            <cfset O.MESSAGE=MESSAGE>
            <cfset O.STATUS=0>
            <cfset O.STATUS_CODE=4>
            <cfreturn replace(serializeJSON(O),"//","")>
        </cfif>
    <CFELSE>
    </CFIF>
 
    <cfelse>
        <cfquery name="getOI" datasource="#dsn3#">
            SELECT  * FROM STOCKS WHERE PRODUCT_ID=#arguments.PRODUCT_ID#
        </cfquery>
        <cfset O.getOI=getOI>
    </cfif>

        
        <cfquery name="GETRELATEDPRODUCT" datasource="#DSN3#">
            SELECT * FROM #dsn3#.RELATED_PRODUCT WHERE PRODUCT_ID=#arguments.PRODUCT_ID# ORDER BY RELATED_PRODUCT_NO
        </cfquery>
        <CFSET O.REL_PROD_RES=GETRELATEDPRODUCT.recordcount>
        <CFSET SARF_STOCK_ID=0>
        <CFSET attributes.SARF_STOCK_ID_LIST="">
        <CFSET attributes.SARF_AMOUNT_LIST="">
        <cfset T_AMOUNT=0>
        <cfset HesapAmount=arguments.AMOUNT>
        <cfloop query="GETRELATEDPRODUCT">
            <cfquery name="GETS" datasource="#dsn2#">
                SELECT SUM(STOCK_IN-STOCK_OUT) AS BAKIYE,STOCK_ID,PRODUCT_ID FROM #dsn2#.STOCKS_ROW WHERE STORE=7 AND STORE_LOCATION=3 AND PRODUCT_ID=#GETRELATEDPRODUCT.RELATED_PRODUCT_ID# GROUP BY STOCK_ID,PRODUCT_ID
            </cfquery>                        
               <CFSET "O.QUERY_#GETRELATEDPRODUCT.RELATED_PRODUCT_ID#"=GETS>
               <CFIF GETS.recordCount AND  (GETS.BAKIYE LT HesapAmount AND GETS.BAKIYE NEQ 0)>
                    <CFSET HesapAmount=HesapAmount-GETS.BAKIYE>
                    <CFSET attributes.SARF_STOCK_ID_LIST="#attributes.SARF_STOCK_ID_LIST#,#GETS.STOCK_ID#">
                    <CFSET attributes.SARF_AMOUNT_LIST="#attributes.SARF_AMOUNT_LIST#,#GETS.BAKIYE#">
                <CFELSEIF GETS.BAKIYE GTE HesapAmount> 
                    <CFSET attributes.SARF_STOCK_ID_LIST="#attributes.SARF_STOCK_ID_LIST#,#GETS.STOCK_ID#">
                    <CFSET attributes.SARF_AMOUNT_LIST="#attributes.SARF_AMOUNT_LIST#,#HesapAmount#">
                    <CFSET HesapAmount=0>
                </CFIF>

            
        <CFIF HesapAmount EQ 0>
            <cfbreak>
        </CFIF>
        </cfloop>
        <cfif HesapAmount neq 0>
            <CFSET MESSAGE="STOK YETERSİZ">
            <cfset O.MESSAGE=MESSAGE>
            <cfset O.STATUS=0>
            <cfset O.STATUS_CODE=3>
            <cfreturn replace(serializeJSON(O),"//","")>
        </cfif>
<cfset attributes.ROWW="">
<CFSET attributes.SARF_STOCK_ID_LIST=mid(attributes.SARF_STOCK_ID_LIST,2,len(attributes.SARF_STOCK_ID_LIST)-1)>
<CFSET attributes.SARF_AMOUNT_LIST=mid(attributes.SARF_AMOUNT_LIST,2,len(attributes.SARF_AMOUNT_LIST)-1)>
<cfloop list="#attributes.SARF_STOCK_ID_LIST#" index="i" item="it">
    <cfoutput>
        <cfset qty=listGetAt(attributes.SARF_AMOUNT_LIST,i)>
        <cfset "attributes.STOCK_ID#i#"=it>
        <cfset "attributes.amount_other#i#"="">
        <cfset "attributes.unit_other#i#"="">
        <cfset "attributes.lot_no#i#"="">
        <cfset "attributes.QUANTITY#i#"=qty>
        <cfset "attributes.uniq_relation_id_#i#"=arguments.WRK_ROW_ID>
        <cfset "attributes.PBS_RELATION_ID#i#"=arguments.WRK_ROW_ID>
        <cfset attributes.ROWW="#attributes.ROWW#,#i#">
    </cfoutput>
</cfloop>
<cfset attributes.department_in ="">
    <cfset attributes.LOCATION_IN="">
    <cfset attributes.department_out=7>
    <cfset attributes.LOCATION_OUT =3>
    <cfset form.process_cat=88>
    <cfset attributes.process_cat = form.process_cat>
   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset amount_other="">
   <cfset unit_other="">
   <cfset attributes.lot_no="">
   
   <cfset attributes.wodate="1">
   <cfset attributes.clot=0>
<cfinclude template="../Tests/inc/StokFisQuery.cfm">
<cfscript>
    structClear(attributes);
</cfscript>


<cfset attributes.LOCATION_OUT="">
<cfset attributes.department_out="">
<cfset attributes.department_in =listGetAt(arguments.DEPO,1,"-")>
<cfset attributes.LOCATION_IN=listGetAt(arguments.DEPO,2,"-")>
<cfset form.process_cat=87>
<cfset attributes.process_cat = form.process_cat>
<cfset PROJECT_HEAD="">
<cfset PROJECT_HEAD_IN="">
<cfset PROJECT_ID="">
<cfset PROJECT_ID_IN="">
<cfset attributes.QUANTITY=MIKTARIM>
<cfset attributes.uniq_relation_id_="#arguments.WRK_ROW_ID#">
<cfset attributes.PBS_RELATION_ID=arguments.WRK_ROW_ID>
<cfset amount_other=1>
<cfset unit_other="#arguments.UNIT2#">
<cfset lot_no=arguments.LOT_NUMARASI>
<cfset attributes.ROWW=" ,">
<cfset attributes.wodate="1">
<CFSET attributes.STOCK_ID=getOI.STOCK_ID>
<cfset O.ATTR=attributes>
<cfset O.ARGSSS=arguments>
<cfset attributes.clot=1>
<cfinclude template="../Tests/inc/StokFisQuery.cfm">
<cfset attributes.FIS_ID=PBS_FIS_ID>

<!----
<cfinclude template="../Tests/inc/etiketYap.cfm">
<cfinclude template="../Tests/inc/etiket_2.cfm">
---->

<cfscript>
    structClear(attributes);    
</cfscript>

<cfset attributes.LOCATION_OUT="#listGetAt(arguments.DEPO,2,"-")#">
<cfset attributes.department_out="#listGetAt(arguments.DEPO,1,"-")#">

<cfset attributes.department_in =listGetAt(arguments.SIP_DEPO,1,"-")>
<cfset attributes.LOCATION_IN=listGetAt(arguments.SIP_DEPO,2,"-")>

<cfset form.process_cat=255>
<cfset attributes.process_cat = form.process_cat>
<cfset PROJECT_HEAD="">
<cfset PROJECT_HEAD_IN="">
<cfset PROJECT_ID="">
<cfset PROJECT_ID_IN="">
<cfset attributes.QUANTITY=MIKTARIM>
<cfset attributes.uniq_relation_id_="#arguments.WRK_ROW_ID#">
<cfset attributes.PBS_RELATION_ID=arguments.WRK_ROW_ID>
<cfset amount_other="1">
<cfset unit_other="#arguments.UNIT2#">
<cfset lot_no=arguments.LOT_NUMARASI>
<cfset attributes.ROWW=" ,">
<cfset attributes.wodate="1">
<CFSET attributes.STOCK_ID=getOI.STOCK_ID>
<cfset O.ATTR=attributes>
<cfset O.ARGSSS=arguments>
<cfset attributes.clot=1>
<cfinclude template="../Tests/inc/StokFisQuery.cfm">
<cfset attributes.FIS_ID=PBS_FIS_ID>
<!---
<cfinclude template="../Tests/inc/etiketYap.cfm">
<cfinclude template="../Tests/inc/etiket_2.cfm">
--->
<cfquery name="GETD" datasource="#DSN2#">
    SELECT SFR.LOT_NO,SFR.AMOUNT,S.PRODUCT_NAME,S.PRODUCT_DETAIL,S.PRODUCT_CODE_2,ISNULL(S.PRODUCT_CODE_2,S.PRODUCT_CODE) AS PCOD,SL.COMMENT,O.ORDER_NUMBER FROM #dsn2#.STOCK_FIS AS SF 
    INNER JOIN #dsn2#.STOCK_FIS_ROW AS SFR ON SF.FIS_ID=SFR.FIS_ID
    INNER JOIN #dsn3#.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID=SFR.PBS_RELATION_ID
    INNER JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
    INNER JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=SFR.STOCK_ID
    INNER JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=O.DELIVER_DEPT_ID AND SL.LOCATION_ID=O.LOCATION_ID
    WHERE SF.FIS_ID=#attributes.FIS_ID#
</cfquery>
<cfif GETD.recordcount>
<CFELSE>
    <cfquery name="GETD" datasource="#DSN2#">
        SELECT '#O.ARGSSS.LOT_NUMARASI#' LOT_NO,#O.ARGSSS.AMOUNT# AMOUNT,S.PRODUCT_NAME,S.PRODUCT_DETAIL,ISNULL(S.PRODUCT_CODE_2,S.PRODUCT_CODE) AS PCOD,SL.COMMENT,'' AS ORDER_NUMBER FROM #dsn3#.STOCKS AS S 
        LEFT JOIN #DSN#.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=#LISTGETAT(O.ARGSSS.SIP_DEPO,1,"-")# AND SL.LOCATION_ID=#LISTGETAT(O.ARGSSS.SIP_DEPO,2,"-")#
        WHERE PRODUCT_ID=#O.ARGSSS.PRODUCT_ID#
    </cfquery>
</cfif>
<!----
<cfsavecontent variable=EtiketData>
    <cfoutput>^XA^XFE:etiket2.ZPL^FS^CI28^FN1^FH\^FD#GETD.COMMENT#^FS^CI27^CI28^FN2^FH\^FD#GETD.ORDER_NUMBER#^FS^CI27 ^CI28^FN3^FH\^FD#GETD.PRODUCT_CODE_2#^FS^CI27^CI28^FN4^FH\^FD#GETD.PRODUCT_DETAIL#^FS^CI27^CI28^FN5^FH\^FD#GETD.LOT_NO#^FS^CI27^CI28^FN6^FH\^FD#GETD.AMOUNT#^FS^CI27^CI28^FN7^FH\^FD#GETD.PRODUCT_DETAIL#|#GETD.LOT_NO#||#GETD.AMOUNT#^FS^CI27^CI28^FN8^FH\^FD#GETD.PRODUCT_NAME#^FS^CI27^PQ1,0,1^XZ</cfoutput> 
 </cfsavecontent>---->
<cfset O.ATTR_AFTT=attributes>
<cfset O.COMMENT=GETD.COMMENT>
<cfset O.ORDER_NUMBER=GETD.ORDER_NUMBER>
<cfset O.PRODUCT_CODE_2=GETD.PCOD>
<cfset O.PRODUCT_DETAIL=GETD.PRODUCT_DETAIL>
<cfset O.LOT_NO=GETD.LOT_NO>
<cfset O.AMOUNT=GETD.AMOUNT>
<cfset O.PRODUCT_NAME=GETD.PRODUCT_NAME>
<CFSET MESSAGE="Kayıt Başarılı">
<cfset O.MESSAGE=MESSAGE>
<cfset O.STATUS=1>
<cfset O.STATUS_CODE=1>



<cfcatch>
    <CFSET MESSAGE=cfcatch>
    <cfset O.MESSAGE=MESSAGE>
<cfset O.STATUS=0>
<cfset O.STATUS_CODE=2>
</cfcatch>
</cftry>
<cfreturn replace(serializeJSON(O),"//","")>
    </cffunction>

<cffunction name="UpLot" access="remote" httpMethod="Post">
    <cfquery name="Upd" datasource="#dsn3#">
        UPDATE #dsn3#.PBS_LOT_NUMBER  SET LOT_NO=LOT_NO+1
    </cfquery>
</cffunction>
<cffunction name="getColData" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfquery name="getdadata" datasource="#dsn#">
        SELECT * FROM #dsn#.MODIFIED_PAGE WHERE CONTROLLER_NAME LIKE '%saleOrderController%' AND EVENT_LIST ='add'  AND POSITION_CODE <>-1
    </cfquery>
<cfreturn getdadata.JSON_DATA>
</cffunction>

<cffunction name="getLastRecords">
    <cfargument name="STATION_NAME">
    <cfquery name="getW" datasource="#dsn2#">
        SELECT TOP 5 * FROM W
    </cfquery>
</cffunction>
<cffunction name="deleteSelected" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="lot_no">
    <cfquery name="getHarekets" datasource="#dsn2#">
        SELECT DISTINCT SR.PROCESS_TYPE,SR.UPD_ID,SF.PROCESS_CAT,SR.UPD_ID,SF.FIS_NUMBER FROM #dsn2#.STOCKS_ROW AS SR
        INNER JOIN #dsn2#.STOCK_FIS AS SF ON SF.FIS_ID=SR.UPD_ID
        WHERE LOT_NO='#arguments.lot_no#'
    </cfquery>
    <cfset fis_sayisi=0>
    <cfloop query="getHarekets">
        <cfset fis_sayisi=fis_sayisi+1>
        <cfset attributes.del_fis =1>
        <cfset attributes.process_cat=PROCESS_CAT>
        <cfset attributes.cat=PROCESS_TYPE>
        <cfset attributes.type_id=PROCESS_TYPE>
        <cfset attributes.UPD_ID=UPD_ID>
        <cfset attributes.old_process_type=PROCESS_TYPE>
        <cfset attributes.FIS_NO =FIS_NUMBER>
        <cfset form.process_cat=PROCESS_CAT>
        <cfset form.cat=PROCESS_TYPE>
        <cfset form.type_id=PROCESS_TYPE>
        <cfset form.UPD_ID=UPD_ID>
        <cfset form.old_process_type=PROCESS_TYPE>
        <cfinclude template="/v16/stock/query/upd_fis_1_pbs.cfm">        
    </cfloop>
    <cfset ReturnObj.FIS_SAYISI=fis_sayisi>
    <cfset ReturnObj.STATUS=1>
    <cfreturn replace(serializeJSON(ReturnObj),"//","")>
</cffunction>

<cffunction name="deleteSelectedFis" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="FIS_ID">
    <cfquery name="getHarekets" datasource="#dsn2#">
        SELECT DISTINCT SR.PROCESS_TYPE,SR.UPD_ID,SF.PROCESS_CAT,SR.UPD_ID,SF.FIS_NUMBER FROM #dsn2#.STOCKS_ROW AS SR
        INNER JOIN #dsn2#.STOCK_FIS AS SF ON SF.FIS_ID=SR.UPD_ID
        WHERE SF.FIS_ID=#arguments.FIS_ID#
    </cfquery>
    <cfset fis_sayisi=0>
    <cfloop query="getHarekets">
        <cfset fis_sayisi=fis_sayisi+1>
        <cfset attributes.del_fis =1>
        <cfset attributes.process_cat=PROCESS_CAT>
        <cfset attributes.cat=PROCESS_TYPE>
        <cfset attributes.type_id=PROCESS_TYPE>
        <cfset attributes.UPD_ID=UPD_ID>
        <cfset attributes.old_process_type=PROCESS_TYPE>
        <cfset attributes.FIS_NO =FIS_NUMBER>
        <cfset form.process_cat=PROCESS_CAT>
        <cfset form.cat=PROCESS_TYPE>
        <cfset form.type_id=PROCESS_TYPE>
        <cfset form.UPD_ID=UPD_ID>
        <cfset form.old_process_type=PROCESS_TYPE>
        <cfinclude template="/v16/stock/query/upd_fis_1_pbs.cfm">        
    </cfloop>
    <cfset ReturnObj.FIS_SAYISI=fis_sayisi>
    <cfset ReturnObj.STATUS=1>
    <cfreturn replace(serializeJSON(ReturnObj),"//","")>
</cffunction>
<cffunction name="muhasebe_sil" output="false">
    <!---
    by :  20040227
    notes : Muhasebe fişi siler...(Tahsil-Tediye-Mahsup)
            !!! TRANSACTION icinde kullanılmalıdır !!! Fonksiyon sorunsuz çalistiginda true döndürür.
    usage :
        muhasebe_sil (action_id:attributes.id,process_type:90);
    revisions :
    muhasebe sil fonksiyonuna history silme bölümü eklenmedi, boylece silinen kayıtların detaylı loglarını tutuyoruz
    --->
    <cfargument name="action_id" required="yes" type="numeric">
    <cfargument name="process_type" required="yes" type="numeric">
    <cfargument name="muhasebe_db" type="string" default="#dsn2#">	
    <cfargument name="muhasebe_db_alias" type="string" default="">
    <cfargument name="belge_no" type="string" default="">
    <cfargument name="action_table" type="string">
    <cfif arguments.muhasebe_db is not '#dsn2#'>
        <cfset arguments.muhasebe_db_alias = '#dsn2_alias#'&'.'>
    <cfelse>
        <cfset arguments.muhasebe_db_alias =''>
    </cfif>
    <cfquery name="GET_CARD_ID" datasource="#arguments.muhasebe_db#">
        SELECT
            CARD_ID,
            ACTION_ID,
            BILL_NO,
            ACTION_DATE
        FROM
            #arguments.muhasebe_db_alias#ACCOUNT_CARD
        WHERE
            ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
            AND ACTION_TYPE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_type#">
            AND ISNULL(IS_CANCEL,0)=0
            <cfif isDefined('arguments.action_table') and len(arguments.action_table)> 
                AND ACTION_TABLE = '#arguments.action_table#'
            </cfif>
    </cfquery>
    <cfif GET_CARD_ID.RECORDCOUNT>
        <!--- e-defter islem kontrolu FA --->
        <cfif session.ep.our_company_info.is_edefter eq 1>
            <cfstoredproc procedure="GET_NETBOOK" datasource="#arguments.muhasebe_db#">
                <cfprocparam cfsqltype="cf_sql_timestamp" value="#GET_CARD_ID.ACTION_DATE#">
                <cfprocparam cfsqltype="cf_sql_timestamp" value="#GET_CARD_ID.ACTION_DATE#">
                <cfprocparam cfsqltype="cf_sql_varchar" value="#arguments.muhasebe_db_alias#">
                <cfprocresult name="getNetbook">
            </cfstoredproc>
            <cfif getNetbook.recordcount>
                <script type="text/javascript">
                    alert('Muhasebeci : İşlemi yapamazsınız. İşlem tarihine ait e-defter bulunmaktadır.');
                </script>
                <cfabort>
            </cfif>
        </cfif>
        <!--- e-defter islem kontrolu FA --->
        
        <!--- FBS 20120606 Belgelerde Birden Fazla Fis Olustugunda, Belge Silindiginde Fislerin Tamaminin Silinmesi Icin CARD_ID IN ile Cekiliyor  --->
        <cfquery name="DEL_ACCOUNT_CARD" datasource="#arguments.muhasebe_db#">
            DELETE FROM #arguments.muhasebe_db_alias#ACCOUNT_CARD WHERE CARD_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(GET_CARD_ID.CARD_ID)#" list="yes">)
        </cfquery>
        <cfquery name="DEL_ACCOUNT_CARD_ROWS" datasource="#arguments.muhasebe_db#">
            DELETE FROM #arguments.muhasebe_db_alias#ACCOUNT_CARD_ROWS WHERE CARD_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(GET_CARD_ID.CARD_ID)#" list="yes">)
        </cfquery>
        <cfquery name="DEL_ACCOUNT_ROWS_IFRS" datasource="#arguments.muhasebe_db#">
            DELETE FROM #arguments.muhasebe_db_alias#ACCOUNT_ROWS_IFRS WHERE CARD_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(GET_CARD_ID.CARD_ID)#" list="yes">)
        </cfquery>
        <cfquery name="ADD_LOG" datasource="#arguments.muhasebe_db#">
            INSERT INTO
                #dsn_alias#.WRK_LOG
            (
                PROCESS_TYPE,
                EMPLOYEE_ID,
                LOG_TYPE,
                LOG_DATE,
                <cfif len(arguments.belge_no)>
                 PAPER_NO, 
                </cfif>
                FUSEACTION,
                ACTION_ID,
                ACTION_NAME,
                PERIOD_ID
                
            )
            VALUES
            (	
                #arguments.process_type#,
                #session.ep.userid#,
                -1,
                #now()#,
                <cfif len(arguments.belge_no)>
                    '#arguments.belge_no#', 
                </cfif>
                <cfif isdefined("fusebox.circuit")>
                    '#fusebox.circuit#  #fusebox.fuseaction#',
                <cfelse>
                    '#caller.fusebox.circuit#  #caller.fusebox.fuseaction#',
                </cfif>
                #arguments.action_id#,
                '#left(GET_CARD_ID.BILL_NO,250)#',
                #session.ep.period_id#
            )
        </cfquery>
    </cfif>
    <cfreturn true>
</cffunction>
<cffunction name="del_serial_no" output="false">
    <cfargument name="process_id" type="numeric" required="true">
    <cfargument name="process_cat" type="numeric" required="true">
    <cfargument name="period_id" type="numeric" required="true">
    <cfargument name="is_dsn3" type="numeric" required="no" default="0">

    <cfif arguments.is_dsn3 eq 0>
        <cfset serial_dsn = '#DSN2#' />
        <cfset dsn_add_ = '#dsn3_alias#' />
    <cfelse>
        <cfset serial_dsn = '#DSN3#' />
        <cfset dsn_add_ = '' />
    </cfif>

    <cfquery name="del_serial_numbers" datasource="#serial_dsn#">
        DELETE FROM 
            <cfif len(dsn_add_)>#dsn_add_#.</cfif>SERVICE_GUARANTY_NEW 
        WHERE
            PROCESS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_id#"> AND
            PROCESS_CAT = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_cat#"> AND
            PERIOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.period_id#">
    </cfquery>
    <!--- BK kaldirdi 6 aya kaldirilmali. 20130529
    <cfquery name="del_serial_numbers_history" datasource="#serial_dsn#">
        DELETE FROM 
            <cfif len(dsn_add_)>#dsn_add_#.</cfif>SERVICE_GUARANTY_NEW_HISTORY 
        WHERE
            PROCESS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_id#"> AND
            PROCESS_CAT = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_cat#"> AND
            PERIOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.period_id#">
    </cfquery> --->
    <cfreturn true>
</cffunction>
<cffunction name="butce_sil" output="false">
    <!---
    by :  20060125
    notes : Butce fişi siler...
            !!! TRANSACTION icinde kullanılmalıdır !!!, ancak bu durumda transaction icindeki diger queryler de
            bu fonksiyon gibi dsn2 den calismalidir. Fonksiyon sorunsuz calistiginda true döndürür.
    usage :
        butce_sil (action_id:attributes.id,muhasebe_db:dsn2,process_type:process_type(fatura icin bos olmalı),is_stock_fis:1(stok fis ise true));
    revisions :TolgaS 20070211
    --->
    <cfargument name="action_id" required="yes" type="numeric">
    <cfargument name="process_type" type="string" default="">
    <cfargument name="muhasebe_db" type="string" default="#dsn2#">
    <cfargument name="muhasebe_db_alias" type="string" default="">
    <cfargument name="is_stock_fis" type="boolean" default="0">
    <cfargument name="reserv_type" type="string" default=""> <!--- Rezerv_type gelirse expense_reserved_rows tablosuna kayıt atar --->
        <cfif arguments.muhasebe_db is not '#dsn2#'>
            <cfset arguments.muhasebe_db_alias = '#dsn2_alias#'&'.'>
        <cfelse>
            <cfset arguments.muhasebe_db_alias =''>
        </cfif>
        <cfif len(arguments.process_type)><!--- banka vs tipi yerlerden gelen işlemler için --->
            <cfquery name="DEL_COST_FIS" datasource="#arguments.muhasebe_db#">
                DELETE FROM <cfif not len(arguments.reserv_type)>#arguments.muhasebe_db_alias#EXPENSE_ITEMS_ROWS <cfelse> #arguments.muhasebe_db_alias#EXPENSE_RESERVED_ROWS</cfif> WHERE ACTION_ID = #arguments.action_id# AND EXPENSE_COST_TYPE = #arguments.process_type# AND (ACTION_TABLE IS NULL OR ACTION_TABLE <> 'EMPLOYEES_PUANTAJ')
            </cfquery>
        <cfelse><!--- fatura dağılımları --->
            <cfif arguments.is_stock_fis eq 0>
                <cfquery name="DEL_COST_FIS" datasource="#arguments.muhasebe_db#">
                    DELETE FROM <cfif not len(arguments.reserv_type)>#arguments.muhasebe_db_alias#EXPENSE_ITEMS_ROWS <cfelse> #arguments.muhasebe_db_alias#EXPENSE_RESERVED_ROWS</cfif> WHERE INVOICE_ID = #arguments.action_id#
                </cfquery>
            <cfelse>
                <cfquery name="DEL_COST_FIS" datasource="#arguments.muhasebe_db#">
                    DELETE FROM <cfif not len(arguments.reserv_type)>#arguments.muhasebe_db_alias#EXPENSE_ITEMS_ROWS <cfelse> #arguments.muhasebe_db_alias#EXPENSE_RESERVED_ROWS</cfif> WHERE STOCK_FIS_ID = #arguments.action_id#
                </cfquery>
            </cfif>
        </cfif>
    <cfreturn true>
</cffunction>
<cffunction name="cost_action" returntype="numeric" output="TRUE">
    <!---
    by : TolgaS 20061205
        TolgaS 20070601
    notes : 
        .....bir islemden(fatura, irasaliye,stok fis veya uretim) sonra o belge ile ilgili maliyet duzenlemelerinin yapilmasi.....
        fonsiyon bir popup açıyor ve o sayfada cfhttp ile yönlenme yapılıyor ve popup kapanıyor. popup olmasının sebebi sayfanın beklemesini engellemek bu sayade kullanıcı işlemine devam ederken arkada maliyet işlemi çalışmaya devam ediyor...
        PRODUCT_COST_LOG tablosuna kayit atilliyor fonsiyon basinda islem bittimindde objects2.emptypopup_cost_action daki belgede PRODUCT_COST_REFERENCE tablosuna kayit atiyor yani PRODUCT_COST_LOG da kayitli olan ancak PRODUCT_COST_REFERENCE olamyanlar yarim kalmis islemlerdir
    usage :
        cost_action(
                action_type: 1, (1:fatura, 2:irsaliye, 3: fis, 4:uretim, 5: stok virman,6: masraf fişi)
                action_id: invoce.invoice_id, (belge idsi)
                query_type:1 (yapilan islem turu (1:ekleme,2:guncelleme,3:silme))
            );
    --->
    <cfargument name="action_type" type="numeric" required="yes" default="1"> <!--- fatura:1 , irsaliye:2, fis:3, üretim:4 , stok virman:5 --->
    <cfargument name="action_id" type="numeric" required="yes"><!--- islem tipi idsi --->
    <cfargument name="query_type" type="numeric" required="yes" default="1"><!--- islem silme güncelleme mi yoksa eklememi add:1 , update:2 , delete: 3 --->
    <cfargument name="dsn_type" type="string" required="no" default="#dsn3#">
    <cfargument name="period_dsn_type" type="string" required="no" default="#dsn2#">
    <cfargument name="is_popup" type="numeric" required="no" default="1"><!--- popup acılsınmı yoksa mevcut sayfadamı yonlensin 1: popup 0:mevcut sayfa  (satış işlemlerinde kullanılıyor bir sonraki alışı bularak tekrar çalıştığından bu yol izlendi)--->
    <cfargument name="multi_cost_page" type="string" required="no" default=""><!--- Gruplanmış üretim sonuçları için maliyet oluştururken her biri için maliyet oluştursun diye popup isimlerini değiştirmek için eklendi,maliyete bu kısım için bir blok eklenince kaldırılacak. --->

    <cfargument name="user_id" type="numeric" required="no" default="#session.ep.userid#"><!--- islemi yapan 0 bunlar schedulle yollanmalı diger yerlerde gerek yok --->
    <cfargument name="period_id" type="numeric" required="no" default="#session.ep.period_id#"><!--- period bunlar schedulle yollanmalı diger yerlerde gerek yok--->
    <cfargument name="company_id" type="numeric" required="no" default="#session.ep.company_id#"><!--- sirket bunlar schedulle yollanmalı diger yerlerde gerek yok--->
    <cfargument name="is_schedules" required="false" default="">

    <cfif isdefined('arguments.multi_cost_page') and arguments.multi_cost_page is 1>
        <cfset popup_page_name = "add_cost_wind_#arguments.action_id#">
    <cfelse>
        <cfset popup_page_name = "add_cost_wind">
    </cfif>
    <cfif not len(is_schedules)>
        <script type="text/javascript">
            <cfif isDefined("session.pda")>
                window.open('<cfoutput>#request.self#?fuseaction=pda.emptypopup_cost_action&action_type=#arguments.action_type#&action_id=#arguments.action_id#&dsn_type=#arguments.dsn_type#&period_dsn_type=#arguments.period_dsn_type#&query_type=#arguments.query_type#&user_id=#session.pda.userid#&period_id=#session.pda.period_id#&company_id=#session.pda.our_company_id#</cfoutput>',"#popup_page_name#","height=75,width=350");
            <cfelse>
                window.open('<cfoutput>/index.cfm?fuseaction=objects.emptypopup_cost_action&action_type=#arguments.action_type#&action_id=#arguments.action_id#&dsn_type=#arguments.dsn_type#&period_dsn_type=#arguments.period_dsn_type#&query_type=#arguments.query_type#&user_id=#session.ep.userid#&period_id=#session.ep.period_id#&company_id=#session.ep.company_id#</cfoutput>',"#popup_page_name#","height=75,width=350");
            </cfif>
        </script>
    <cfelse>
        <cfset attributes.action_type = arguments.action_type>
        <cfset attributes.action_id = arguments.action_id>
        <cfset attributes.dsn_type = arguments.dsn_type>
        <cfset attributes.period_dsn_type = arguments.period_dsn_type>
        <cfset attributes.query_type = arguments.query_type>
        <cfset attributes.user_id = arguments.user_id>
        <cfset attributes.period_id = arguments.period_id>
        <cfset attributes.company_id = arguments.company_id>
        <cfset attributes.dsn_alias = dsn_alias>
        <cfset attributes.dsn1_alias = dsn1>
        <cfset attributes.dsn3 = dsn3>
        <cfset attributes.dsn3_alias = dsn3_alias>
        <cfset attributes.is_schedules = arguments.is_schedules>
        <cfset attributes.is_prod_cost_type = arguments.is_prod_cost_type>
        <cfset attributes.is_stock_based_cost = arguments.is_stock_based_cost>
        <cfset attributes.fuseaction = 'objects.emptypopup_cost_action'>
        <cfset system_ip = attributes.is_schedules>
        <cfinclude template="../V16/objects/query/cost_action.cfm">
    </cfif>
    <cfquery name="ADD_PROCESS_START" datasource="#dsn1#">
        INSERT INTO 
            PRODUCT_COST_LOG
            (
                ACTION_TYPE,
                ACTION_ID,
                QUERY_TYPE,
                PERIOD_ID,
                OUR_COMPANY_ID,
                RECORD_DATE,
                RECORD_EMP,
                RECORD_IP
            )
        VALUES
            (
                #arguments.action_type#,
                #arguments.action_id#,
                #arguments.query_type#,
                
                <cfif isDefined("session.pda")>
                    #arguments.period_id#,
                    #session.pda.our_company_id#,
                    #now()#,
                    #session.pda.userid#,
                <cfelse>
                    #arguments.period_id#,
                    #arguments.company_id#,
                    #now()#,
                    #arguments.user_id#,
                </cfif>
                '#cgi.REMOTE_ADDR#'
            )
    </cfquery>
    <cfreturn 1>
</cffunction>
<cffunction name="getShelfProducts">
    <cfquery name="getrafd" datasource="#arguments.dsn3#">
    
        SELECT SUM(AMOUNT) AS A,SUM(AMOUNT2) AS A2,T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PP.PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID FROM (
        SELECT SUM(AMOUNT) AMOUNT ,SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM (
        SELECT SR.AMOUNT, UNIT ,SR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,ROW_PROJECT_ID AS PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM #DSN2#.SHIP_ROW AS SR
            LEFT JOIN #DSN2#.SHIP AS S ON S.SHIP_ID=SR.SHIP_ID
            WHERE 1=1
        AND S.DEPARTMENT_IN=13 
        
        ) AS T2 GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2
        UNION ALL
        SELECT -1* SUM(AMOUNT) AMOUNT,-1* SUM(AMOUNT2) AMOUNT2,PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2 FROM (
        SELECT SFR.AMOUNT,UNIT,SFR.AMOUNT2,UNIT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,PROJECT_ID,LOT_NO,ISNULL(TO_SHELF_NUMBER,SHELF_NUMBER) SHELF_NUMBER,STOCK_ID FROM #DSN2#.STOCK_FIS_ROW AS SFR 
            LEFT JOIN #DSN2#.STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID
        WHERE SF.DEPARTMENT_OUT=13
        
        ) AS T GROUP BY PROJECT_ID,LOT_NO,SHELF_NUMBER,STOCK_ID,UNIT,UNIT2
        
        ) AS T2
        LEFT JOIN #DSN#.PRO_PROJECTS AS PP ON PP.PROJECT_ID=T2.PROJECT_ID
        LEFT JOIN #DSN3#.STOCKS AS  S ON S.STOCK_ID=T2.STOCK_ID
        LEFT JOIN #DSN3#.PRODUCT_PLACE AS PS ON PS.PRODUCT_PLACE_ID=T2.SHELF_NUMBER
        GROUP BY T2.PROJECT_ID,LOT_NO,SHELF_NUMBER,PROJECT_HEAD,T2.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,UNIT,UNIT2,PS.SHELF_CODE,STORE_ID,PS.LOCATION_ID
        </cfquery>
</cffunction>
</cfcomponent>