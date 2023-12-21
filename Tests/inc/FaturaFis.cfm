<cfquery name="getBeyans" datasource="#dsn2#">   
SELECT * FROM (
	SELECT SF.FIS_ID
		,SF.FIS_DATE AS SEVK_TARIHI
		,SFR.STOCK_ID AS STOCK_ID
		,SFR.AMOUNT AS MIKTAR
		,SFR.UNIT AS BIRIM
		,SFR.AMOUNT2 AS MIKTAR2
		,SFR.UNIT2 AS BIRIM2
		,SFR.LOT_NO AS KONTEYNER_NO
		,PP.PROJECT_HEAD AS BEYANNAME_NO
		,DATEDIFF(DAY, SF.FIS_DATE, GETDATE()) AS GECEN_SURE	
		,ISNULL(SUM(SFF.AMOUNT),0) AS KULLANILAN
		,SFR.AMOUNT-ISNULL(SUM(SFF.AMOUNT),0) AS KALAN
	FROM w3Toruntex_2023_1.STOCK_FIS AS SF
	INNER JOIN w3Toruntex_2023_1.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	INNER JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID = SF.PROJECT_ID
	LEFT  JOIN w3Toruntex_2023_1.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID=SF.FIS_ID AND SFF.STOCK_ID=SFR.STOCK_ID
	WHERE DEPARTMENT_OUT = 13
	GROUP BY
	SF.FIS_ID
		,SF.FIS_DATE 
		,SFR.STOCK_ID
		,SFR.AMOUNT 
		,SFR.UNIT 
		,SFR.AMOUNT2
		,SFR.UNIT2 
		,SFR.LOT_NO
		,PP.PROJECT_HEAD
) AS T WHERE T.KALAN>0
</cfquery>
<table>
    <tr>
        <td>
            <div class="form-group">
                <label>Beyanname</label>
                <select name="BEYAN" id="BEYAN">
                    <cfoutput query="">
                        <option value="#FIS_ID#-#STOCK_ID#">#BEYANNAME_NO#  - #KONTEYNER_NO# - #GECEN_SURE# - #KALAN#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
    </tr>
</table>
