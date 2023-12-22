
<cfparam name="attributes.ALL" default="0">
<cf_box title="Sevkiyat İşlemleri">
<cfquery name="getDoluDepolar" datasource="#DSN3#">
    SELECT *
FROM (
	SELECT SL.COMMENT
		,D.DEPARTMENT_HEAD
        ,D.BRANCH_ID
		,SL.DEPARTMENT_ID
		,SL.LOCATION_ID
		,(
			SELECT COUNT(*)
			FROM #dsn3#.ORDERS AS O
			WHERE O.DELIVER_DEPT_ID = SL.DEPARTMENT_ID
				AND O.LOCATION_ID = SL.LOCATION_ID
				AND ORDER_STAGE = 260
			) AS SIP_DURUM
		,ISNULL((
				SELECT SUM(ISNULL(STOCK_IN, 0) - ISNULL(STOCK_OUT, 0))
				FROM #dsn2#.STOCKS_ROW
				WHERE STORE = SL.DEPARTMENT_ID
					AND STORE_LOCATION = SL.LOCATION_ID
				), 0) AS BAKIYE
	FROM #dsn#.STOCKS_LOCATION AS SL
	INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = SL.DEPARTMENT_ID
	<cfif attributes.all neq 1>WHERE SL.DEPARTMENT_ID = 14</cfif>
	) AS TT WHERE 1=1
  --  WHERE TT.BAKIYE <> 0
	AND TT.SIP_DURUM <> 0
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=settings.emptypopup_partner_test_page&sayfa=29" id="frm_1">
<div class="form-group">
    <label>Depo</label>
    <div class="input-group" style="flex-wrap:nowrap">
    <select name="select1" class="form-control form-select" onchange="$('#frm_1').submit()">
        <cfoutput query="getDoluDepolar">
            <cfquery name="getOrder" datasource="#dsn3#">
               SELECT C.NICKNAME
	,SC.COUNTRY_NAME
	,SL.COMMENT
    ,D.DEPARTMENT_ID
    ,SL.LOCATION_ID
	,D.DEPARTMENT_HEAD
    ,'PLAKA' AS PLAKA
    ,'KONTEYNER NO ' AS KONTEYNER
    ,O.ORDER_ID
	,O.DELIVERDATE
    ,ISNULL(SSP.SEPET_ID,0) SEPET_ID
FROM #dsn3#.ORDERS AS O
INNER JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
INNER JOIN #dsn#.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = O.COUNTRY_ID
INNER JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID = O.DELIVER_DEPT_ID
	AND SL.LOCATION_ID = O.LOCATION_ID
INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = O.DELIVER_DEPT_ID
LEFT JOIN #dsn3#.SEVKIYAT_SEPET_PBS AS SSP ON SSP.ORDER_ID=O.ORDER_ID
WHERE O.DELIVER_DEPT_ID = #DEPARTMENT_ID#
	AND O.LOCATION_ID = #LOCATION_ID#
	AND ORDER_STAGE not IN(262,259)
            </cfquery>
			<cfloop query="getOrder">
            <option value="#getDoluDepolar.DEPARTMENT_ID#-#getDoluDepolar.LOCATION_ID#*#getOrder.ORDER_ID#*#getOrder.SEPET_ID#">#getDoluDepolar.DEPARTMENT_HEAD# - #getDoluDepolar.COMMENT# #getOrder.NICKNAME# #getOrder.COUNTRY_NAME# #getOrder.PLAKA# #getOrder.KONTEYNER# - #dateformat(getOrder.DELIVERDATE,"dd/mm/yyyy")#</option>
		</cfloop>
        </cfoutput>
    </select>
	
<button class="btn btn-success input-group-text" type="button" onclick="$('#frm_1').submit()">Aç</button>
</div>
</div>
</cfform>
</cf_box>