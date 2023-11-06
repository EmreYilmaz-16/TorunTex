<cfparam name="attributes.FIS_ID" default="195">

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
<cfdocument format="PDF" pageheight="10" pagewidth="10" unit="cm" filename="#fileName#">
    <cfoutput>  
        <table>
            <tr>
                <td>
                    #GETD.COMMENT#     
                    <br>
                    Sipariş no<br>
                    #GETD.ORDER_NUMBER#
                </td>
                <td>
                    <script src="/AddOns/Partner/js/qrcode.js"></script>
                    <div id="qrcode" style="text-align:-webkit-center"></div>
                    <div id="qrvalue" style="visibility: hidden;display:none">EMRE|EMREEEE||EMREEEEEE</div>
                    <script type="text/javascript">
                        var qrcode = new
                        QRCode(document.getElementById("qrcode"), {
                        width:175,
                        height : 175
                        });
                
                        function makeCode (msg) {
                        var elText = document.getElementById("text");
                        qrcode.makeCode(msg);
                        }
                        makeCode(document.getElementById("qrvalue").innerHTML);
                    </script>
                
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    #GETD.PRODUCT_NAME#
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    #GETD.PRODUCT_CODE_2#
                    <br>
                    #GETD.PRODUCT_DETAIL#
                </td>
            </tr>
            <tr>
                <td>
                    #GETD.AMOUNT# KG
                </td>
            </tr>
        </table>
    </cfoutput>
</cfdocument>