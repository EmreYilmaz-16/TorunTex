<cfparam name="attributes.invoice_id" default="2">

<cfquery name="getData" datasource="#dsn2#">
    SELECT ISNULL((
		SELECT O.ORDER_NUMBER + '|' + O.ORDER_HEAD
		FROM w3Toruntex_2024_1.INVOICE_SHIPS AS IIIS
		LEFT JOIN w3Toruntex_1.ORDERS_SHIP AS OS ON OS.SHIP_ID = IIIS.SHIP_ID
			AND OS.PERIOD_ID = IIIS.SHIP_PERIOD_ID
		INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID = OS.ORDER_ID
		WHERE IIIS.INVOICE_ID = IR.INVOICE_ID
		) ,'0|0')AS SIPARIS
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
<cfdump var="#getData#">

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
<cfset Satirim=1>
<cfset SonBiSatir=SayfaSiniri>
<cfloop from="1" to="#SayfaSayisi#" index="i">
<cf_big_list>
    <thead>
    <tr>
        <th style="text-align:center">
            Pos
        </th>
        <th style="text-align:center">
            Quantity<br>
            Ord-Qty
        </th>
        <th style="text-align:center">
            Unit<br> Ord-
        </th>
        <th style="text-align:center">
            Product
        </th>
        <th style="text-align:center">
            Price
        </th>
        <th style="text-align:center">
            Tax
        </th>
        <th style="text-align:center">
            Net Total
        </th>
    </tr>
</thead>
    <tbody>
        <cfset SonBSatir=SayfaSiniri*i>
    <cfoutput>
        <cfloop from="#Satirim#" to="#SonBSatir#" index="j">        
            <cfif Satirim lte KayitSayisi>   <tr>
            <td>#Satirim#</td>
            <td >#tlformat(getData.AMOUNT2[j])#<br>#tlformat(getData.AMOUNT[j])#</td>
            <td>Pc<br>#getData.UNIT[j]#</td>            
            <td>#getData.PRODUCT_NAME[j]#<br>#getData.PRODUCT_DETAIL[j]# Order Number:<Cfif listlen(getData.SIPARIS[j],"|")>#listGetAt(getData.SIPARIS[j],1,"|") #</Cfif></td>
            <td style="text-align:right">#tlformat(getData.PRICE_OTHER[j])#</td>
            <td style="text-align:center"><CFIF getData.TAX[j] EQ 0>Tax Free<CFELSE>#getData.TAX[j]# %</CFIF></td>
            <td style="text-align:right">#tlformat(getData.TOTAL_MONEY[j])# #getData.OTHER_MONEY[j]#</td>
        </tr></cfif>
        <cfset Satirim=Satirim+1>
    </cfloop> 
    </cfoutput>
</tbody>
</cf_big_list>
</cfloop>