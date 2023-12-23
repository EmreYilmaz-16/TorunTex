<cf_box title="Raftan Çuval Al">
    <cfquery name="getLocations" datasource="#dsn#">
        SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=13
    </cfquery>
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>Hol </label>
                    <select name="LOCATION" id="LOCATION" onchange="getShelves(this)">
                        <option value="">Seçiniz</option>                       
                        <cfoutput query="#getLocations#">
                        <option value="#DEPARTMENT_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </select>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <label>Raf</label>
                    <select name="SHELF" id="SHELF" onchange="getShelfProducts(this)">
                        <option value="">Seçiniz</option>
                    </select>
                </div>
            </td>
        </tr>        
    </table>
    <cf_big_list>
        <thead>
            <tr>
                <th>
                    Ürün Kodu
                </th>
                <th>
                    Beyanname No
                </th>
                <th>
                    Çuval
                </th>
                <th>
                    Miktar
                </th>
            </tr>
        </thead>
        <tbody id="Sepetim">

        </tbody>
    </cf_big_list>

</cf_box>

