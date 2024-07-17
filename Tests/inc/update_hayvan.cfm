<cfquery name="GetAnimalTypes" datasource="#dsn3#">
    select STOCK_ID,PRODUCT_NAME,PRODUCT_ID,PROPERTY from w3Toruntex_1.STOCKS WHERE PRODUCT_CODE LIKE '01H.%' AND PROPERTY <>''
</cfquery>
<cfquery name="Hayvan_Tip" datasource="#dsn1#">
    SELECT  HTIP_ID
      ,TIP
  FROM CIFTLIK_HAYVAN_TIP

</cfquery>
<cfquery name="GetHayvan" datasource="#DSN3#">
     SELECT * FROM CIFTLIK_HAYVANLARIM2 WHERE HAYVAN_ID=#attributes.iid#;
</cfquery>
<cfdump var="#attributes#">
<cfform>
<input type="hidden" name="HAYVAN_ID" value="<cfoutput>#attributes.iid#</cfoutput>">
    <cf_tab defaultOpen="sayfa_1" divId="sayfa_1,sayfa_2,sayfa_3,sayfa_6,sayfa_5,sayfa_4" divLang="Genel Bilgiler;Tohumlama- Gebelik;Süt Verim;Ağırlık Bilgileri;Tedavi;Kontrol">
        <div id="unique_sayfa_1" class="ui-info-text uniqueBox">
            <cfinclude template="Ciftlik/HayvanGenelBilgi.cfm">
        </div>
        <div id="unique_sayfa_2" class="ui-info-text uniqueBox">
            <cf_grid_list>
            <thead>
                <tr>
                    <th colspan="2">
                        Tohumlama Bilgileri
                    </th>
                </tr>
            </thead>
                <tr>
                    <td colspan="2">
                        Son Tohumlama Tarihi : <cfoutput>#dateFormat(GetHayvan.TOHUMLAMA_DATE,"dd/mm/yyyy")#</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Tohumlama Tarihi</label>
                            <input type="text" name="B_KULAK_NO">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Tohumlama Sayısı</label>
                            <input type="text" name="B_KULAK_NO">
                        </div>
                    </td>
                </tr>            
            </cf_grid_list>
            <cf_grid_list>
                <thead>
                <tr>
                    <th colspan="2">
                        Gebelik Bilgileri
                    </th>
                </tr>
            </thead>
                <tr>
                    <td colspan="2">
                        Son Gebelik Tarihi   : <cfoutput>#dateFormat(GetHayvan.GEBELIK_DATE,"dd/mm/yyyy")#</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Gebelik Tarihi</label>
                            <input type="text" name="B_KULAK_NO">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Gebelik Durumu</label>
                                <select>
                                    <option value="0">Seçiniz</option>
                                    <option value="1">Gebe</option>
                                </select>
                        </div>
                    </td>
                </tr>            
            </cf_grid_list>
        </div>
        <div id="unique_sayfa_3" class="ui-info-text uniqueBox">
            <cf_grid_list>
                <thead>
                    <tr>
                        <th colspan="2">
                            Süt Verim Bilgileri
                        </th>
                    </tr>
                </thead>
                    <tr>
                        <td colspan="2">
                            Ortalama Süt Verimi<br>
                            <b>555 KG</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Kayıt Tarihi</label>
                                <input type="text" name="B_KULAK_NO">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Süt KG</label>
                                <input type="text" name="B_KULAK_NO">
                            </div>
                        </td>
                    </tr>            
                </cf_grid_list>
        </div>
        <div id="unique_sayfa_4" class="ui-info-text uniqueBox">
            <cf_grid_list>
                <thead>
                <tr>
                    <th colspan="2">
                        Kontrol Bilgileri
                    </th>
                </tr>
            </thead>
                <tr>
                    <td colspan="2">
                        Son Kontrol Tarihi   : <cfoutput>#dateFormat(GetHayvan.GEBELIK_DATE,"dd/mm/yyyy")#</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Kontrol Tarihi</label>
                            <input type="text" name="B_KULAK_NO">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Kontrol Durumu</label>
                              <input type="text">
                        </div>
                    </td>
                </tr>            
            </cf_grid_list>
        </div>
        <div id="unique_sayfa_5" class="ui-info-text uniqueBox">
            <cf_grid_list>
                <thead>
                <tr>
                    <th colspan="2">
                        Son Tedavi Bilgileri
                    </th>
                </tr>
            </thead>
                <tr>
                    <td colspan="2">
                        Son Tedavi Tarihi    : <cfoutput>#dateFormat(GetHayvan.GEBELIK_DATE,"dd/mm/yyyy")#</cfoutput><br>
                        Sun Uygulanan Tedavi : <cfoutput>#dateFormat(GetHayvan.GEBELIK_DATE,"dd/mm/yyyy")#</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Tedavi Tarihi</label>
                            <input type="text" name="B_KULAK_NO">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Uygulanan Tedavi</label>
                              <input type="text">
                        </div>
                    </td>
                </tr>            
            </cf_grid_list>
        </div>
           <div id="unique_sayfa_6" class="ui-info-text uniqueBox">
            <cf_grid_list>
                <thead>
                    <tr>
                        <th colspan="2">
                            Ağırlık Bilgileri
                        </th>
                    </tr>
                </thead>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Sürü Katılım Ağırlığı</label>
                            <input type="text" name="SURU_AGIRLIK">
                        </div>
                    </td>
                    <td>
                        
                           
                        
                        <cf_grid_list>
                            <thead>
                                <tr>
                                    <th colspan="2">
                                        Son Ağırlık<br>
                                        <cfoutput>#GetHayvan.AGIRLIK_DATE# - #GetHayvan.AGIRLIK#</cfoutput>
                                    </th>
                                </tr>
                            </thead>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <label>Tartim Tarihi</label>
                                        <input type="text" name="B_KULAK_NO">
                                    </div>
                                </td>
                                <td>
                                    <div class="form-group">
                                        <label>Tartim KG</label>
                                        <input type="text" name="AGIRLIK">
                                    </div>
                                </td>
                            </tr>
                        </cf_grid_list>
                     
                    </td>
                </tr>
            </cf_grid_list>
        </div>
    </cf_tab>


</cfform>