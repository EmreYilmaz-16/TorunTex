<cfparam name="attributes.FIS_ID" default="195">
<cfset dsn2="w3Toruntex_2023_1">
<cfquery name="GETD" datasource="#DSN2#">
    SELECT SFR.LOT_NO,SFR.AMOUNT,S.PRODUCT_NAME,S.PRODUCT_DETAIL,S.PRODUCT_CODE_2,SL.COMMENT,O.ORDER_NUMBER FROM w3Toruntex_2023_1.STOCK_FIS AS SF 
    INNER JOIN w3Toruntex_2023_1.STOCK_FIS_ROW AS SFR ON SF.FIS_ID=SFR.FIS_ID
    INNER JOIN w3Toruntex_1.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID=SFR.PBS_RELATION_ID
    INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
    INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=SFR.STOCK_ID
    INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=O.DELIVER_DEPT_ID AND SL.LOCATION_ID=O.LOCATION_ID
    WHERE SF.FIS_ID=#attributes.FIS_ID#
</cfquery>
<cfset GuiP=CreateUUID()>
<cfset fileName=replace(replace("C:/ETIKET/#GuiP#.pdf","\","/","all"),"//","/")>
<cfdocument format="PDF" marginBottom="0" marginLeft="0" marginRight ="0" marginTop="0"  pageType="custom" pageheight="10" pagewidth="10" unit="cm" filename="#fileName#">
    <table border="1" cellspacing="0" cellpadding="0" style="width: 10cm;">
        <tbody>
            <tr>
                <td rowspan="6"></td>
                <td style="width: 15px;text-align: center;">
                    <span style="font-size: 30pt;">KLB</span>
                    <span>SA-05</span>
                </td>
                <td></td>
                <td rowspan="6"></td>
            </tr>
            <tr>            
                <td colspan="2" style="font-size: 30pt;text-align: center;background: black;color: white;">GLV</td>
            </tr>
            <tr>            
                <td colspan="2"><span style="font-size:20pt">30</span>1210460</td>
            </tr>
            <tr>            
                <td colspan="2">Gloves</td>
            </tr>
            <tr>            
                <td colspan="2" style="font-size: 30pt;text-align: center;">45 Kg</td>
            </tr>
            <tr>                
                <td colspan="2">1109452T</td>
            </tr>
        </tbody>
    </table>
</cfdocument>