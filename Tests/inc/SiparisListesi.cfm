<cfparam name="attributes.product_name" default="">
<cfparam name="attributes.product_id" default="">
<cfparam name="attributes.short_code_id" default="">
<cfparam name="attributes.short_code_name" default="">
<cfparam name="attributes.prod_cat" default="">
<cfparam name="attributes.start_date" default="">
<cfparam name="attributes.finish_date" default="">
<cfparam name="attributes.sales_member_name" default="">
<cfparam name="attributes.sales_member_id" default="">
<cfparam name="attributes.sales_member_type" default="">
<cfparam name="attributes.order_stage" default="">
<cfparam name="attributes.sale_add_option" default="">
<cfparam name="attributes.department_id" default="">
<cfparam name="attributes.location_id" default="">
<cfparam name="attributes.location_name" default="">
<cfparam name="attributes.listing_type" default="">
<cfparam name="attributes.quantity" default="">
<cfparam name="attributes.unit" default="">
<cfparam name="attributes.project_id" default="">
<cfparam name="attributes.project_head" default="">
<cfparam name="attributes.subscription_id" default="">
<cfparam name="attributes.subscription_no" default="">
<cfparam name="attributes.brand_id" default="">
<cfparam name="attributes.brand_name" default="">
<cfparam name="attributes.sort_type" default="4">
<cfparam name="attributes.keyword" default="">
<cfparam name="attributes.keyword_orderno" default="">
<cfparam name="attributes.filter_branch_id" default="">
<cfparam name="attributes.zone_id" default="">
<cfparam name="attributes.sales_county" default="">
<cfparam name="attributes.record_emp_id" default="">
<cfparam name="attributes.record_cons_id" default="">
<cfparam name="attributes.record_part_id" default="">
<cfparam name="attributes.record_name" default="">
<cfparam name="attributes.card_paymethod_id" default="">
<cfparam name="attributes.paymethod_id" default="">
<cfparam name="attributes.paymethod" default="">
<cfparam name="attributes.irsaliye_fatura" default="">
<cfparam name="attributes.use_efatura" default="">
<cfquery name="get_process_type" datasource="#DSN#">
	SELECT
		PTR.STAGE,
		PTR.PROCESS_ROW_ID,
		PT.PROCESS_NAME,
		PT.PROCESS_ID
	FROM
		PROCESS_TYPE_ROWS PTR,
		PROCESS_TYPE_OUR_COMPANY PTO,
		PROCESS_TYPE PT
	WHERE
		PT.IS_ACTIVE = 1 AND
		PT.PROCESS_ID = PTR.PROCESS_ID AND
		PT.PROCESS_ID = PTO.PROCESS_ID AND
		PTO.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.company_id#"> AND
		 PT.PROCESS_ID=32
	ORDER BY
		PT.PROCESS_NAME,
		PTR.LINE_NUMBER
</cfquery>
<cfinclude template="/V16/sale/query/get_priorities.cfm">
<cf_box>

<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=43">
    <cf_box_search>
        <cfoutput><table>
        <tr>
            <td>
                <input name="form_varmi" id="form_varmi" value="1" type="hidden">
                
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" name="keyword" id="keyword" placeholder="<cf_get_lang dictionary_id='57460.Filtre'>" value="#attributes.keyword#" maxlength="50">
                    </div>
                </div>
            </td>
            <td>
                <div class="form-group">
					<div class="input-group">
						<select name="currency_id" id="currency_id">
							<option value=""><cf_get_lang dictionary_id='57482.Asama'></option>
							<option value="-7" <cfif attributes.currency_id eq -7>selected</cfif>><cf_get_lang dictionary_id='29748.Eksik Teslimat'></option>
							<option value="-8" <cfif attributes.currency_id eq -8>selected</cfif>><cf_get_lang dictionary_id='29749.Fazla Teslimat'></option>
							<option value="-6" <cfif attributes.currency_id eq -6>selected</cfif>><cf_get_lang dictionary_id='58761.Sevk'></option>
							<option value="-5" <cfif attributes.currency_id eq -5>selected</cfif>><cf_get_lang dictionary_id='57456.retim'></option>
							<option value="-4" <cfif attributes.currency_id eq -4>selected</cfif>><cf_get_lang dictionary_id='29747.Kismi Uretim'></option>
							<option value="-3" <cfif attributes.currency_id eq -3>selected</cfif>><cf_get_lang dictionary_id='29746.Kapatildi'></option>
							<option value="-2" <cfif attributes.currency_id eq -2>selected</cfif>><cf_get_lang dictionary_id='29745.Tedarik'></option>
							<option value="-1" <cfif attributes.currency_id eq -1>selected</cfif>><cf_get_lang dictionary_id='58717.Aik'></option>
							<option value="-9" <cfif attributes.currency_id eq -9>selected</cfif>><cf_get_lang dictionary_id='58506.Iptal'></option>
							<option value="-10" <cfif attributes.currency_id eq -10>selected</cfif>><cf_get_lang dictionary_id='40876.Kapatildi(Manuel)'></option>
						</select>
					</div>
				</div>
            </td>
            <td>
                <div class="form-group">
					<div class="input-group">
						<select name="listing_type" id="listing_type">
							<option value=""><cf_get_lang dictionary_id='40170.Listeleme Seçenekleri'></option>
							<option value="1" <cfif attributes.listing_type eq 1>selected</cfif>><cf_get_lang dictionary_id='57660.Belge Bazinda'></option>
							<option value="2" <cfif attributes.listing_type eq 2>selected</cfif>><cf_get_lang dictionary_id='29539.Satir Bazinda'></option>
						</select>    
					</div>
				</div>
            </td>
            <td>
                <div class="form-group">
					<div class="input-group">
						<select name="status" id="status">
							<option value=""><cf_get_lang dictionary_id='57708.Tümü'></option>
							<option value="0"<cfif isdefined('attributes.status') and (attributes.status eq 0)> selected</cfif>><cf_get_lang dictionary_id='57494.Pasif'></option>
							<option value="1"<cfif isdefined('attributes.status') and (attributes.status eq 1)> selected</cfif>><cf_get_lang dictionary_id='57493.Aktif'></option>
						</select>
					</div>
				</div>
            </td>
            <td>
                <div class="form-group" id="item-company_id">
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57519.Cari Hesap'></label>							
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="input-group">
                            <input type="hidden" name="consumer_id" id="consumer_id" value="<cfif isdefined("attributes.consumer_id")><cfoutput>#attributes.consumer_id#</cfoutput></cfif>">
                            <input type="hidden" name="company_id" id="company_id" value="<cfif isdefined("attributes.company_id")><cfoutput>#attributes.company_id#</cfoutput></cfif>">
                            <input type="hidden" name="member_type" id="member_type" value="<cfif isdefined("attributes.member_type")><cfoutput>#attributes.member_type#</cfoutput></cfif>">
                            <input name="member_name" type="text" id="member_name" placeholder="<cfoutput>#getLang('main',107)#</cfoutput>" onfocus="AutoComplete_Create('member_name','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id,company_id,member_type','','3','250');" value="<cfif isdefined("attributes.member_name") and len(attributes.member_name)><cfoutput>#attributes.member_name#</cfoutput></cfif>" autocomplete="off">
                            <cfset str_linke_ait="&field_consumer=order_form.consumer_id&field_comp_id=order_form.company_id&field_member_name=order_form.member_name&field_type=order_form.member_type">
                            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_list_all_pars<cfoutput>#str_linke_ait#<cfif session.ep.isBranchAuthorization>&is_store_module=1</cfif></cfoutput>&select_list=7,8&keyword='+encodeURIComponent(document.order_form.member_name.value));"></span>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table></cfoutput>
</cf_box_search>
<cf_box_search_detail>
    <table>
        <tr>
            <td>
                <div class="form-group" id="item-order_stage">	
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='58859.Surec'></label>						
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <select name="order_stage" id="order_stage">
                            <option value=""><cf_get_lang dictionary_id='57734.Seçiniz'></option>
                            <cfoutput query="get_process_type" group="process_id">
                                <optgroup label="#process_name#"></optgroup>
                                <cfoutput>
                                <option value="#get_process_type.process_row_id#" <cfif Len(attributes.order_stage) and attributes.order_stage eq get_process_type.process_row_id>selected</cfif>>&nbsp;&nbsp;&nbsp;#get_process_type.stage#</option>
                                </cfoutput>
                            </cfoutput>
                        </select>         
                    </div>
            </td>
            <td>
                <div class="form-group" id="item-prod_cat">						
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='29401.Ürün Kategorileri'></label>
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <cfinclude template="../query/get_product_cats.cfm">
                        <select name="prod_cat" id="prod_cat">
                            <option value=""><cf_get_lang dictionary_id='57734.Seçiniz'></option>
                            <cfoutput query="GET_PRODUCT_CATS">
                                <cfif listlen(hierarchy,".") lte 3>
                                    <option value="#hierarchy#"<cfif (attributes.prod_cat eq hierarchy) and len(attributes.prod_cat) eq len(hierarchy)> selected</cfif>>#hierarchy#-#product_cat#</option>
                                </cfif>
                            </cfoutput>
                        </select>                       
                    </div>
                </div>
            </td>
            <td>
                <div class="form-group" id="item-product_id">
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57657.Ürün'></label>						
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="input-group">
                            <input type="hidden" name="product_id" id="product_id" <cfif len(attributes.product_id) and len(attributes.product_name)>value="<cfoutput>#attributes.product_id#</cfoutput>"</cfif>>
                            <input name="product_name" type="text" id="product_name" placeholder="<cfoutput><cf_get_lang dictionary_id='57657.Ürün'></cfoutput>" onfocus="AutoComplete_Create('product_name','PRODUCT_NAME','PRODUCT_NAME','get_product','0','PRODUCT_ID','product_id','','3','100');" value="<cfif len(attributes.product_id) and len(attributes.product_name)><cfoutput>#attributes.product_name#</cfoutput></cfif>" autocomplete="off">
                            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_product_names&product_id=order_form.product_id&field_name=order_form.product_name&keyword='+encodeURIComponent(document.order_form.product_name.value));"></span>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" id="item-sales_departments">
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='41184.Depo- Lokasyon'></label>			
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <cf_wrkdepartmentlocation 
                            returninputvalue="location_name,department_id,location_id"
                            returnqueryvalue="LOCATION_NAME,DEPARTMENT_ID,LOCATION_ID"
                            fieldname="location_name"
                            fieldid="location_id"
                            department_fldid="department_id"
                            department_id="#attributes.department_id#"
                            location_name="#attributes.location_name#"
                            location_id="#attributes.location_id#"
                            user_level_control="#session.ep.OUR_COMPANY_INFO.IS_LOCATION_FOLLOW#"
                            width="120">
                    </div>
                </div>
            </td>
            <td>
                <div class="form-group" id="item-priority">	
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57485.öncelik'></label>		
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <select name="priority" id="priority">
                            <option value=""><cf_get_lang dictionary_id='57734.seçiniz'></option>
                            <cfoutput query="get_priorities">
                                <option value="#priority_id#" <cfif isDefined("attributes.priority") and attributes.priority eq priority_id>selected</cfif>>#priority#</option>
                            </cfoutput>
                        </select>          
                    </div>
                </div>
            </td>
            <td>
                <div class="form-group" id="item-record_emp_id">
                    <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57899.Kaydeden'></label>	
                    <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="input-group">
                        <cfoutput>
                            <input type="hidden" name="record_emp_id" id="record_emp_id" value="#attributes.record_emp_id#">
                            <input type="hidden" name="record_cons_id" id="record_cons_id" value="#attributes.record_cons_id#">
                            <input type="hidden" name="record_part_id" id="record_part_id" value="#attributes.record_part_id#">
                            <input name="record_name" id="record_name" type="text" placeholder="<cfoutput><cf_get_lang dictionary_id='57899.Kaydeden'></cfoutput>" onfocus="AutoComplete_Create('record_name','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_PARTNER_NAME2,MEMBER_NAME2','get_member_autocomplete','\'1,2,3\',0,0,0','CONSUMER_ID,PARTNER_ID,EMPLOYEE_ID,MEMBER_NAME','record_cons_id,record_part_id,record_emp_id,record_name','','3','250');" value="#attributes.record_name#" autocomplete="off">
                            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('#request.self#?fuseaction=objects.popup_list_pars&field_emp_id=order_form.record_emp_id&field_name=order_form.record_name&field_consumer=order_form.record_cons_id&field_partner=order_form.record_part_id<cfif session.ep.isBranchAuthorization>&is_store_module=1</cfif>&select_list=1,2,3');"></span>
                        </cfoutput>
                        </div>
                    </div>
                </div>
            </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="col col-3 col-md-8 col-sm-12" type="column" sort="true" index="4">
                    <div class="form-group" id="item-project_id">	
                        <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57416.Proje'></label>					
                        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="input-group">
                                <input type="hidden" name="project_id" id="project_id" value="<cfif isdefined("attributes.project_id") and len (attributes.project_head)><cfoutput>#attributes.project_id#</cfoutput></cfif>">
                                <input type="text" name="project_head"  id="project_head" placeholder="<cfoutput><cf_get_lang dictionary_id='57416.Proje'></cfoutput>" value="<cfif Len(attributes.project_head)><cfoutput>#get_project_name(attributes.project_id)#</cfoutput></cfif>" onfocus="AutoComplete_Create('project_head','PROJECT_HEAD','PROJECT_HEAD','get_project','','PROJECT_ID','project_id','','3','200');" autocomplete="off">
                                <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_list_projects&project_id=order_form.project_id&project_head=order_form.project_head');"></span>
                            </div>
                        </div>
                    </div>
            </td>
        </tr>
    </table>
</cf_box_search_detail>
</cfform>
</cf_box>
    
    
    <cfabort>
<cfquery name="getData" datasource="#dsn#">
SELECT *
FROM (
        SELECT O.ORDER_NUMBER,
            O.ORDER_DATE,
            O.ORDER_ID,
            O.ORDER_HEAD,
            O.DELIVER_DEPT_ID,
            O.SHIP_DATE,
            O.LOCATION_ID,
            PP.PROJECT_HEAD,
            PP.PROJECT_NUMBER,
            SP.PRIORITY,
            C.NICKNAME,
            SC.COUNTRY_NAME,
            S.PRODUCT_CODE,
            S.PRODUCT_NAME,
            S.PRODUCT_CODE_2,
            ORR.QUANTITY,
            ORR.AMOUNT2,
            SL.COMMENT,
            PTR.STAGE,
            (
                100 * ISNULL(
                    (
                        SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
                        FROM w3Toruntex_2024_1.STOCKS_ROW
                        WHERE PBS_RELATION_ID = ORR.WRK_ROW_ID
                            AND STORE = O.DELIVER_DEPT_ID
                            AND STORE_LOCATION = O.LOCATION_ID
                    ),
                    0
                ) / QUANTITY
            ) AS TAMAMLANMA,
            ISNULL(
                (
                    SELECT sum(STOCK_IN - STOCK_OUT) STOCK_IN
                    FROM w3Toruntex_2024_1.STOCKS_ROW
                    WHERE PBS_RELATION_ID = ORR.WRK_ROW_ID
                        AND STORE = O.DELIVER_DEPT_ID
                        AND STORE_LOCATION = O.LOCATION_ID
                ),
                0
            ) AS URETILEN_MIKTAR,
            ISNULL(
                (
                    SELECT SUM(
                            CASE
                                WHEN STOCK_OUT IS NULL THEN - 1
                                ELSE 1
                            END
                        )
                    FROM w3Toruntex_2024_1.STOCKS_ROW
                    WHERE STORE = O.DELIVER_DEPT_ID
                        AND PBS_RELATION_ID = ORR.WRK_ROW_ID
                        AND STORE_LOCATION = O.LOCATION_ID
                    GROUP BY STOCK_ID,
                        PBS_RELATION_ID
                ),
                0
            ) AS URETILEN_MIKTAR2,
CASE
                WHEN ORR.ORDER_ROW_CURRENCY = - 1 THEN 'Açık'
                WHEN ORR.ORDER_ROW_CURRENCY = - 2 THEN 'Tedarik'
                WHEN ORR.ORDER_ROW_CURRENCY = - 3 THEN 'Kapatıldı'
                WHEN ORR.ORDER_ROW_CURRENCY = - 4 THEN 'Kısmi Üretim'
                WHEN ORR.ORDER_ROW_CURRENCY = - 5 THEN 'Üretim'
                WHEN ORR.ORDER_ROW_CURRENCY = - 6 THEN 'Sevk'
                WHEN ORR.ORDER_ROW_CURRENCY = - 7 THEN 'Eksik Teslimat'
                WHEN ORR.ORDER_ROW_CURRENCY = - 8 THEN 'Fazla Teslimat'
                WHEN ORR.ORDER_ROW_CURRENCY = - 9 THEN 'İptal'
                WHEN ORR.ORDER_ROW_CURRENCY = - 10 THEN 'Kapatıldı'
            END AS ASAMA
        FROM w3Toruntex_1.ORDERS AS O
            LEFT JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID = O.PROJECT_ID
            LEFT JOIN w3Toruntex.SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = O.PRIORITY_ID
            LEFT JOIN COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
            LEFT JOIN SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = O.COUNTRY_ID
            INNER JOIN w3Toruntex_1.ORDER_ROW AS ORR ON ORR.ORDER_ID = O.ORDER_ID
            INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID = ORR.STOCK_ID
            INNER JOIN w3Toruntex.PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID = O.ORDER_STAGE
            INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = O.LOCATION_ID
            AND SL.DEPARTMENT_ID = O.DELIVER_DEPT_ID
        WHERE O.PURCHASE_SALES = 1
    ) AS TT
WHERE 1 = 1
    AND ORDER_ID = 55
ORDER BY ORDER_ID
</cfquery>