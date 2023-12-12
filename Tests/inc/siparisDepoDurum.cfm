<div class="form-group">
    <label>Depo - Lokasyon</label>
    <cfquery name="GETSL" datasource="#DSN#">
        SELECT D.DEPARTMENT_ID,
            SL.LOCATION_ID,
            D.DEPARTMENT_HEAD,
            SL.COMMENT
        FROM STOCKS_LOCATION AS SL
            INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID = SL.DEPARTMENT_ID
        ORDER BY D.DEPARTMENT_ID
    </cfquery>
    <select name="DEPOLAMA" id="DEPOLAMA" onchange="setDept(this)">
        <cfoutput query="GETSL" group="DEPARTMENT_ID">
            <optgroup label="#DEPARTMENT_HEAD#">
             <cfoutput><option value="#DEPARTMENT_ID#-#LOCATION_ID#">#COMMENT#</option></cfoutput>
                
                
              </optgroup>
        </cfoutput>
    </select>
</div>