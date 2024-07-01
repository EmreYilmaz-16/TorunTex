<cfset AnimalService = createObject("component","AddOns.Partner.Ciftlik.cfc.animal")>
    <cfset Ciflikler=AnimalService.GetCiftliks()>
    <cfset Padoklar=AnimalService.getPadok()>
    <cfset _AnimalTypes=AnimalService.getHayvanTip()>
<cfset AnimalTypes=deserializeJSON(_AnimalTypes)>
<div class="row">
    <div class="col col-6">
        <div class="form-group">
            <label>
                Kulak Küpe Numarası
            </label>
            <input type="text" name="LOT_NO">
        </div>
        <div class="form-group">
            <label>
                Doğum Tarihi
            </label>
            <input type="date" name="DOGUM_TARIHI">
        </div>
        <div class="form-group">
            <label>
                Cinsiyet
            </label>
            <label><input type="radio" name="CINSIYET" value="1"> Erkek</label>
            <label><input type="radio" name="CINSIYET" value="0"> Dişi</label>
        </div>
    </div>
    <div class="col col-6">
        <div class="form-group">
            <label>
                Kimlik Numarası
            </label>
            <input type="text" name="KIMLIK_NO">
        </div>
        <div class="form-group">
            <label>
                Ülke
            </label>
            <input type="text" name="ULKE">
        </div>
        <div class="form-group">
            <label>
                Cins
            </label>
            <select name="CINS">
                <cfloop array="#AnimalTypes#" item="it">
                    <optgroup label="<cfoutput>#PRODUCT_NAME#</cfoutput>">
                        <cfloop array="#it.TYPES#" item="it2">
                            <option value="<cfoutput>#STOCK_ID#</cfoutput>"><cfoutput>#PROPERTY#</cfoutput></option>
                        </cfloop>
                    </optgroup>
                </cfloop>
            </select>
        </div>
    </div>
</div>





