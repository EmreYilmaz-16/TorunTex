<cf_box title="Çuval Taşı">
    <div class="form-group">
        <label>Lot No</label>
        <input class="form-control" type="text" name="BARCODE" id="BARCODE" onkeyup="getBarkode_1(this,event)">
    </div>
    <div class="form-group">
        <label>Giriş Depos</label>
        <select class="form-control form-select" name="DEPARTMENT_OUT_SEL" id="DEPARTMENT_OUT_SEL" onchange="setDO(this)">
            <option value="">Giriş Deposu Seçiniz</option>
        </select>
        
    </div>
    <cf_grid_list>
        <thead>
            <tr>
                <th>
                    Ürün
                </th>
                <th>
                    Miktar
                </th>
                <th>
                    Çıkış Depo
                </th>
                <th>
                    Giriş Depo
                </th>
                <th>

                </th>
            </tr>
        </thead>
        <tbody id="SEPETIM">

        </tbody>
    </cf_grid_list>


</cf_box>
<script>
    <cfoutput>
        var dsn="#dsn#";
        var dsn1="#dsn1#";
        var dsn2="#dsn2#";
        var dsn3="#dsn3#";
    </cfoutput>        
</script>

<script src="/AddOns/Partner/js/tasima.js"></script>