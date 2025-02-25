<cfparam name="attributes.keyword" default="">
<cfparam name="attributes.svklock" default="">
<cfparam name="attributes.irsaliye" default="">
<cfparam name="attributes.locationid" default="">
<cfparam name="attributes.ffdurum" default="">
<cfparam name="attributes.comp_id" default="">
<title>Sevkiyat Listesi</title>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#">
<div style="display:flex">
	<div class="form-group">
		<label>Keyword</label>
		<input type="text" name="keyword" id="keyword" value="<cfoutput>#attributes.keyword#</cfoutput>">
	</div>
	<div class="form-group">
		<label>Müşteri</label>
		<select name="comp_id">
			<option value="">Müşteri</option>
			<cfquery name="getd" datasource="#dsn#">
				SELECT DISTINCT C.COMPANY_ID,NICKNAME FROM w3Toruntex_1.ORDERS LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID=ORDERS.COMPANY_ID WHERE ORDER_ID IN(
    SELECT ORDER_ID FROM w3Toruntex_1.SEVKIYAT_SEPET_PBS
) ORDER BY NICKNAME

			</cfquery>
			<cfoutput query="getd">
				<option <cfif attributes.comp_id eq COMPANY_ID>selected</cfif> value="#COMPANY_ID#">#NICKNAME#</option>
			</cfoutput>
		</select>
	</div>
	<div class="form-group">
		<label>Depo</label>
		<select name="locationid">
			<option value="">Depo</option>
			<cfquery name="getd" datasource="#dsn#">
				SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=14
			</cfquery>
			<cfoutput query="getd">
				<option <cfif attributes.locationid eq LOCATION_ID>selected</cfif> value="#LOCATION_ID#">#COMMENT#</option>
			</cfoutput>
		</select>
	</div>
	<div class="form-group">
		<label>Sevkiyat Kilidi</label>
		<select name="svklock">
			<option value="">Sevkiyat Kilidi</option>
			<option <cfif attributes.svklock eq 1>selected</cfif> value="1">Kilitli</option>
			<option <cfif attributes.svklock eq 0>selected</cfif> value="0">Açık</option>
		</select>
	</div>
	<div class="form-group">
		<label>İrsaliye</label>
		<select name="irsaliye">
			<option value="">İrsaliye Durumu</option>
			<option <cfif attributes.irsaliye eq 1>selected</cfif> value="1">İrsaliye Kesilmiş</option>
			<option <cfif attributes.irsaliye eq 0>selected</cfif> value="0">İrsaliye Kesilecek</option>
		</select>
	</div>
	<div class="form-group">
		<label>Fatura</label>
		<select name="ffdurum">
			<option value="">Fatura Durumu</option>
			<option <cfif attributes.ffdurum eq 1>selected</cfif> value="1">Fatura Kesilmiş</option>
			<option <cfif attributes.ffdurum eq 0>selected</cfif> value="0">Fatura Kesilecek</option>
		</select>
	</div>
	<div class="form-group">
		<input type="submit">
	</div>
</div>
</cfform>
<cfquery name="getSepetler" datasource="#dsn3#">
SELECT DISTINCT * FROM (
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
	,C.COMPANY_ID
	,ISNULL(SSP.IS_CLOSED,0) IS_CLOSED
	,(
SELECT COUNT(*) FROM #dsn2#.INVOICE_SHIPS WHERE SHIP_ID IN (
    SELECT SHIP_ID FROM w3Toruntex_1.ORDERS_SHIP WHERE ORDER_ID=O.ORDER_ID
)) FF_DURUM
	,(SELECT COUNT(*) FROM #dsn3#.ORDERS_SHIP WHERE ORDER_ID=O.ORDER_ID) AS FATURA_DURUM
	,(SELECT SH.SHIP_ID,SH.SHIP_NUMBER FROM #dsn3#.ORDERS_SHIP AS OS INNER JOIN #dsn2#.SHIP AS SH ON SH.SHIP_ID=OS.SHIP_ID  WHERE OS.ORDER_ID=O.ORDER_ID FOR JSON PATH) AS IRSALIYELER
FROM #dsn3#.SEVKIYAT_SEPET_PBS SSP
LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=SSP.DEPARTMENT_ID AND SL.LOCATION_ID=SSP.LOCATION_ID
LEFT JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID=SSP.ORDER_ID
LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
LEFT JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID=C.COUNTRY
) AS SEPETIM
 WHERE 1=1 
 <CFIF LEN(attributes.keyword)>
	AND  (SEVK_NO LIKE '%#attributes.keyword#%' OR ORDER_NUMBER LIKE '%#attributes.keyword#%')
 </CFIF>
 <CFIF LEN(attributes.irsaliye)>
	AND FATURA_DURUM =#attributes.irsaliye#
 </CFIF>
 <CFIF LEN(attributes.svklock)>
	AND IS_CLOSED =#attributes.svklock#
 </CFIF>
 <CFIF LEN(attributes.locationid)>
	AND LOCATION_ID =#attributes.locationid#
 </CFIF>
 <CFIF LEN(attributes.comp_id)>
	AND COMPANY_ID =#attributes.comp_id#
 </CFIF>
 <CFIF LEN(attributes.ffdurum)>
	AND FF_DURUM =#attributes.ffdurum#
 </CFIF>
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
			<th colspan="3">

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
					<div><a onclick="windowopen('index.cfm?fuseaction=stock.form_add_sale&event=upd&ship_id=#itt.SHIP_ID#')">#itt.SHIP_NUMBER#</a></div>
				</cfloop>
				<cfcatch></cfcatch>
			</cftry>
			</td>
			<td>
				<button type="button" class="btn btn-outline-dark" onclick="window.open('index.cfm?fuseaction=objects.popup_print_files&action=stock.form_add_fis&action_id=#SEPET_ID#&print_type=31','WOC')">Çeki Listesi</button>
			</td>
			
			
			<td>
				<button <cfif FATURA_DURUM neq 1><!---onclick="windowopen('/index.cfm?fuseaction=#attributes.fuseaction#&sayfa=27&SEPET_ID=#SEPET_ID#')"---><cfif IS_CLOSED eq 1> onclick="irsaliyeKes(#SEPET_ID#)" </cfif></cfif> class="btn btn-sm <cfif FATURA_DURUM eq 1>btn-success<cfelse>btn-danger</cfif>">
					<cfif FATURA_DURUM eq 1>İrsaliye Kesildi<cfelse>İrsaliye Kes </cfif>
				</button>
				
			</td>
			<td>
				<button class="btn btn-sm <cfif FF_DURUM eq 1>btn-success<cfelse>btn-danger</cfif>">
					<cfif FF_DURUM eq 1>Fatura Kesildi<cfelse>Fatura Kesilecek </cfif>
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