<cf_box title="İthal Mal Girişi">
    <div class="form-group">
        <label>Fatura No</label>
        <cfquery name="GETF" datasource="#DSN2#">
    SELECT DISTINCT INVOICE_ID
        ,INVOICE_NUMBER
        ,PROCESS_STAGE
        
    FROM (
        SELECT INVOICE_NUMBER
            ,I.INVOICE_ID
            ,IR.AMOUNT
            ,I.PROCESS_STAGE
            ,(
                SELECT SUM(AMOUNT)
                FROM #dsn2#.SHIP_ROW AS SR
                INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
                WHERE 1 = 1
                    AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
                    AND S.SHIP_TYPE = 811
                ) AS AC
        FROM #dsn2#.INVOICE AS I
        INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
        WHERE INVOICE_CAT = 591
        --    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
        ) AS IRRS
    WHERE ISNULL(AC, 0) < AMOUNT
    
        </cfquery>
        
        <SELECT class="form-control form-select" name="FaturaNo" id="FaturaNo" onchange="getFatura(this,event)">
            <option value="">Seçiniz</option>
            <cfoutput query="GETF">
                <option value="#INVOICE_NUMBER#">#INVOICE_NUMBER#</option>
            </cfoutput>
        </SELECT>
        <!---<input type="text" name="FaturaNo" id="FaturaNo" onkeyup="getFatura(this,event)">---->
    </div>
</cf_box>