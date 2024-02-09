<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<CF_BOX>
<div>
    <cfquery name="getCompanies" datasource="#dsn#">
        SELECT DISTINCT NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE
    </cfquery>
    <cfquery name="ProductCats" datasource="#dsn#">
        SELECT DISTINCT PRODUCT_CAT FROM MY_TEMP_TABLE
    </cfquery>
    <select name="Company" id="Company" onchange="getDataWithCompany(this)">
      <option value="">Müşteri</option>
      <cfoutput query="getCompanies">
        <option value="#COMPANY_ID#">#NICKNAME#</option>
      </cfoutput>
    </select>
    <select name="ProductCat" id="ProductCat" onchange="getDataWithProductCat(this.value)">
        <option value="">Kategori</option>
        <cfoutput query="ProductCats">
          <option value="#PRODUCT_CAT#">#PRODUCT_CAT#</option>
        </cfoutput>
      </select>
      
      <input type="date" name="tarih" id="tarih" onchange="getDataWithDate(this.value)">
</div>

<div style="display:flex;flex-wrap: wrap;">
    <div style="width:33%">
      <cf_box >
        <canvas style="width:100%" id="CompanyTotalSales"></canvas>
    </cf_box>
    </div>
    <div style="width:33%">
        <cf_box >
        <canvas style="width:100%" id="DailyTotalSales"></canvas>
    </cf_box>
    </div>
    <div style="width:33%">
        <cf_box >
        <canvas style="width:100%" id="ProductCatTotalSales"></canvas>
    </cf_box>
    </div>
    <div style="width:33%">
        <cf_box >
        <canvas style="width:100%" id="CountryTotalSales"></canvas>
    </cf_box>
    </div>
    <div style="width:33%">
        <cf_box >
      <canvas style="width:100%" id="CompanySalesPerctange"></canvas>
    </cf_box>
  </div>
  <div style="width:33%">
    <cf_box >
    <canvas style="width:100%" id="CountrySalesPerctange"></canvas>
</cf_box>
</div>
</div>
</CF_BOX>A
<script src="/AddOns/Partner/js/dashboard.js"></script>