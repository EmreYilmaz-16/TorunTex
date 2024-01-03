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
<cfquery name="getINV" datasource="#dsn2#">
    SELECT * FROM INVOICE WHERE INVOICE_ID =#attributes.INVOICE_ID#
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
    
</cfoutput>
<cfset SonBSatir=1>
<cfset Satirim=1>
<cfset SonBiSatir=SayfaSiniri>
<cfset ToplamPara=0>
<cfset ToplamVergi=0>
<table style="width:100%">
    <tr>
        <td>
            <div style="display: flex;align-content: stretch;align-items: center;">
                    <img src="http://w3.toruntex.com/documents/settings/B7098D36-ED47-53DE-551A82910B12F8A1.ico" border="0" alt="">
                    <h3 style="color: #2c6d3e;font-size: 33pt;">INTRO TARIM VE HAYVANCILIK A.S.</h3>
             </div>
        </td>
    </tr>
</table>
<cfloop from="1" to="#SayfaSayisi#" index="i">
<table style="width:100%">
    <tr style="border-bottom:solid;">
        <td style="width:90%;font-size: 25pt;">
            INVOICE
        </td>
        <td style="text-align:right;">
            Date :
        </td>
        <td style="text-align:right;">
            <cfoutput>
                #DateFormat(getINV.INVOICE_DATE,"dd.mmm.yyyy")#
            </cfoutput>
        </td>
    </tr>
</table>
<br>
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
        <cfset TotalSr=0>
        <cfset TotalSrTax=0>
        <cfloop from="#Satirim#" to="#SonBSatir#" index="j">        
            <cfif Satirim lte KayitSayisi>   <tr>
            <td>#Satirim#</td>
            <td style="text-align:center" >#tlformat(getData.AMOUNT2[j])#<br>#tlformat(getData.AMOUNT[j])#</td>
            <td style="text-align:center">Pc<br>#getData.UNIT[j]#</td>            
            <td>#getData.PRODUCT_NAME[j]#<br>#getData.PRODUCT_DETAIL[j]# Order Number:<Cfif listlen(getData.SIPARIS[j],"|")>#listGetAt(getData.SIPARIS[j],1,"|") #</Cfif></td>
            <td style="text-align:right">#tlformat(getData.PRICE_OTHER[j])#</td>
            <td style="text-align:center"><CFIF getData.TAX[j] EQ 0>Tax Free<CFELSE>#getData.TAX[j]# %</CFIF></td>
            <td style="text-align:right">#tlformat(getData.TOTAL_MONEY[j])# #getData.OTHER_MONEY[j]#</td>
            <cfset TotalSr=TotalSr+getData.TOTAL_MONEY[j]>
            <cfset TotalSrTax=TotalSrTax+getData.TAX[j]>
        </tr></cfif>
        <cfset Satirim=Satirim+1>
    </cfloop> 
</tbody>
    <cfset ToplamPara=ToplamPara+TotalSr>
    <cfif i lt SayfaSayisi> <tfoot >
        <tr>
            <th colspan="4"></th>
            <th colspan="2">
                Transfer
            </th>
            <th>
                #tlformat(TotalSr)#
            </th>
        </tr>
    </tfoot>
<cfelse>
    <tfoot>
        <tr>
            <th rowspan="3" colspan="4">
                Leistung ist in Deutschland nicht steuerbar.
            </th>
            <th colspan="2">
                Positions Total:
            </th>
            <th>
                #tlformat(ToplamPara)#
            </th>
        </tr>
        <tr>
            <th colspan="2">
                Tax:
            </th>
            <th>
                
            </th>
        </tr>
        <tr>
            <th colspan="2">
                Grand Total: 
            </th>
            <th>
                #tlformat(ToplamPara)#
            </th>
        </tr>
    </tfoot>
</cfif>
    </cfoutput>


</cf_big_list>
<cfif i lt SayfaSayisi><div style="page-break-after: always"></div></cfif>
</cfloop>