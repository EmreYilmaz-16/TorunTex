<cftry>
<cfquery name="getCekiListesi" datasource="#dsn3#">
    SELECT S.PRODUCT_NAME
       ,S.STOCK_ID
       ,S.PRODUCT_ID
       ,S.PRODUCT_CODE
       ,S.PRODUCT_CODE_2
       ,S.PRODUCT_UNIT_ID
       ,SSR.AMOUNT
       ,ISNULL(SR.WRK_ROW_ID,'') WRK_ROW_ID
       ,SSR.LOT_NO
       ,PU.MAIN_UNIT
       ,O.ORDER_ID
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
   WHERE SR.SEPET_ID = #attributes.action_id#  AND SSR.LOT_NO IS NOT NULL ORDER BY S.PRODUCT_ID
    
   
   </cfquery>
<cfquery name="GETDATA" datasource="#DSN3#">
    SELECT S.PRODUCT_NAME
        ,S.PRODUCT_ID
        ,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
        ,ISNULL(SEVKIYAT_SEPET_ROW_PBS.AMOUNT,0) AS AMOUNT_
        ,ISNULL(SEVKIYAT_SEPET_ROW_PBS.AMOUNT2,0) AS AMOUNT2_
        ,ISNULL(SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT),0) AS AMOUNT
        ,ISNULL(SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT2),0) AS AMOUNT2
    FROM w3Toruntex_1.SEVKIYAT_SEPET_ROW_PBS
    LEFT JOIN w3Toruntex_1.SEVKIYAT_SEPET_ROW_READ_PBS ON SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID = SEVKIYAT_SEPET_ROW_READ_PBS.SEPET_ROW_ID
    LEFT JOIN w3Toruntex_1.STOCKS AS S ON S.PRODUCT_ID = SEVKIYAT_SEPET_ROW_PBS.PRODUCT_ID
    WHERE SEVKIYAT_SEPET_ROW_PBS.SEPET_ID = #attributes.action_id# 
    GROUP BY S.PRODUCT_NAME
        ,S.PRODUCT_ID
        ,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2
        </cfquery>
<cfoutput>
    <table class="table table-sm table-bordered">
        <tr>
            <td>#getSepet.SEVK_NO#</td>
            <td>#getSepet.NICKNAME#</td>
            <td>#getSepet.COUNTRY_NAME#</td>
            <td>#getSepet.PLAKA#</td>
            <td>#getSepet.KONTEYNER#</td>
            <td>#getSepet.DEPARTMENT_HEAD# - #getSepet.COMMENT#</td>
        </tr>
    </table>
</cfoutput>

<table class="table table-sm table-bordered">
    <thead>
        <tr>
            <th>Ürün K.</th>
            <th>Ürün</th>
            <th>Miktar</th>
        </tr>
        
    </thead>
   <cfoutput query="getCekiListesi">
    <tr>
        <td>#PRODUCT_CODE_2#</td>
        <td>#PRODUCT_NAME#</td>
        <td>#AMOUNT#</td>
        
    </tr>
   </cfoutput>

</table>
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>