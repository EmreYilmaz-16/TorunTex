<cfparam name="attributes.invoice_id" default="2">

<cfquery name="getData" datasource="#dsn2#">
    SELECT (
		SELECT O.ORDER_NUMBER + '|' + O.ORDER_HEAD
		FROM w3Toruntex_2024_1.INVOICE_SHIPS AS IIIS
		LEFT JOIN w3Toruntex_1.ORDERS_SHIP AS OS ON OS.SHIP_ID = IIIS.SHIP_ID
			AND OS.PERIOD_ID = IIIS.SHIP_PERIOD_ID
		INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID = OS.ORDER_ID
		WHERE IIIS.INVOICE_ID = IR.INVOICE_ID
		) AS SIPARIS
	,S.PRODUCT_NAME
	,S.PRODUCT_CODE_2
	,S.PRODUCT_DETAIL
	,IR.PRICE_OTHER
    ,IR.TAX
	,IR.AMOUNT
	,IR.AMOUNT2
	,IR.UNIT, IR.UNIT2
,IR.PRICE_OTHER*IR.AMOUNT AS TOTAL_MONEY
,IR.OTHER_MONEY
FROM w3Toruntex_2024_1.INVOICE_ROW AS IR
INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID = IR.STOCK_ID

WHERE INVOICE_ID = #attributes.INVOICE_ID#


</cfquery>


<cfset SayfaSiniri=25>
<cfset KayitSayisi=getData.recordCount>
<cfset SayfaSayisi=0>
<cfoutput>
    <cfif KayitSayisi mod SayfaSiniri>
       <cfset SayfaSayisi=Int(KayitSayisi/SayfaSiniri)+1>
        <cfelse>
    <cfset SayfaSayisi=Int(KayitSayisi/SayfaSiniri)>
    </cfif>
    #SayfaSayisi#
</cfoutput>
<cfset SonBSatir=1>
<cfset SonBiSatir=SayfaSiniri>
<cfloop from="1" to="#SayfaSayisi#" index="i">
<cf_grid_list>
    <thead>
    <tr>
        <th>
            Pos
        </th>
        <th>
            Quantity<br>
            Ord-Qty
        </th>
        <th>
            Unit<br> Ord-
        </th>
        <th>
            Product
        </th>
        <th>
            Price
        </th>
        <th>
            Tax
        </th>
        <th>
            Net Total
        </th>
    </tr>
</thead>
    <tbody>
    <cfoutput query="getData" startrow="#SonBSatir#" maxrows="#SayfaSiniri#">
        <tr>
            <td>#currentrow#</td>
            <td>#AMOUNT2#<br>#AMOUNT#</td>
            <td>Pc<br>#UNIT#</td>            
            <td>#PRODUCT_NAME#<br>#PRODUCT_DETAIL# Order Number:#listGetAt(SIPARIS,1,"|")#</td>
            <td>#PRICE_OTHER#</td>
            <td><CFIF TAX EQ 0>Tax Free<CFELSE>#TAX# %</CFIF></td>
            <td>#tlformat(TOTAL_MONEY)# #OTHER_MONEY#</td>
        </tr>
    </cfoutput>
</tbody>
</cf_grid_list>
</cfloop>