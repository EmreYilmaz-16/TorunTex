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
       AND P.PRODUCT_ID = S.PRODUCT_ID AND P.FINISHDATE IS NULL
   WHERE SR.SEPET_ID = #attributes.action_id#  AND SSR.LOT_NO IS NOT NULL ORDER BY S.PRODUCT_ID
    
   
   </cfquery>
           <cfquery name="getSepet" datasource="#dsn3#">
            SELECT ISNULL(IS_CLOSED, 0) IS_CLOSED
                ,SEVK_NO
                ,SS.DEPARTMENT_ID
                ,SS.LOCATION_ID
                ,SS.ORDER_ID
                ,O.ORDER_NUMBER
                ,C.NICKNAME
                ,SC.COUNTRY_NAME
                ,SL.COMMENT
                ,D.DEPARTMENT_HEAD
                ,'PLAKA' AS PLAKA
                ,'KONTEYNER NO ' AS KONTEYNER
            FROM #dsn3#.SEVKIYAT_SEPET_PBS SS
            LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID = SS.ORDER_ID
            LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
            LEFT JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = C.COUNTRY
            LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = SS.LOCATION_ID
                AND SL.DEPARTMENT_ID = SS.DEPARTMENT_ID
            LEFT JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = SS.DEPARTMENT_ID
            WHERE SEPET_ID = #attributes.action_id#
        </cfquery>

<cfoutput>
    <cf_grid_list class="table table-sm table-bordered">
        <tr>
            <td>#getSepet.SEVK_NO#</td>
            <td>#getSepet.NICKNAME#</td>
            <td>#getSepet.COUNTRY_NAME#</td>
            <td>#getSepet.PLAKA#</td>
            <td>#getSepet.KONTEYNER#</td>
            <td>#getSepet.DEPARTMENT_HEAD# - #getSepet.COMMENT#</td>
        </tr>
    </cf_grid_list>
</cfoutput>

<cf_grid_list class="table table-sm table-bordered">
    <thead>
        <tr>
            <th></th>
            <th>Lot No</th>
            <th>Ürün K.</th>            
            <th>Ürün</th>
            <th>Miktar</th>
        </tr>
        
    </thead>
    <tbody>
        <cfset toplamA=0>
   <cfoutput query="getCekiListesi">
    <tr>
        <td>#currentrow#</td>
        <td>#LOT_NO#</td>
        <td>#PRODUCT_CODE_2#</td>
        <td>#PRODUCT_NAME#</td>
        <td style="text-align:right">#tlformat(AMOUNT)#</td>
        <cfset toplamA +=AMOUNT>
    </tr>
   </cfoutput>
</tbody>
<tfoot>
    <tr>
        <th colspan="4">

        </th>
        <th style="text-align:right">
            <cfoutput>#tlformat(toplamA)# Kg.</cfoutput>
        </th>
        
    </tr>
</tfoot>
</cf_grid_list>
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>