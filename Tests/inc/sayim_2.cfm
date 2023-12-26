<cfparam name="attributes.product_code_area" default="PRODUCT_CODE_2">  <!--------  //BILGI ÜRÜN KODU ARAMA ALANI     ------------->
<cf_box title="Sayim">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>Depo - Lokasyon</label>
                    <cfquery name="GETSL" datasource="#DSN#">
                        SELECT D.DEPARTMENT_ID,SL.LOCATION_ID,D.DEPARTMENT_HEAD,SL.COMMENT FROM STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID ORDER BY D.DEPARTMENT_ID
                    </cfquery>
                    <select name="DEPOLAMA" id="DEPOLAMA" onchange="setDept(this)">
                        <cfoutput query="GETSL" group="DEPARTMENT_ID">
                            <optgroup label="#DEPARTMENT_HEAD#">
                            <cfoutput><option value="#DEPARTMENT_ID#-#LOCATION_ID#">#COMMENT#</option></cfoutput>                                                                        
                            </optgroup>
                        </cfoutput>
                    </select>                             
            </td>
            <td>
                <div class="form-group">
                    <label>Ürün Kodu</label>
                    <input type="text" name="PRODUCT_CODE" id="PRODUCT_CODE"  placeholder="Ürün Kodu" onkeyup="getProduct(this,event,'<cfoutput>#attributes.product_code_area#</cfoutput>')">
                </div>
            </td>
        </tr>
    </table>
    <cfform id="frm1" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=26">
        <cf_big_list >
            <tr>
                <th>
                    Lot No
                </th>
                <th>
                    Ürün
                </th>         
                <th>
                    Miktar
                </th>
            </tr>
        <tbody id="SayimTable">
        
        </tbody>
        </cf_big_list>
        <input type="hidden" name="is_submit" value="1">
        <input type="hidden" name="row_count" id="RC" value="">
        <input type="hidden" name="TXT_DEPARTMENT_IN" id="TXT_DEPARTMENT_IN" value="<cfoutput>#attributes.default_depo#</cfoutput>">
        <input type="hidden" name="is_default_depo" id="is_default_depo" value="<cfoutput>#attributes.is_default_depo#</cfoutput>">
        <input type="hidden" name="is_rafli" id="is_rafli" value="<cfoutput>#attributes.is_rafli#</cfoutput>">
        </cfform>
</cf_box>

<script src="/AddOns/Partner/js/sayim_2.js"></script>