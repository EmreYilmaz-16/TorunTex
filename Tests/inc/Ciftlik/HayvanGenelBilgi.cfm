<cf_big_list>
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
                <input type="text" name="B_KULAK_NO">
            </div>
        </td>
        <td rowspan="2"></td>
    </tr>
    <tr>
        <td>
            <div class="form-group">
                <label>Anne Küpe No</label>
                <input type="text" name="A_KULAK_NO">
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Baba Küpe No</label>
                <input type="text" name="F_KULAK_NO">
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
</cf_big_list>