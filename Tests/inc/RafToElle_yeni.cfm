<cf_box title="Raftan Çuval Al">
    <cfquery name="getLocations" datasource="#dsn#">
        SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=13
    </cfquery>
    <table>
        <tr>
            <td style="vertical-align:top">
                <div class="form-group">
                    <label>Hol </label>
                    <select name="LOCATION" id="LOCATION" onchange="getShelves(this)">
                        <option value="">Seçiniz</option>                       
                        <cfoutput query="getLocations">
                        <option value="#DEPARTMENT_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </select>
                </div>
            </td>
            <td style="vertical-align:top">
                <div class="form-group">
                    <label>Raf</label>
                    <select name="SHELF" id="SHELF" onchange="getShelfProducts(this)">
                        <option value="">Seçiniz</option>
                    </select>
                </div>
            </td>
            </tr>
            <tr>
            <td colspan="2">
                <div class="form-group">
                    <label>Ürün</label>
                    <div>
                        <table class="table table-stripped">
                            <thead>
                                <tr>
                                    <th>
                                        Ürün K
                                    </th>
                                    <th>
                                        Ürün
                                    </th>
                                    <th>
                                        Miktar
                                    </th>
                                    <th>
                                        Çuval
                                    </th>
                                    <th>Beyanname</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody  id="URUNLER">

                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>   
        <tr style="display:none">
            <td>
                
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
<cfoutput>
<script>
    dsn="#dsn#";
    dsn1="#dsn1#";
    dsn2="#dsn2#";
    dsn3="#dsn3#";

</script>
</cfoutput>
<script src="/AddOns/Partner/js/ElleclemeSevk.js"></script>