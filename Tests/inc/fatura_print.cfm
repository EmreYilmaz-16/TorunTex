<cfparam name="attributes.iid" default="">
<cfparam name="attributes.invoice_id" default="2">
<cfif len(attributes.iid)>
    <cfset attributes.invoice_id=attributes.iid>
</cfif>

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
    ,(SELECT SUM(AMOUNT) FROM INVOICE_ROW WHERE INVOICE_ID=#attributes.INVOICE_ID#) AS Gewicht
    ,(SELECT SUM(AMOUNT2) FROM INVOICE_ROW WHERE INVOICE_ID=#attributes.INVOICE_ID#) AS Ballen
	,S.PRODUCT_CODE_2
	,S.PRODUCT_DETAIL
	,IR.PRICE_OTHER
    ,IR.TAX
	,IR.AMOUNT
	,IR.AMOUNT2
	,IR.UNIT, IR.UNIT2
,IR.PRICE_OTHER*IR.AMOUNT AS TOTAL_MONEY
,IR.OTHER_MONEY
,I.INVOICE_NUMBER
,ISNULL(I.SHIP_ADDRESS,C.COMPANY_ADDRESS) AS SHIP_ADDRESS
,C.COMPANY_ADDRESS
,C.NICKNAME
,C.MEMBER_CODE
,C.OZEL_KOD
,C.OZEL_KOD_1
,C.OZEL_KOD_2
,C.COMPANY_ID
FROM w3Toruntex_2024_1.INVOICE_ROW AS IR
INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID = IR.STOCK_ID
INNER JOIN INVOICE AS I ON I.INVOICE_ID=IR.INVOICE_ID
INNER JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID=I.COMPANY_ID

WHERE IR.INVOICE_ID = #attributes.INVOICE_ID#


</cfquery>

<cfquery name="getINV" datasource="#dsn2#">
    SELECT * FROM INVOICE WHERE INVOICE_ID =#attributes.INVOICE_ID#
</cfquery>
<cfquery name="CHECK" datasource="#DSN#">
	SELECT
	    COMPANY_NAME,
		TEL_CODE,
		TEL,
		TEL2,
		TEL3,
		TEL4,
		FAX,
		ADDRESS,
		WEB,
		EMAIL,
		'' ASSET_FILE_NAME3,
		'' ASSET_FILE_NAME3_SERVER_ID,
		TAX_OFFICE,
		TAX_NO
	FROM
	   OUR_COMPANY
	WHERE
	<cfif isDefined("SESSION.EP.COMPANY_ID")>
	    COMP_ID = #SESSION.EP.COMPANY_ID#
	<cfelseif isDefined("SESSION.PP.COMPANY")>	
	    COMP_ID = #session.pp.company_id#
	</cfif> 
</cfquery>
<cfquery name="CHECK2" datasource="#DSN#">
SELECT TOP 10 NICKNAME COMPANY_NAME,COMPANY_TELCODE TEL_CODE,COMPANY_TEL1 TEL,
        '' TEL2,
		'' TEL3,
		'' TEL4,
		'' FAX,
        '#getData.SHIP_ADDRESS#' ADDRESS,
        FULLNAME,TAXNO TAX_NO,TAXOFFICE TAX_OFFICE FROM COMPANY WHERE COMPANY_ID=#getData.COMPANY_ID#
	
</cfquery>

<cfset SayfaSiniri=20>
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
        <td colspan="2">
            <div style="display: flex;align-content: stretch;align-items: center;">
                    <img style="width: 150px;" src="http://w3.toruntex.com/documents/settings/B7098D36-ED47-53DE-551A82910B12F8A1.ico" border="0" alt="">
                    <h3 style="color: #2c6d3e;font-size: 33pt;">INTRO TARIM VE HAYVANCILIK A.S.</h3>
             </div>
        </td>
    </tr>
    <tr>
        <td>
            <table style="width:100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                    <cfif len(CHECK.asset_file_name3)>
                    <td style="text-align:right;">
                        <cfoutput><cf_get_server_file output_file="settings/#CHECK.asset_file_name3#" output_server="#CHECK.asset_file_name3_server_id#" output_type="5"></cfoutput>
                    </td>
                    </cfif>
                    <td style="width:10mm;">&nbsp;</td>
                    <td valign="top">
                    <cfoutput query="CHECK">
                        <strong style="font-size:14px;">#company_name#</strong><br/>
                        #address#<br/>
                        <b><cf_get_lang_main no='87.Telefon'>: </b> (#tel_code#) - #tel#  #tel2#  #tel3# #tel4# <br/>
                        <b><cf_get_lang_main no='76.Fax'>: </b> #fax# <br/>
                        <b><cf_get_lang_main no='1350.Vergi Dairesi'> : </b> #TAX_OFFICE# <b><cf_get_lang_main no='340.No'> : </b> #TAX_NO#<br/>
                        <!---#web# - #email#---->
                    </cfoutput>
                    </td>
                </tr>
                <tr><td colspan="3"><hr></td></tr>
             </table><br/>
        </td>
        <td>
            <table style="width:100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                   
                    <td style="width:10mm;">&nbsp;</td>
                    <td valign="top">
                    <cfoutput query="CHECK2">
                        <strong style="font-size:14px;">#company_name#</strong><br/>
                        #getData.SHIP_ADDRESS#<br/>
                        <b><cf_get_lang_main no='87.Telefon'>: </b> (#tel_code#) - #tel#  #tel2#  #tel3# #tel4# <br/>
                        <b><cf_get_lang_main no='76.Fax'>: </b> #fax# <br/>
                        <b><cf_get_lang_main no='1350.Vergi Dairesi'> : </b> #TAX_OFFICE# <b><cf_get_lang_main no='340.No'> : </b> #TAX_NO#<br/>
                         <!---#web# - #email#---->
                    </cfoutput>
                    </td>
                </tr>
                <tr><td colspan="3"><hr></td></tr>
             </table><br/>
        </td>
    </tr>
</table>
<cfloop from="1" to="#SayfaSayisi#" index="i">
    <cfif i neq 1><table style="width:100%" >
        <tr>
            <td colspan="2">
                <div style="display: flex;align-content: stretch;align-items: center;">
                        <img style="width: 150px;" src="http://w3.toruntex.com/documents/settings/B7098D36-ED47-53DE-551A82910B12F8A1.ico" border="0" alt="">
                        <h3 style="color: #2c6d3e;font-size: 33pt;">INTRO TARIM VE HAYVANCILIK A.S.</h3>
                 </div>
            </td>
        </tr>
    </table></cfif>
<table style="width:100%">
    <tr style="border-bottom:solid;">
        <td style="width:85%;font-size: 25pt;">
            INVOICE
            <br>
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
<cfoutput>
 
<table style="width:100%">
    <tr>
        <td>
            Invoice No.
        </td>
        <td>
        #getData.INVOICE_NUMBER#
        </td>
        <td>
            Gewicht
        </td>
        <td>
        #tlformat(getData.Gewicht)# KG
        </td>
        <td>
            Phone
        </td>
        <td>
        
        </td>
    </tr>
    <tr>
        <td>
            Invoice No.
        </td>
        <td>
        #getData.OZEL_KOD_1#
        </td>
        <td>
            Ballen
        </td>
        <td>
        #tlformat(getData.Ballen)#
        </td>
        <td>
            Email
        </td>
        <td>
        
        </td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td>
            Container- Siegel No.
        </td>
        <td>
        
        </td>
        <td>
            VAT ID
        </td>
        <td>
        
        </td>
    </tr>
</table>
</cfoutput>
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
            <td style="text-align:right">#tlformat(getData.PRICE_OTHER[j])# #getData.OTHER_MONEY[j]#</td>
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