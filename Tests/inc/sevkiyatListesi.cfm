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
	,(SELECT COUNT(*) FROM #dsn3#.ORDERS_SHIP WHERE ORDER_ID=O.ORDER_ID) AS FATURA_DURUM
	,(SELECT SH.SHIP_ID,SH.SHIP_NUMBER FROM #dsn3#.ORDERS_SHIP AS OS INNER JOIN #dsn2#.SHIP AS SH ON SH.SHIP_ID=OS.SHIP_ID  WHERE OS.ORDER_ID=O.ORDER_ID FOR JSON PATH) AS IRSALIYELER
FROM #dsn3#.SEVKIYAT_SEPET_PBS SSP
LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=SSP.DEPARTMENT_ID AND SL.LOCATION_ID=SSP.LOCATION_ID
LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID=SSP.ORDER_ID
LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
LEFT JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID=C.COUNTRY
ORDER BY SEPET_ID DESC
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
			<th>İrsaliyler</th>
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
			<td><cftry>
				<CFSET IRS=deserializeJSON(IRSALIYELER)>
				<cfloop array="#IRS#" item="itt">
					<div><a onclick="windowopen('index.cfm?fuseaction=stock.form_add_sale&event=upd&ship_id=#it.SHIP_ID#')"#itt.SHIP_NUMBER#</div>
				</cfloop>
				<cfcatch></cfcatch>
			</cftry>
			</td>
			<td>
				<button type="button" class="btn btn-outline-dark" onclick="window.open('index.cfm?fuseaction=objects.popup_print_files&action=stock.form_add_fis&action_id=#SEPET_ID#&print_type=31','WOC')">Çeki Listesi</button>
			</td>
			
			<td>
				<button <cfif FATURA_DURUM neq 1><!---onclick="windowopen('/index.cfm?fuseaction=#attributes.fuseaction#&sayfa=27&SEPET_ID=#SEPET_ID#')"--->onclick="irsaliyeKes(#SEPET_ID#)"</cfif> class="btn btn-sm <cfif FATURA_DURUM eq 1>btn-success<cfelse>btn-danger</cfif>">
					<cfif FATURA_DURUM eq 1>İrsaliye Kesildi<cfelse>İrsaliye Kes </cfif>
				</button>
			</td>
		</tr>
	</cfoutput>
	</tbody>
</cf_grid_list>

<script>
	function irsaliyeKes(SEPET_ID) {
		$.ajax({
			url:"/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=27&SEPET_ID="+SEPET_ID,
			success:function (params) {
				alert("İrsaliye Kesildi");
				window.location.reload();
			}
		})
	}
</script>