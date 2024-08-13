<cfquery name="getDoluDepolar" datasource="#dsn#">
    select STORE_LOCATION,STORE,COMMENT,COUNT(*) from (
SELECT T.*,SL.COMMENT FROM (
select SUM(STOCK_IN-STOCK_OUT) VB,LOT_NO,STORE,STORE_LOCATION from #dsn2#.STOCKS_ROW WHERE STORE=14 GROUP BY LOT_NO,STORE,STORE_LOCATION


) AS T 

LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=T.STORE AND SL.LOCATION_ID=T.STORE_LOCATION
WHERE VB>0



) as TT  GROUP BY STORE_LOCATION,STORE,COMMENT HAVING COUNT(*) >0


ORDER BY COMMENT
</cfquery>

<cfquery name="getTDepolar" datasource="#dsn#">
    select COMMENT,DEPARTMENT_ID as STORE,LOCATION_ID AS STORE_LOCATION from w3Toruntex.STOCKS_LOCATION where DEPARTMENT_ID IN (15)
</cfquery>

<table class="table">
    <tr>
        <td>            
            <div class="form-group">
                <select name="FromLocationId" id="FromLocationId">
                    <option value="">Seçiniz</option>
                    <cfoutput query="getDoluDepolar">
                        <option value="#STORE#-#STORE_LOCATION#">#COMMENT#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>            
            <div class="form-group">
                <select name="ToLocationId" id="ToLocationId">
                    <option value="">Seçiniz</option>
                    <cfoutput query="getTDepolar">
                        <option <CFIF STORE_LOCATION NEQ 15> style="color:red" disabled</CFIF> value="#STORE#-#STORE_LOCATION#">#COMMENT#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>
            <button onclick="Tasi()">Taşıma Yap</button>
        </td>
    </tr>
</table>

<script>
    function Tasi(params) {
        var FromLocationId=$("#FromLocationId").val();
        var ToLocationId=$("#ToLocationId").val();


    }
</script>