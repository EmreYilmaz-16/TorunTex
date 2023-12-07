<cfquery name="getSepetler" datasource="#dsn3#">
    SELECT SEPET_ID
	,SEVK_NO
	,SSP.DEPARTMENT_ID
	,SSP.LOCATION_ID
	,SSP.ORDER_ID
	,SSP.RECORD_DATE
	,SSP.RECORD_EMP
	,SL.COMMENT
	,O.ORDER_NUMBER
	,C.NICKNAME
	,SC.COUNTRY_NAME
	,ISNULL(SSP.IS_CLOSED,0) IS_CLOSED
	,(SELECT COUNT(*) FROM w3Toruntex_1.ORDERS_INVOICE WHERE ORDER_ID=O.ORDER_ID) AS FATURA_DURUM
FROM w3Toruntex_1.SEVKIYAT_SEPET_PBS SSP
LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=SSP.DEPARTMENT_ID AND SL.LOCATION_ID=SSP.LOCATION_ID
LEFT JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=SSP.ORDER_ID
LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
LEFT JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID=C.COUNTRY
</cfquery>

<cf_grid_list>
	<thead>
		<tr>
			<th>
				Sevk No
			</th>
			<th>
				Sipariş No
			</th>
			<th>
				Müşteri
			</th>			
			<th>
				Ülkesi
			</th>
			<th>
				Depo
			</th>
			<th colspan="2">

			</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="getSepetler">
		<tr>
			<td>
				#SEVK_NO#
			</td>
			<td>
				#ORDER_NUMBER#
			</td>
			<td>
				#NICKNAME#
			</td>
			<td>
				#COUNTRY_NAME#
			</td>
			<td>
				#COMMENT#
			</td>
			<td>
				<button type="button" class="btn btn-outline-dark">Çeki Listesi</button>
			</td>
			<td>
				<button class="btn btn-sm <cfif FATURA_DURUM eq 1>btn-success<cfelse>btn-danger</cfif>">
					<cfif FATURA_DURUM eq 1>Fatura Kesildi<cfelse>Fatura Kes </cfif>
				</button>
			</td>
		</tr>
	</cfoutput>
	</tbody>
</cf_grid_list>

