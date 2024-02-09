<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div>
    <cfquery name="getCompanies" datasource="#dsn#">
        SELECT DISTINCT NICKNAME,COMPANY_ID FROM MY_TEMP_TABLE
    </cfquery>
    <select name="Company" id="Company" onchange="getDataWithCompany(this)">
      <option value="">Müşteri</option>
      <cfoutput query="getCompanies">
        <option value="#COMPANY_ID#">#NICKNAME#</option>
      </cfoutput>
    </select>
</div>

<div style="display:flex;flex-wrap: wrap;">
    <div style="width:50%">
      
        <canvas style="width:100%" id="CompanyTotalSales"></canvas>
    </div>
    <div style="width:50%">
      
        <canvas style="width:100%" id="DailyTotalSales"></canvas>
    </div>
    <div style="width:50%">
      
        <canvas style="width:100%" id="ProductCatTotalSales"></canvas>
    </div>
    <div style="width:50%">
      
        <canvas style="width:100%" id="CountryTotalSales"></canvas>
    </div>
    <div style="width:50%">
      
      <canvas style="width:100%" id="CompanySalesPerctange"></canvas>
  </div>
</div>
<script src="/AddOns/Partner/js/dashboard.js"></script>