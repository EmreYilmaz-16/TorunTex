<cfparam name="attributes.ALL" default="0">
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
			FROM w3Toruntex_1.ORDERS AS O
			WHERE O.DELIVER_DEPT_ID = SL.DEPARTMENT_ID
				AND O.LOCATION_ID = SL.LOCATION_ID
				AND ORDER_STAGE <> 262
			) AS SIP_DURUM
		,ISNULL((
				SELECT SUM(ISNULL(STOCK_IN, 0) - ISNULL(STOCK_OUT, 0))
				FROM w3Toruntex_2023_1.STOCKS_ROW
				WHERE STORE = SL.DEPARTMENT_ID
					AND STORE_LOCATION = SL.LOCATION_ID
				), 0) AS BAKIYE
	FROM w3Toruntex.STOCKS_LOCATION AS SL
	INNER JOIN w3Toruntex.DEPARTMENT AS D ON D.DEPARTMENT_ID = SL.DEPARTMENT_ID
	<cfif attributes.all neq 1>WHERE SL.DEPARTMENT_ID = 14</cfif>
	) AS TT
    WHERE TT.BAKIYE <> 0
	AND TT.SIP_DURUM <> 0
</cfquery>

<div class="form-group">
    <label>Depo</label>
    <select name="form-control form-select">
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
FROM w3Toruntex_1.ORDERS AS O
INNER JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
INNER JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID = O.COUNTRY_ID
INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID = O.DELIVER_DEPT_ID
	AND SL.LOCATION_ID = O.LOCATION_ID
INNER JOIN w3Toruntex.DEPARTMENT AS D ON D.DEPARTMENT_ID = O.DELIVER_DEPT_ID
WHERE O.DELIVER_DEPT_ID = #DEPARTMENT_ID#
	AND O.LOCATION_ID = #LOCATION_ID#
	AND ORDER_STAGE <> 262
            </cfquery>
            <option value="#DEPARTMENT_ID#-#LOCATION_ID#">#DEPARTMENT_HEAD# - #COMMENT# #getOrder.NICKNAME# #getOrder.COUNTRY_NAME# #getOrder.PLAKA# #getOrder.KONTEYNER#</option>
        </cfoutput>
    </select>
</div>
