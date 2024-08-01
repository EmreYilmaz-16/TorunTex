<cf_box title="Toplu Hayvan Girişi">
<cfset GETF=getFatura()>
<div class="form-group">
    <label>Fatura No</label>
    <select name="INVO">
        <cfoutput query="GETF">
            <option value="#INVOICE_ID#">#INVOICE_NUMBER#</option>
        </cfoutput>
    </select>
</div>

<div class="form-group">
    <label>
        Giriş Tarihi
    </label>
    <input type="date" name="ENTRY_DATE">
</div>

<div class="form-group">
    <button onclick="GirCanim('<cfoutput>#attributes.modal_id#</cfoutput>')" class="btn btn-outline-success" type="button">Giriş Yap</button>
    <button class="btn btn-outline-danger" onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')" type="button">Kapat</button>
</div>

</cf_box>
<cffunction name="getFatura">
    <cfquery name="GETF" datasource="#DSN2#">
        SELECT DISTINCT INVOICE_ID
            ,INVOICE_NUMBER
            ,PROCESS_STAGE
            ,PROJECT_HEAD
        FROM (
            SELECT INVOICE_NUMBER
                ,I.INVOICE_ID
                ,IR.AMOUNT
                ,IR.AMOUNT2
                ,I.PROCESS_STAGE
                ,PPR.PROJECT_HEAD AS PROJECT_HEAD               
            FROM #dsn2#.INVOICE AS I
            INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
            LEFT JOIN #dsn#.PRO_PROJECTS AS PPR ON PPR.PROJECT_ID = I.PROJECT_ID
            WHERE INVOICE_CAT = 591 AND PPR.BRANCH_ID=5
            AND ISNULL(HAYVAN_GIRISI_YAPILDI,0)=0
            --    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
            ) AS IRRS
        

</cfquery>
<cfreturn GETF>
</cffunction>
<cffunction name="getLocation">
    <cfquery name="getl" datasource="#dsn#">
        SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=18
    </cfquery>
    <cfreturn getl>
</cffunction>

<script>
    function GirCanim(params) {
        var inv_id=document.getElementsByName("INVO")[0].value;
        var gir_d=document.getElementsByName("ENTRY_DATE")[0].value;
        if(inv_id.length==0){
            alert("Fatura Seçmediniz");
            return false;
        }
        if(gir_d.length==0){
            alert("Tarih Seçmediniz");
            return false;
        }
        $.ajax({
            url:"/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=60&girici=1",
            data:{
                inv_id:inv_id,
                gir_d:gir_d
            }
        }).done(function (params) {
            closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')
        })
    }
</script>