<cf_grid_list>
    <thead>
        <tr>
            <th colspan="3">
                Genel Bilgiler
            </th>
        </tr>
    </thead>
    <tr>
        <td>
            <div class="form-group">
                <label>Küpe No</label>
                <input type="text" name="LOT_NO" value="<cfoutput>#GetHayvan.LOT_NO#</cfoutput>">
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Boğa Küpe No</label>
                <input type="text" value="<cfoutput>#GetHayvan.B_KIMLIK_NO#</cfoutput>">
            </div>
        </td>
        <td rowspan=""></td>
    </tr>
    <tr>
        <td>
            <div class="form-group">
                <label>Anne Küpe No</label>
                <input type="text" name="A_KIMLIK_NO" value="<cfoutput>#GetHayvan.A_KIMLIK_NO#</cfoutput>">
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Baba Küpe No</label>
                <input type="text" name="F_KIMLIK_NO" value="<cfoutput>#GetHayvan.F_KIMLIK_NO#</cfoutput>">
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Cins</label>
                <select name="GIRIS_STOK_ID">
                    <option value="">Seçiniz</option>
                    <cfoutput query="GetAnimalTypes" group="PRODUCT_ID">
                        <optgroup label="#PRODUCT_NAME#">
                        <cfoutput>
                                <option <cfif GetHayvan.GIRIS_STOK_ID eq STOCK_ID>selected</cfif> value="#STOCK_ID#-#PRODUCT_ID#">#PROPERTY#</option>
                        </cfoutput>
                        </optgroup>
                    </cfoutput>
                </select>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="form-group">
                <label>Ülke</label>
                <input type="text" name="COUNTRY" value="<cfoutput>#GetHayvan.COUNTRY#</cfoutput>">
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Cinsiyeet</label>
                <select name="GENDER">
                    <option <cfif GetHayvan.GENDER eq 0>selected</cfif> value="0">Dişi</option>
                    <option <cfif GetHayvan.GENDER eq 1>selected</cfif> value="1">Erkek</option>
                </select>
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Tip</label>
                <select name="HTIP">
                    <option value="">Seçiniz</option>
                    <cfoutput query="Hayvan_Tip" >
                  
                                <option <cfif GetHayvan.HTIP eq HTIP_ID>selected</cfif> value="#HTIP_ID#">#TIP#</option>
                           
                    </cfoutput>
                </select>
            </div>
        </td>
    </tr>
</cf_grid_list>