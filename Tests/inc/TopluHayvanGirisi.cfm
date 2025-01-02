<cfif isDefined("attributes.girici") and attributes.girici eq 1>
    <cfdump var="#attributes#">
    <cfquery name="get_hlot" datasource="#dsn2#">
        SELECT LOT_NO FROM #dsn2#.SHIP_ROW WHERE SHIP_ID IN (
SELECT SH.SHIP_ID FROM #dsn2#.INVOICE_SHIPS AS INV_SH
LEFT JOIN #dsn2#.SHIP AS SH ON SH.SHIP_ID=INV_SH.SHIP_ID
  WHERE
  1=1 
  AND IMPORT_INVOICE_ID=#attributes.inv_id# 
  AND SH.SHIP_TYPE=811)
        
        
    </cfquery>
    <cfloop query="get_hlot">
        <cfquery name="IHV" datasource="#DSN1#">
              SELECT * FROM w3Toruntex_product.CIFTLIK_HAYVANLAR WHERE LOT_NO='#LOT_NO#'
        </cfquery>
        <cfif IHV.recordCount>
            <cfquery name="UPD" datasource="#DSN1#">
                UPDATE CIFTLIK_HAYVANLAR SET ENTRY_DATE='#attributes.gir_d#' WHERE LOT_NO='#LOT_NO#'
            </cfquery>
        
        </cfif>
    </cfloop>
    <cfquery name="UPD" datasource="#DSN2#">
        UPDATE INVOICE SET HAYVAN_GIRISI_YAPILDI=1 WHERE INVOICE_ID=#attributes.inv_id#
    </cfquery>
    <cfabort>
</cfif>

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