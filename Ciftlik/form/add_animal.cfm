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
            <label><input type="radio" name="CINSIYET" value="1"> Erkek</label>
            <label><input type="radio" name="CINSIYET" value="0"> Dişi</label>
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
    </div>
</div>





