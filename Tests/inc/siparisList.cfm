
<cfquery name="getOrder" datasource="#dsn3#">
SELECT * FROM (SELECT C.NICKNAME
	,O.DELIVER_DEPT_ID
	,O.ORDER_NUMBER
	,O.LOCATION_ID
	,O.PRIORITY_ID
	,SP.PRIORITY
	,O.ORDER_ID
	,ORR.QUANTITY
	,ORR.WRK_ROW_ID
    ,ORR.AMOUNT2 DIGER_MIKTAR
	,ORR.ORDER_ROW_ID
	,SBI_1.BASKET_INFO_TYPE AS A1
	,SBI_2.BASKET_INFO_TYPE AS A2
	,(
		100 * ISNULL((
				SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
				FROM #dsn2#.STOCKS_ROW
				WHERE PBS_RELATION_ID = ORR.WRK_ROW_ID
					AND STORE = O.DELIVER_DEPT_ID
					AND STORE_LOCATION = O.LOCATION_ID
				), 0) / QUANTITY
		) AS TAMAMLANMA
	,ISNULL((
			SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
			FROM #dsn2#.STOCKS_ROW
			WHERE PBS_RELATION_ID = ORR.WRK_ROW_ID
				AND STORE = O.DELIVER_DEPT_ID
				AND STORE_LOCATION = O.LOCATION_ID
			), 0) AS R_AMOUNT
	,ISNULL((
			SELECT SUM(AMOUNT2)
			FROM (
				SELECT SR.STOCK_IN
					,SR.STOCK_OUT
					,SR.PROCESS_TYPE
					,SFR.AMOUNT
					,CASE 
						WHEN SR.STOCK_OUT > 0
							THEN - 1
						ELSE 1
						END AS AMOUNT2
					,SR.UPD_ID
				FROM #dsn2#.STOCKS_ROW AS SR
				LEFT JOIN #dsn2#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SR.UPD_ID
				WHERE SR.PBS_RELATION_ID = ORR.WRK_ROW_ID
					AND SR.STORE = O.DELIVER_DEPT_ID
					AND SR.STORE_LOCATION = O.LOCATION_ID
				) AS TS
			), 0) AS URETILEN_MIKTAR2
	,SC.COUNTRY_NAME
	,ORR.UNIT2
	,ORR.ORDER_ROW_CURRENCY
	,O.ORDER_STAGE
	,SL.COMMENT
FROM #dsn3#.ORDER_ROW AS ORR
INNER JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID = ORR.ORDER_ID
LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
LEFT JOIN #dsn#.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = O.PRIORITY_ID
LEFT JOIN #dsn3#.SETUP_BASKET_INFO_TYPES AS SBI_1 ON ORR.SELECT_INFO_EXTRA = SBI_1.BASKET_INFO_TYPE_ID
LEFT JOIN #dsn3#.SETUP_BASKET_INFO_TYPES AS SBI_2 ON ORR.BASKET_EXTRA_INFO_ID = SBI_2.BASKET_INFO_TYPE_ID
LEFT JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = O.COUNTRY_ID
LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = O.LOCATION_ID
	AND SL.DEPARTMENT_ID = O.DELIVER_DEPT_ID
WHERE ORR.PRODUCT_ID = #attributes.PRODUCT_ID#
	AND O.PURCHASE_SALES = 1
	AND UNIT2 = '#attributes.STATION#'
	AND ORDER_ROW_CURRENCY = - 5) AS POLKI
WHERE 1=1 
    <cfif attributes.STATION eq 'KLB'>
        AND DIGER_MIKTAR >URETILEN_MIKTAR2
    </cfif>
    <cfif attributes.STATION eq 'SCK'>
        AND QUANTITY >R_AMOUNT
    </cfif>
ORDER BY PRIORITY  
</cfquery>
<cfdump var="#getOrder#">
<cfset ORDER_ROW_ID_LIST=valueList(getOrder.ORDER_ROW_ID)>
<cfif getOrder.recordCount eq 0>
    <cfquery name="GETS2" datasource="#DSN#">
        SELECT DEPARTMENT_ID,LOCATION_ID FROM STOCKS_LOCATION WHERE COMMENT='#attributes.STATION#'
    </cfquery>
    <script>
        getDepoUretim(<cfoutput>'#attributes.STATION#',#GETS2.DEPARTMENT_ID#,#GETS2.LOCATION_ID#</cfoutput>,'SİPARİŞ SELECTEN OTOMATİK ÇALIŞTI')
        
    </script>
</cfif>
<div class="form-group">
    <label>Sipariş</label>    
    <div class="input-group mb-3">
        <input class="form-control" type="text" style="font-size:20pt !important" name="SearchSiparisTxt" id="SearchSiparisTxt" value="<cfoutput>#getOrder.NICKNAME# - #getOrder.ORDER_NUMBER#</cfoutput>">
        <button class="btn btn-outline-secondary input-group-text" onclick="$('#SiparisResultAreaAs').toggle(500)"><i class="icon-down"></i></button>
        <input type="hidden" name="ActiveSiparisId" id="ActiveSiparisId" value="<cfoutput><cfif isdefined("attributes.ActiveSiparisId")><cfif listFind(ORDER_ROW_ID_LIST,attributes.ActiveSiparisId)>#attributes.ActiveSiparisId#<cfelse>#getOrder.ORDER_ROW_ID#</cfif><cfelse>#getOrder.ORDER_ROW_ID#</cfif></cfoutput>">
        <div id="SiparisResultAreaAs" style="display:none;position: absolute;z-index: 999;width: 100%;background: white;">
            <div style="display: flex;border-bottom: solid 1px var(--gray);margin-bottom: 2px;position: sticky;background: white;width: 100%;">
                <div style="color: var(--danger);font-size: 14pt;width: 95%;">
                    Siparişler
                </div>
                <div style="color: var(--danger);font-size: 14pt;align-self: center">
                    <span onclick="$('#SiparisResultAreaAs').toggle(500)" class="icn-md fa fa-times-circle-o"></span>
                </div>
            </div>
            <div id="SiparisResultArea" >
                <cf_big_list >
                    <thead>
                        <tr>
                            <th colspan="8">
                                <input type="text" onclick="setSelAll(this)" onkeyup="searchSiparis(this,event)">
                            </th>
                        </tr>
                        <tr>
                            <th>Öncelik</th>
                            <th>İstasyon</th>
                            <th>Lokasyon</th>
                            <th>Sipariş No</th>
                            <th>Müşteri</th>
                            <th>Paket Kg</th>
                            <th>Ülkesi</th>
                            <th>Eksik Kg</th>
                            <th>Eksik Ad</th>
                        </tr>
                    <tbody id="Tabloooom">
                    <cfoutput query="getOrder">
                        <tr>
                            <td>#PRIORITY#</td>
                            <td>#UNIT2#</td>
                            <td>#COMMENT#</td>
                            <td><a href="javascript:;" class="btn btn-primary text-white" onclick="getAOrder(#ORDER_ROW_ID#,'ELİMLEN ')">#ORDER_NUMBER#</a></td>
                            <td><cfif len(NICKNAME) gt 20>#left(NICKNAME,20)#<cfelse>#NICKNAME#</cfif> </td>
                            <td>#A2#</td>
                            <td>#COUNTRY_NAME#</td>
                            <td>#QUANTITY-R_AMOUNT# </td>
                            <td>#DIGER_MIKTAR-URETILEN_MIKTAR2#</td>
                            
                        </tr>
                       
                    </cfoutput>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><cfquery name="GETS2" datasource="#DSN#">
                            SELECT DEPARTMENT_ID,LOCATION_ID FROM STOCKS_LOCATION WHERE COMMENT='#attributes.STATION#'
                        </cfquery>
                            <a href="javascript:;" class="btn btn-primary text-white" onclick="getDepoUretim(<cfoutput>'#attributes.STATION#',#GETS2.DEPARTMENT_ID#,#GETS2.LOCATION_ID#</cfoutput>,'SİPARİŞ SELECTEN TIKLADIM ÇALIŞTI')"><cfoutput>#attributes.STATION#</cfoutput></a></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                    </thead>                
                </cf_big_list>
            </div>
        </div>
    </div>
</div>

<script>
      var AkSipId=$("#ActiveSiparisId").val()
      function searchSiparis(el,ev){
  var value = $(el).val().toLowerCase();
  $("#Tabloooom tr").filter(function() {
    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
  });
}
    getAOrder(AkSipId,"sipariş listesinden otomatik geldi");
</script>