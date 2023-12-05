
<cfquery name="getOrder" datasource="#dsn3#">
SELECT C.NICKNAME
	,O.DELIVER_DEPT_ID
    ,O.ORDER_NUMBER
	,O.LOCATION_ID
	,O.PRIORITY_ID
	,SP.PRIORITY
	,O.ORDER_ID
    ,ORR.QUANTITY
	,ORR.WRK_ROW_ID
	,ORR.ORDER_ROW_ID
	,SBI_1.BASKET_INFO_TYPE AS A1
	,SBI_2.BASKET_INFO_TYPE AS A2
	,(
		100 * ISNULL((
				SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
				FROM w3Toruntex_2023_1.STOCKS_ROW
				WHERE PBS_RELATION_ID = ORR.WRK_ROW_ID
					AND STORE = O.DELIVER_DEPT_ID
					AND STORE_LOCATION = O.LOCATION_ID
				), 0) / QUANTITY
		) AS TAMAMLANMA
        
	,ISNULL((
			SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
			FROM w3Toruntex_2023_1.STOCKS_ROW
			WHERE PBS_RELATION_ID = ORR.WRK_ROW_ID
				AND STORE = O.DELIVER_DEPT_ID
				AND STORE_LOCATION = O.LOCATION_ID
			), 0) AS R_AMOUNT
	,SC.COUNTRY_NAME
	,ORR.UNIT2
	,ORR.ORDER_ROW_CURRENCY
	,O.ORDER_STAGE
	,SL.COMMENT
FROM w3Toruntex_1.ORDER_ROW AS ORR
INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID = ORR.ORDER_ID
LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
LEFT JOIN w3Toruntex.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = O.PRIORITY_ID
LEFT JOIN w3Toruntex_1.SETUP_BASKET_INFO_TYPES AS SBI_1 ON ORR.SELECT_INFO_EXTRA = SBI_1.BASKET_INFO_TYPE_ID
LEFT JOIN w3Toruntex_1.SETUP_BASKET_INFO_TYPES AS SBI_2 ON ORR.BASKET_EXTRA_INFO_ID = SBI_2.BASKET_INFO_TYPE_ID
LEFT JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = O.COUNTRY_ID
LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = O.LOCATION_ID
	AND SL.DEPARTMENT_ID = O.DELIVER_DEPT_ID
    
WHERE ORR.PRODUCT_ID=#attributes.PRODUCT_ID# AND O.PURCHASE_SALES=1 AND UNIT2='#attributes.STATION#' AND ORDER_ROW_CURRENCY=-5 ORDER BY SP.PRIORITY  
</cfquery>
<cfdump var="#getOrder#">
<div class="form-group">
    <label>Sipariş</label>    
    <div class="input-group mb-3">
        <input class="form-control" type="text" style="font-size:20pt !important" name="SearchSiparisTxt" id="SearchSiparisTxt" value="<cfoutput>#getOrder.NICKNAME# - #getOrder.ORDER_NUMBER#</cfoutput>">
        <button class="btn btn-outline-secondary input-group-text" onclick="$('#SiparisResultAreaAs').toggle(500)"><i class="icon-down"></i></button>
        <input type="hidden" name="ActiveSiparisId" id="ActiveSiparisId" value="<cfoutput>#getOrder.ORDER_ROW_ID#</cfoutput>">
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
                        </tr>
                    <tbody id="Tabloooom">
                    <cfoutput query="getOrder">
                        <tr>
                            <td>#PRIORITY#</td>
                            <td>#UNIT2#</td>
                            <td>#COMMENT#</td>
                            <td><a href="javascript:;" class="btn btn-primary text-white" onclick="getAOrder(#ORDER_ROW_ID#)">#ORDER_NUMBER#</a></td>
                            <td><cfif len(NICKNAME) gt 20>#left(NICKNAME,20)#<cfelse>#NICKNAME#</cfif> </td>
                            <td>#A2#</td>
                            <td>#COUNTRY_NAME#</td>
                            <td>#QUANTITY-R_AMOUNT#</td>
                            
                        </tr>
                       
                    </cfoutput>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><cfquery name="GETS2" datasource="#DSN#">
                            SELECT DEPARTMENT_ID,LOCATION_ID FROM STOCKS_LOCATION WHERE COMMENT='#attributes.STATION#'
                        </cfquery>
                            <a href="javascript:;" class="btn btn-primary text-white" onclick="getDepoUretim(<cfoutput>'#attributes.STATION#',#GETS2.DEPARTMENT_ID#,#GETS2.LOCATION_ID#</cfoutput>)"><cfoutput>#attributes.STATION#</cfoutput></a></td>
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
    getAOrder(AkSipId);
</script>