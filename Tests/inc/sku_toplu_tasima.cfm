<cfquery name="getDoluDepolar" datasource="#dsn#">
    select STORE_LOCATION,STORE,COMMENT,COUNT(*) from (
        SELECT T.*,SL.COMMENT FROM (
            select SUM(STOCK_IN-STOCK_OUT) VB,LOT_NO,STORE,STORE_LOCATION 
            from #dsn2#.STOCKS_ROW 
            WHERE STORE IN(14,15) 
            GROUP BY LOT_NO,STORE,STORE_LOCATION
        ) AS T 
        LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL 
        ON SL.DEPARTMENT_ID=T.STORE AND SL.LOCATION_ID=T.STORE_LOCATION
        WHERE VB>0
    ) as TT  
    GROUP BY STORE_LOCATION,STORE,COMMENT 
    HAVING COUNT(*) >0
    ORDER BY COMMENT
</cfquery>

<cfquery name="getTDepolar" datasource="#dsn#">
    select COMMENT,DEPARTMENT_ID as STORE,LOCATION_ID AS STORE_LOCATION 
    from w3Toruntex.STOCKS_LOCATION 
    where DEPARTMENT_ID IN (15)
</cfquery>
<cfif not isDefined("form.fromForm")>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#">
    <table>
        <tr>
            <td>
                <div class="form-group">                
                    <label>Çıkış Depo</label>
                    <select name="OUT_STORE">
                        <option value="">Seçiniz</option>
                        <cfoutput query="getDoluDepolar">
                            <option value="#STORE#-#STORE_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </select>
                </div>
            </td>
       
            <td>
                <div class="form-group">                
                    <label>Ürün Kodu</label>
                    <input type="text" name="SKU_CODE" />
                </div>
            </td>
        
            <td>
                <div class="form-group">                
                    <label>Giriş Depo</label>
                    <select name="IN_STORE">
                        <option value="">Seçiniz</option>
                        <cfoutput query="getTDepolar">
                            <option value="#STORE#-#STORE_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </select>
                </div>
            </td>
      <td>
    <input type="submit" value="Ara" />
    <input type="hidden" name="is_submit" value="1" />
    <input type="hidden" name="fromForm" value="1" />
</td>
</tr>
</table>
</cfform>
</cfif>

<cfif isDefined("form.is_submit")>
    <cfif form.fromForm eq 1>
        <cfinclude template="sku_toplu_tasima_query.cfm">
       <cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#">
        <input type="submit" value="Taşıma Yap" />
        <input type="hidden" name="is_submit" value="1" />
        <input type="hidden" name="fromForm" value="2" />
        <cfoutput>
        <input type="hidden" name="OUT_STORE" value="#form.OUT_STORE#" />
        <input type="hidden" name="IN_STORE" value="#form.IN_STORE#" />
    </cfoutput>
        <table class="table">
            <thead>
                <tr>
                    <th>Ürün</th>
                    <th>Lot No</th>
                    <th>Miktar (KG)</th>
                    <th><input type="checkbox" id="checkAll" onclick="tumunuSec(this)" /></th>
                </tr>
            </thead>
            <tbody>
                <cfif GETSKU.recordCount EQ 0>
                    <tr>
                        <td colspan="4">Ürün Bulunamadı</td>
                    </tr>
                <cfelse>
                    <cfif getStocks.recordCount GT 0>
                        <cfoutput query="getStocks">
                            <tr>
                                <td>#PRODUCT_NAME#</td>
                                <td>#LOT_NO#</td>
                                <td>#BAKIYE#</td>
                                <td>
                                    <input type="hidden" name="stock_id_#currentrow#" value="#STOCK_ID#" />
                                    <input type="hidden" name="lot_no_#currentrow#" value="#LOT_NO#" />
                                    <input type="hidden" name="bakiye_#currentrow#" value="#BAKIYE#" />
                                    <input type="checkbox" name="row" value="#currentrow#" />
                                </td>
                            </tr>
                        </cfoutput>
                    <cfelse>
                        <tr>
                            <td colspan="4">Ürün Bulunamadı</td>
                        </tr>
                    </cfif>
                </cfif>         
            </tbody>
        </table>

    </cfform>
    </cfif>
    <cfif attributes.fromForm eq 2>
        
      <cfinclude template="sku_toplu_tasima_query2.cfm">
      
      <script>
        alert("Taşıma Başarılı");
        window.location.href = "/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=65";
      </script>

    </cfif>
</cfif>



<script>
    function tumunuSec(e) {
        if($(e).is(":checked")) {
            $("input[name='row']").prop("checked", true);
        } else {
            $("input[name='row']").prop("checked", false);
        }
    }
</script>