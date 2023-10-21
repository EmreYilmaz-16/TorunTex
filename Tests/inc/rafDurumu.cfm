<cfquery name="getrafd" datasource="#dsn3#">
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
                    <td><CFIF LEN(STORE_ID) EQ 1>0#STORE_ID#<CFELSE>#STORE_ID#</CFIF>-<CFIF LEN(LOCATION_ID) EQ 1>0#LOCATION_ID#<CFELSE>#LOCATION_ID#</CFIF>-#SHELF_CODE#</td>
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