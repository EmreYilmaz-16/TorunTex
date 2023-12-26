<cf_box title="İthal Mal Girişi">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>Fatura No</label>
                  
                    <cfset GETF=getFatura()>
                    <SELECT class="form-control form-select" name="FaturaNo" id="FaturaNo" onchange="getFatura(this,event)">
                        <option value="">Seçiniz</option>
                        <cfoutput query="GETF">
                            <option value="#INVOICE_ID#">#INVOICE_NUMBER#</option>
                        </cfoutput>
                    </SELECT>
                    <!---<input type="text" name="FaturaNo" id="FaturaNo" onkeyup="getFatura(this,event)">---->
                </div>
            </td>
            <td>
                <CFSET GETL=getLocation()>
                <div class="form-group">
                    <label>Hol</label>
                    <SELECT class="form-control form-select" name="DEPARTMENT_LOCATION" id="DEPARTMENT_LOCATION" onchange="getShelves(this,event)">
                        <option value="">Seçiniz</option>
                        <cfoutput query="GETL">
                            <option value="#DEPARTMENT_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </SELECT>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <label>Raf</label>
                    <SELECT class="form-control form-select" name="PRODUCT_PLACE_ID" id="PRODUCT_PLACE_ID" onchange="setShelf(this)">
                        <option value="">Seçiniz</option>
                    </SELECT>
                </div>
            </td>
            <td>
                <button type="button" onclick="$('#form1').submit()"
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="fatura_satirlari">
                    
                </div>
            </td>
        </tr>
    </table>
    <cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=38&is_submit=1" id="form1">
    <input type="hidden" name="row_count" id="row_count">
    <input type="hidden" name="DEP_LOC" id="DEP_LOC">
   <cf_big_list>
    <thead>
        <tr>
            <th></th>
            <th>
                Konteyner No
            </th>
            <th>Ağırlık</th>
            <th>Adet</th>
            <th>Raf No</th>
            <th>Ürün Kodu</th>
            <th>Ürün</th>
        </tr>
    </thead>
    <tbody id="SEPETIM">

    </tbody>
   </cf_big_list>
</cfform>
</cf_box>

<script src="/AddOns/Partner/js/ithalatFatura.js"></script>



<cffunction name="getFatura">
    <cfquery name="GETF" datasource="#DSN2#">
        SELECT DISTINCT INVOICE_ID
            ,INVOICE_NUMBER
            ,PROCESS_STAGE
            
        FROM (
            SELECT INVOICE_NUMBER
                ,I.INVOICE_ID
                ,IR.AMOUNT
                ,IR.AMOUNT2
                ,I.PROCESS_STAGE
                ,(
                    SELECT SUM(AMOUNT)
                    FROM #dsn2#.SHIP_ROW AS SR
                    INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
                    WHERE 1 = 1
                        AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
                        AND S.SHIP_TYPE = 811
                    ) AS AC
                    ,(
                    SELECT SUM(AMOUNT2)
                    FROM #dsn2#.SHIP_ROW AS SR
                    INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
                    WHERE 1 = 1
                        AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
                        AND S.SHIP_TYPE = 811
                    ) AS AC2
            FROM #dsn2#.INVOICE AS I
            INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
            WHERE INVOICE_CAT = 591
            --    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
            ) AS IRRS
        WHERE ISNULL(AC, 0) < AMOUNT

</cfquery>
<cfreturn GETF>
</cffunction>
<cffunction name="getLocation">
    <cfquery name="getl" datasource="#dsn#">
        SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=13
    </cfquery>
    <cfreturn getl>
</cffunction>