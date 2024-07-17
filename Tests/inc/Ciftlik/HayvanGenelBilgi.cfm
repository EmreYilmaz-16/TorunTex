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
        <td rowspan="2"></td>
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
    </tr>
    <tr>
        <td>
            <div class="form-group">
                <label>Ülke</label>
                <input type="text" name="COUNTRY">
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Cinsiyeet</label>
                <select name="GENDER">
                    <option value="0">Dişi</option>
                    <option value="1">Erkek</option>
                </select>
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Cins</label>
                <select name="TIP">
                    <cfoutput query="Hayvan_Tip" >
                  
                                <option value="#HTIP_ID#">#TIP#</option>
                           
                    </cfoutput>
                </select>
            </div>
        </td>
    </tr>
</cf_grid_list>