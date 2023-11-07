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
    <table style="width: 100%;font-family:sans-serif;border: solid 1px black;border-spacing: 0px;border-collapse: collapse;" cellspacing="0" cellpadding="0">
        <tbody>
            <tr>
                <td rowspan="6" style="width:1cm;vertical-align:bottom;border-right: solid 1px black;">
                    <img style="height:99%" src="/AddOns/Partner/imgs/GLVBAS.jpg">
                </td>
                <td style="width: 3cm;text-align: center;border-right: solid 1px black;">
                    <div style="font-size: 30pt;">KLB</div>
                    <div>SA-05</div>
                </td>
                <td style="text-align:center">                    
                    <cf_pbs_barcode format="code128" type="qrcode" shape="SQUARE" value="#GETD.PRODUCT_DETAIL#|#GETD.LOT_NO#||#GETD.AMOUNT#" show="1" height="120" width="120">
                </td>
                <td rowspan="6" style="width:1cm;vertical-align:top;border-left: solid 1px black;"><img style="height:99%" src="/AddOns/Partner/imgs/GLVUAS.jpg"></td>
            </tr>
            <tr>            
                <td colspan="2" style="font-size: 30pt;text-align: center;background: black;color: white;border: solid 1px black;">GLV</td>
            </tr>
            <tr>            
                <td colspan="2" style="border: solid 1px;"><span style="font-size:16pt">30</span>1210460</td>
            </tr>
            <tr>            
                <td colspan="2" style="border: solid 1px black;">Gloves</td>
            </tr>
            <tr>            
                <td colspan="2" style="font-size: 30pt;text-align: center;border: solid 1px black;">45 Kg</td>
            </tr>
            <tr>                
                <td colspan="2" style="border: solid 1px black;">1109452T</td>
            </tr>
        </tbody>
    </table>


</cfdocument>

<cfscript>
    thesheet=spreadsheetNew("TheSheet");
    row=1;
    col=1;
    spreadsheetSetCellValue(thesheet,"Produced In Germany",row,col);
    col=col+1;
    spreadsheetSetCellValue(thesheet,"KLB",row,col);
    col=col+1;
    

</cfscript>