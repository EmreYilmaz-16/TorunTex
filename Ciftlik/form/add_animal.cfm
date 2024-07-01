<cfdump var="#attributes#">
<style>
.form-control {
    display: block;
    width: 100% !important;
    height: calc(1.5em + .75rem + 2px);
    padding: .375rem .75rem !important;
    font-size: 1rem !important;
    font-weight: 400;
    line-height: 1.5 !important;
    color: #495057 !important;
    background-color: #fff !important;
    background-clip: padding-box;
    border: 1px solid #ced4da !important;
    border-radius: .25rem !important;
    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out !important;


}
</style>
<cfset AnimalService = createObject("component","AddOns.Partner.Ciftlik.cfc.animal")>
    <cfset _Ciflikler=AnimalService.GetCiftliks()>
    <cfset _Padoklar=AnimalService.getPadok()>
    <cfset _AnimalTypes=AnimalService.getHayvanTip()>
<cfset AnimalTypes=deserializeJSON(_AnimalTypes)>
<cfset Ciflikler=deserializeJSON(_Ciflikler)>
<cfset Padoklar=deserializeJSON(_Padoklar)>
<div class="row">
    <div class="col col-6">
        <div class="form-group">
            <label>
                Kulak Küpe Numarası
            </label>
            <input class="form-control" type="text" name="LOT_NO">
        </div>
        <div class="form-group">
            <label>
                Doğum Tarihi
            </label>
            <input class="form-control" type="date" name="DOGUM_TARIHI">
        </div>
        <div class="form-group">
            <label>
                Cinsiyet
            </label>
        <div class="input-group">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="CINSIYET" value="1" id="CINSIYET1">
                <label class="form-check-label" for="CINSIYET1">
                  Erkek
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input" type="radio" name="CINSIYET" value="0" id="CINSIYET2">
                <label class="form-check-label" for="CINSIYET2">
                  Dişi
                </label>
              </div>
            </div>
        </div>
        <div class="form-group">
            <label>
                Sahibi
            </label>
            <input class="form-control" type="text" name="SAHIBI">
        </div>
        <div class="form-group">
            <label>
                Baba Kulak No
            </label>
            <input class="form-control" type="text" name="BABA_KULAK">
        </div>
        <div class="form-group">
            <label>
                Nevi
            </label>
            <input class="form-control" type="text" name="NEVI">
        </div>
        <div class="form-group">
            <label>
                Tasma ID
            </label>
            <input class="form-control" type="text" name="TASMA_ID">
        </div>
        <div class="form-group">
            <label>
                Ortalama Süt
            </label>
            <input class="form-control" type="text" name="SUT_KG">
        </div>
        <div class="form-group">
            <label>
                Laktasyon Günü
            </label>
            <input class="form-control" type="text" name="LAKTASYON_GUNU">
        </div>
        <div class="form-group">
            <label>
                Son Durum
            </label>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="GEBE_DURUM" value="1" id="GEBE_DURUM">
                <label class="form-check-label" for="GEBE_DURUM">
                  Gebe
                </label>
              </div>
              
        </div>
        <div class="form-group">
            <label>
                Son Tohumlama Tarihi
            </label>
            <input class="form-control" type="date" name="SON_TOHUM">
        </div>
    </div>
    <div class="col col-6">
        <div class="form-group">
            <label>
                Kimlik Numarası
            </label>
            <input class="form-control"  type="text" name="KIMLIK_NO">
        </div>
        <div class="form-group">
            <label>
                Ülke
            </label>
            <input class="form-control" type="text" name="ULKE">
        </div>
        <div class="form-group">
            <label>
                Cins
            </label>
            <select class="form-control form-select" name="CINS">
                <cfloop array="#AnimalTypes#" item="it">
                    <optgroup label="<cfoutput>#it.PRODUCT_NAME#</cfoutput>">
                        <cfloop array="#it.TYPES#" item="it2">
                        <cfif len(it2.PROPERTY) gt 0>   <option value="<cfoutput>#it2.STOCK_ID#</cfoutput>"><cfoutput>#it2.PROPERTY#</cfoutput></option></cfif>
                        </cfloop>
                    </optgroup>
                </cfloop>
            </select>
        </div>
        <div class="form-group">
            <label>
                Tip
            </label>
            <input class="form-control" type="text" name="TIP">
        </div>
        <div class="form-group">
            <label>
                Anne Kulak No
            </label>
            <input class="form-control" type="text" name="ANNE_KULAK">
        </div>
        <div class="form-group">
            <label>
                Agirlik
            </label>
            <input class="form-control" type="text" name="AGIRLIK">
        </div>
        <div class="form-group">
            <label>
                Tasma Etiket
            </label>
            <input class="form-control" type="text" name="TASMA_ETIKET">
        </div>
        <div class="form-group">
            <label>
                Çiftlik / Padok
            </label>
            <div class="input-group">
                <select class="form-control form-select"  name="CIFTLIK">
                    <cfloop array="#Ciflikler#" item="it">
                        <option value="<cfoutput>#it.CIFTLIK_ID#</cfoutput>"><cfoutput>#it.CIFTLIK_TUR# / #it.CIFTLIK#</cfoutput></option>
                    </cfloop>
                </select>
                <select class="form-control form-select"  name="PADOK">
                    <cfloop array="#Padoklar#" item="it">
                        <option value="<cfoutput>#it.PADOK_ID#</cfoutput>"><cfoutput>#it.PADOK#</cfoutput></option>
                    </cfloop>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label>
                Laktasyon Sayısı
            </label>
            <input class="form-control" type="text" name="LAKTASYON_SAYI">
        </div>
        <div class="form-group"></div>
        <div class="form-group">
            <label>
                Son Buzağlama Tarihi
            </label>
            <input class="form-control" type="date" name="SON_BUZAGI">
        </div>
    </div>
   
</div>





