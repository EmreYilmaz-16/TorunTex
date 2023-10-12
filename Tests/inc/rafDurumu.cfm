<cfquery name="getrafd" datasource="#dsn3#">
    select SHELF_CODE,TTL.* from w3Toruntex_1.PRODUCT_PLACE 
left join (SELECT SUM(AMOUNT) A ,SUM(AMOUNT2) A2,CV,UNIT,UNIT2,LOT_NO,T.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,PP.PROJECT_ID,PP.PROJECT_HEAD,SHELF_NUMBER FROM (
SELECT ISNULL(AMOUNT,0)AMOUNT,ISNULL(AMOUNT2,0)AMOUNT2,CONVERT(DECIMAL(18,2),ISNULL(AMOUNT,0)/ISNULL(AMOUNT2,0)) AS CV,UNIT,UNIT2,LOT_NO,STOCK_ID,ROW_PROJECT_ID PROJECT_ID,TO_SHELF_NUMBER AS SHELF_NUMBER FROM w3Toruntex_2023_1.SHIP_ROW  
WHERE 1=1  
UNION ALL
SELECT  -1* ISNULL(AMOUNT,0)AMOUNT,-1* ISNULL(AMOUNT2,0)AMOUNT2,CONVERT(DECIMAL(18,2),ISNULL(AMOUNT,0)/ISNULL(AMOUNT2,0)) AS CV,UNIT,UNIT2,LOT_NO,STOCK_ID,S.PROJECT_ID PROJECT_ID,SHELF_NUMBER FROM w3Toruntex_2023_1.STOCK_FIS_ROW 
LEFT JOIN w3Toruntex_2023_1.STOCK_FIS AS S ON STOCK_FIS_ROW.FIS_ID=S.FIS_ID
WHERE 1=1 
) AS T  
LEFT JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=T.STOCK_ID
LEFT JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID=T.PROJECT_ID
GROUP BY CV,UNIT,UNIT2,LOT_NO,T.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,PP.PROJECT_ID,PP.PROJECT_HEAD,SHELF_NUMBER ) as ttl on ttl.SHELF_NUMBER=PRODUCT_PLACE.PRODUCT_PLACE_ID

where STORE_ID=7 and LOCATION_ID=1
</cfquery>

<cf_box title="Raf Durumu">
    <cf_grid_list>
        <thead>
            <tr>
                <th>Raf</th>
                <th>Ürün</th>
                <th>Miktar</th>
                <th>Miktar2</th>
                <th>Lot No</th>
                <th>Antrepo</th>
                
            </tr>
            <cfoutput query="getrafd">
                <tr>
                    <td>#SHELF_CODE#</td>
                    <td>
                        #PRODUCT_NAME#
                    </td>
                    <td>
                        #A# #UNIT#
                    </td>
                    
                    <td>
                        #A2# #UNIT2#
                    </td>
                    <td>
                        #LOT_NO#
                    </td>
                    <td>
                        #PROJECT_HEAD#
                    </td>                   
                </tr>
            </cfoutput>
        </thead>
    </cf_grid_list>
</cf_box>