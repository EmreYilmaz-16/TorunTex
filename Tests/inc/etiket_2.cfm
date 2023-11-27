<cfparam name="attributes.FIS_ID" default="370">
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
<cfsavecontent variable=EtiketData>
   <cfoutput>^XA^XFE:etiket2.ZPL^FS^CI28^FN1^FH\^FD#GETD.COMMENT#^FS^CI27^CI28^FN2^FH\^FD#GETD.ORDER_NUMBER#^FS^CI27 ^CI28^FN3^FH\^FD#GETD.PRODUCT_CODE_2#^FS^CI27^CI28^FN4^FH\^FD#GETD.PRODUCT_DETAIL#^FS^CI27^CI28^FN5^FH\^FD#GETD.LOT_NO#^FS^CI27^CI28^FN6^FH\^FD#GETD.AMOUNT#^FS^CI27^CI28^FN7^FH\^FD#GETD.PRODUCT_DETAIL#|#GETD.LOT_NO#||#GETD.AMOUNT#^FS^CI27^CI28^FN8^FH\^FD#GETD.PRODUCT_NAME#^FS^CI27^PQ1,0,1^XZ</cfoutput> 
</cfsavecontent>

<cfhttp url="http://192.168.0.62/pstprnt" result="Resta">
    <cfhttpparam type="header" name="Content-Type" value="application/x-www-form-urlencoded">
    <cfhttpparam type="header" name="Content-Length" value="#len(EtiketData)#">
    <cfhttpparam type="formfield" name="data" value="#EtiketData#">
</cfhttp>
<cfdump var="#Resta#">