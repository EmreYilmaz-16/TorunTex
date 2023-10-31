<cfcomponent>
    <cfset dsn3="w3Toruntex_1">
    <cfset dsn="w3Toruntex">
    <cfset dsn3_alias="w3Toruntex_1">
    <cfset dsn2="w3Toruntex_2023_1">
    <cfset dsn2_alias="w3Toruntex_2023_1">
    <cffunction name="SendMasa" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfdump var="#arguments#">
        <cfset F=structKeyArray(arguments)>
        <cfset FormData=deserializeJSON(f[1])>
        <cfdump var="#FormData#">
        <cfif isDefined("FormData.RAF_DATA")>
            

        <cfelse>
            
        </cfif>
    <cfset attributes.LOCATION_IN=4>
    <cfset attributes.LOCATION_OUT=7>
    <cfset attributes.department_out=7>
    <cfset attributes.department_in =7>
    <cfset form.process_cat=90>
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

<cffunction name="getOrders" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="PRODUCT_ID">
        <cfquery name="GETDATA" datasource="#DSN3#">
            SELECT ORR.WRK_ROW_ID,ORR.ORDER_ROW_ID,ORR.PRODUCT_ID,O.ORDER_ID,C.COMPANY_ID,O.PRIORITY_ID,O.ORDER_HEAD,O.ORDER_NUMBER,C.NICKNAME,CONVERT(INT,SP.PRIORITY) AS PP FROM ORDER_ROW AS ORR
            LEFT JOIN ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
            LEFT JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
            LEFT JOIN #DSN#.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID=O.PRIORITY_ID
            WHERE ORR.PRODUCT_ID=#arguments.PRODUCT_ID#
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
    <cffunction name="getAOrder" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="ORDER_ROW_ID">
        <cfquery name="GETDATA" datasource="#DSN3#">
            SELECT QUANTITY
                ,UNIT
                ,BASKET_EXTRA_INFO_ID
                ,AMOUNT2
                ,UNIT2
                ,DETAIL_INFO_EXTRA
                ,PROPERTY1
                ,PROPERTY2
                ,PROPERTY3
                ,PROPERTY4
                ,PROPERTY5
                ,PROPERTY6
                ,ORDER_ROW_ID
                ,WRK_ROW_ID
                ,STOCKS.PRODUCT_ID
                ,STOCKS.STOCK_ID
                ,STOCKS.PRODUCT_NAME
                ,STOCKS.PRODUCT_CODE
                ,ORDER_ROW.ORDER_ID
                ,SC.COUNTRY_NAME
                ,C.NICKNAME
                ,SBI_1.BASKET_INFO_TYPE AS A1
                ,SBI_2.BASKET_INFO_TYPE AS A2
            FROM w3Toruntex_1.ORDER_ROW
            LEFT JOIN w3Toruntex_1.ORDER_INFO_PLUS ON ORDER_ROW.ORDER_ID = ORDER_INFO_PLUS.ORDER_ID
            LEFT JOIN w3Toruntex_1.STOCKS ON STOCKS.STOCK_ID = ORDER_ROW.STOCK_ID
            LEFT JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID = ORDER_ROW.ORDER_ID
            LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
            LEFT JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID=O.COUNTRY_ID
            LEFT JOIN w3Toruntex_1.SETUP_BASKET_INFO_TYPES  AS SBI_1 ON ORDER_ROW.SELECT_INFO_EXTRA =SBI_1.BASKET_INFO_TYPE_ID
            LEFT JOIN w3Toruntex_1.SETUP_BASKET_INFO_TYPES  AS SBI_2 ON ORDER_ROW.BASKET_EXTRA_INFO_ID =SBI_2.BASKET_INFO_TYPE_ID
            WHERE ORDER_ROW.ORDER_ROW_ID = #arguments.ORDER_ROW_ID#        
        </cfquery>
   <cfquery name="GETDATA2" datasource="#DSN3#">
    select QUANTITY,UNIT,
    ISNULL((
        SELECT SUM(AMOUNT) FROM #dsn2#.STOCK_FIS_ROW AS SFR 
INNER JOIN #dsn2#.STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID
WHERE SFR.WRK_ROW_RELATION_ID=ORDER_ROW.WRK_ROW_ID AND  SF.LOCATION_IN=O.DELIVER_DEPT_ID AND SF.DEPARTMENT_IN=O.LOCATION_ID
    ),0) AS R_AMOUNT,
    BASKET_EXTRA_INFO_ID,AMOUNT2,UNIT2,DETAIL_INFO_EXTRA,PROPERTY1,PROPERTY2,PROPERTY3,PROPERTY4,PROPERTY5,PROPERTY6,ORDER_ROW_ID,WRK_ROW_ID,STOCKS.PRODUCT_ID,STOCKS.STOCK_ID,STOCKS.PRODUCT_NAME,STOCKS.PRODUCT_CODE
     from w3Toruntex_1.ORDER_ROW 
     LEFT JOIN w3Toruntex_1.ORDER_INFO_PLUS ON ORDER_ROW.ORDER_ID=ORDER_INFO_PLUS.ORDER_ID
     LEFT JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=ORDER_ROW.ORDER_ID
     LEFT JOIN w3Toruntex_1.STOCKS ON STOCKS.STOCK_ID=ORDER_ROW.STOCK_ID
     
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
        PROPERTY5=PROPERTY5,
        PROPERTY6=PROPERTY6,
        ORDER_ROW_ID=ORDER_ROW_ID,
        WRK_ROW_ID=WRK_ROW_ID,
        PRODUCT_ID=PRODUCT_ID,
        STOCK_ID=STOCK_ID,
        PRODUCT_NAME=PRODUCT_NAME,
        PRODUCT_CODE=PRODUCT_CODE,
        A1=A1,
        A2=A2
        
    }>
    <cfscript>
        
    </cfscript>
</cfloop>
<cfset RETURN_ITEM.ALL_ROWS=ALL_ROWS>
<cfreturn replace(serializeJSON(RETURN_ITEM),"//","")>
    </cffunction>

    <cffunction name="SaveBelge" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="AMOUNT">
        <cfargument name="WRK_ROW_ID">
        <cfquery name="getOI" datasource="#dsn3#">
            SELECT  * FROM ORDER_ROW WHERE WRK_ROW_ID='#arguments.WRK_ROW_ID#'
        </cfquery>
        <cfquery name="GETRELATEDPRODUCT" datasource="#DSN3#">
            SELECT * FROM w3Toruntex_1.RELATED_PRODUCT WHERE PRODUCT_ID=#getOI.PRODUCT_ID# ORDER BY RELATED_PRODUCT_NO
        </cfquery>
        <CFSET SARF_STOCK_ID=0>
        <CFSET attributes.SARF_STOCK_ID_LIST="">
        <CFSET attributes.SARF_AMOUNT_LIST="">
        <cfset T_AMOUNT=0>
        <cfset HesapAmount=arguments.AMOUNT>
        <cfloop query="GETRELATEDPRODUCT">
            <cfquery name="GETS" datasource="#dsn2#">
                SELECT SUM(STOCK_IN-STOCK_OUT) AS BAKIYE,STOCK_ID,PRODUCT_ID FROM w3Toruntex_2023_1.STOCKS_ROW WHERE STORE=7 AND STORE_LOCATION=4 AND PRODUCT_ID=#GETRELATEDPRODUCT.RELATED_PRODUCT_ID# GROUP BY STOCK_ID,PRODUCT_ID
            </cfquery>
            <cfdump var="#GETS#">
            <CFIF listLen(attributes.SARF_STOCK_ID_LIST)>
                <CFIF GETS.recordCount AND  (GETS.BAKIYE LT HesapAmount AND GETS.BAKIYE NEQ 0)>
                    <CFSET HesapAmount=HesapAmount-GETS.BAKIYE>
                    <CFSET attributes.SARF_STOCK_ID_LIST="#attributes.SARF_STOCK_ID_LIST#,#GETS.STOCK_ID#">
                    <CFSET attributes.SARF_AMOUNT_LIST="#attributes.SARF_AMOUNT_LIST#,#GETS.BAKIYE#">
                <CFELSEIF GETS.BAKIYE GTE HesapAmount> 
                    <CFSET attributes.SARF_STOCK_ID_LIST="#attributes.SARF_STOCK_ID_LIST#,#GETS.STOCK_ID#">
                    <CFSET attributes.SARF_AMOUNT_LIST="#attributes.SARF_AMOUNT_LIST#,#HesapAmount#">
                    <CFSET HesapAmount=0>
                </CFIF>
            </CFIF>
        <CFIF HesapAmount EQ 0>
            <cfbreak>
        </CFIF>
        </cfloop>
<cfdump var="#attributes#">
    </cffunction>
</cfcomponent>