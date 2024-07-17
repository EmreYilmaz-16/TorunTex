<style>
    .ui-scroll{
        margin:0px !important
    }
    .pbscfl{
        height: 40vh;
    border: solid 1px #bbb;
    border-top: none;
}
.ui-form input:not(.ui-wrk-btn), .ui-form select, .ui-form textarea {
    border: solid 0.5px #ccc !important;

}

</style>
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
<cfdump var="#GetHayvan#">
<cfdump var="#attributes#">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=54">
<input type="hidden" name="HAYVAN_ID" value="<cfoutput>#attributes.iid#</cfoutput>">
<input type="hidden" name="iid" value="<cfoutput>#attributes.iid#</cfoutput>">
    <cf_tab defaultOpen="sayfa_1" divId="sayfa_1,sayfa_2,sayfa_3,sayfa_6,sayfa_5,sayfa_4,sayfa_7" divLang="Genel Bilgiler;Tohumlama- Gebelik;Süt Verim;Ağırlık Bilgileri;Tedavi;Kontrol;Diğer Bilgiler">
        <div id="unique_sayfa_1" class="ui-info-text uniqueBox">
           <div  class="pbscfl">
            <cfinclude template="Ciftlik/HayvanGenelBilgi.cfm">
            <input type="submit" value="Güncelle" style="bottom: 0;position: absolute;right: 0;margin: 10px;">
        </div>
        </div>
        <div id="unique_sayfa_2" class="ui-info-text uniqueBox">
            <div class="pbscfl">
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
            <input type="submit" value="Güncelle" style="bottom: 0;position: absolute;right: 0;margin: 10px;">
        </div>
        </div>
        <div id="unique_sayfa_3" class="ui-info-text uniqueBox">
            <div class="pbscfl">
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
                            <b><cfoutput>#GetHayvan.ORTALAMA_SUT#</cfoutput> KG</b>
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
                <input type="submit" value="Güncelle" style="bottom: 0;position: absolute;right: 0;margin: 10px;">
            </div>
        </div>
        <div id="unique_sayfa_4" class="ui-info-text uniqueBox">
            <div class="pbscfl">
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
                        Son Kontrol Tarihi   : <cfoutput>#dateFormat(GetHayvan.KONTROL_DATE,"dd/mm/yyyy")#</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Kontrol Tarihi</label>
                            <input type="text" name="KONTROL_DATE">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Kontrol Durumu</label>
                              <input type="text" name="KONTROL">
                        </div>
                    </td>
                </tr>            
            </cf_grid_list>
            <input type="submit" value="Güncelle" style="bottom: 0;position: absolute;right: 0;margin: 10px;">
        </div>
        </div>
        <div id="unique_sayfa_5" class="ui-info-text uniqueBox">
            <div class="pbscfl">
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
                        Son Tedavi Tarihi    : <cfoutput>#dateFormat(GetHayvan.TEDAVI_DATE,"dd/mm/yyyy")#</cfoutput><br>
                        Sun Uygulanan Tedavi : <cfoutput>#dateFormat(GetHayvan.TEDAVI,"dd/mm/yyyy")#</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Tedavi Tarihi</label>
                            <input type="text" name="TEDAVI_DATE">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Uygulanan Tedavi</label>
                              <input type="text" name="TEDAVI">
                        </div>
                    </td>
                </tr>            
            </cf_grid_list>
            <input type="submit" value="Güncelle" style="bottom: 0;position: absolute;right: 0;margin: 10px;">
        </div>
        </div>
           <div id="unique_sayfa_6" class="ui-info-text uniqueBox">
            <div class="pbscfl">
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
                            <input type="text" name="SURU_AGIRLIK" value="<cfoutput>#GetHayvan.SURU_AGIRLIK#</cfoutput>">
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
                                        <input type="text" name="AGIRLIK_DATE">
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
            <input type="submit" value="Güncelle" style="bottom: 0;position: absolute;right: 0;margin: 10px;">
        </div>
        </div>
        <div id="unique_sayfa_7" class="ui-info-text uniqueBox">
            <div class="pbscfl">
                <cf_grid_list>
                    <thead>
                        <tr>
                            <th colspan="2">
                                Diğer Bilgileri
                            </th>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Günlük Beslenme</label>
                                <input type="text" name="GUNLUK_BESLENME">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Günlük Dinlenme</label>
                                <input type="text" name="GUNLUK_DINLENME">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Günlük Geviş Süresi</label>
                                <input type="text" name="GUNLUK_GEVIS_SURE">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Günlük Hareket</label>
                                <input type="text" name="GUNLUK_HAREKET">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Tasma Id</label>
                                <input type="text" name="TASMA_ID">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Tasma Etiket</label>
                                <input type="text" name="TASMA_ETIKET">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Laktasyon Günü</label>
                                <input type="text" name="LAKTASYON_GUNU">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Laktasyon Sayısı</label>
                                <input type="text" name="LAKTASYON_SAYI">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Sağlık Oranı</label>
                                <input type="text" name="SAGLIK_ORANI">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Kızgınlık İndexi</label>
                                <input type="text" name="KIZGINLIK_INDEXI">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <label>Son Kızgınlık Tarihi</label>
                                <input type="text" name="SON_KIZGINLIK_TARIHI">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Son Buzağlama Tarihi</label>
                                <input type="text" name="LAST_BUZAGLAMA_DATE">
                            </div>
                        </td>
                    </tr>
                </cf_grid_list>
                    
            </div>
        </div>
    </cf_tab>
    
<input type="hidden" name="is_submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
</cfif>