<cf_box title="Çuval Al">

<cfquery name="getS2" datasource="#dsn3#">
    select * from #dsn3#.PRODUCT_PLACE where SHELF_CODE='#listgetAt(attributes.RAF,3,"-")#' and STORE_ID =#listgetAt(attributes.RAF,1,"-")# and LOCATION_ID =#listgetAt(attributes.RAF,2,"-")#
</cfquery>


<cfif getS2.recordCount>
    <cfquery name="gets" datasource="#dsn2#">

SELECT SUM(AMOUNT) A ,SUM(AMOUNT2) A2,CV,UNIT,UNIT2,LOT_NO,T.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,PP.PROJECT_ID,PP.PROJECT_HEAD FROM (
SELECT AMOUNT,AMOUNT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,UNIT,UNIT2,LOT_NO,STOCK_ID,ROW_PROJECT_ID PROJECT_ID FROM #dsn2#.SHIP_ROW  
WHERE 1=1 AND ISNULL(SHELF_NUMBER,TO_SHELF_NUMBER)=#getS2.PRODUCT_PLACE_ID#   
UNION ALL
SELECT  -1* AMOUNT,-1* AMOUNT2,CONVERT(DECIMAL(18,2),AMOUNT/AMOUNT2) AS CV,UNIT,UNIT2,LOT_NO,STOCK_ID,S.PROJECT_ID PROJECT_ID FROM #dsn2#.STOCK_FIS_ROW 
LEFT JOIN #dsn2#.STOCK_FIS AS S ON STOCK_FIS_ROW.FIS_ID=S.FIS_ID
WHERE 1=1 AND ISNULL(SHELF_NUMBER,TO_SHELF_NUMBER)=#getS2.PRODUCT_PLACE_ID# 
) AS T  
LEFT JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=T.STOCK_ID
LEFT JOIN #dsn#.PRO_PROJECTS AS PP ON PP.PROJECT_ID=T.PROJECT_ID
GROUP BY CV,UNIT,UNIT2,LOT_NO,T.STOCK_ID,S.PRODUCT_CODE,S.PRODUCT_NAME,PP.PROJECT_ID,PP.PROJECT_HEAD
HAVING SUM(AMOUNT2) >0

    </cfquery>

<cf_grid_list>
    <thead>
        <tr>
            <th>Ürün</th>
            <th>Miktar</th>
            <th>Miktar2</th>
            <th>Lot No</th>
            <th>Antrepo</th>
            <th>#</th>
        </tr>
        <cfoutput query="gets">
            <tr>
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
                <td><button class="btn btn-primary" onclick="windowopen('index.cfm?fuseaction=#attributes.fuseaction#&SAYFA=3&PRODUCT_PLACE_ID=#getS2.PRODUCT_PLACE_ID#&SHELFCODE=#listgetAt(attributes.RAF,3,"-")#&lot=#LOT_NO#&DEF_A=#A2#&DEF=#A#&CV=#CV#&PROJECT_ID=#PROJECT_ID#&STOCK_ID=#STOCK_ID#','PAGE')" type="button"><span class="icn-md icon-check"></span></button></td>
            </tr>
        </cfoutput>
    </thead>
</cf_grid_list>
<cfelse>
    Raf Bulunamadı
</cfif>
</cf_box>
