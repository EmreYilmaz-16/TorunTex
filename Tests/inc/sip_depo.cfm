<cfquery name="gets" datasource="#dsn3#">
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
	INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID = SL.DEPARTMENT_ID
	WHERE SL.DEPARTMENT_ID = 14
	) AS TT
WHERE TT.BAKIYE = 0
	AND TT.SIP_DURUM = 0
</cfquery>
<cf_box title="Depolar" scroll="1" collapsable="1" resize="1" popup_box="1">
    <input type="text" name="e" onkeyup="searchSiparis(this,event)">
<table id="Tabloooom">
<cfoutput query="gets">
    <tr>
        <td><a onclick="send_value_1('#LOCATION_ID#█#DEPARTMENT_HEAD# - #COMMENT#█#DEPARTMENT_ID#█#BRANCH_ID#');">#DEPARTMENT_HEAD#-#COMMENTCOMMENT#</a></td>
    </tr>
</cfoutput>
</table>
</cf_box>
<script>
          function searchSiparis(el,ev){
  var value = $(el).val().toLowerCase();
  $("#Tabloooom tr").filter(function() {
    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
  });
}
</script>