<cfset AnimalService = createObject("component","AddOns.Partner.Ciftlik.cfc.animal")>
    <cfset Ciflikler=AnimalService.GetCiftliks()>
    <cfset Padoklar=AnimalService.getPadok()>
    <cfset AnimalTypes=AnimalService.getHayvanTip()>


<div class="form-group">
    <label>
        Kulak Küpe Numarası
    </label>
    <input type="text" name="LOT_NO">
</div>
<div class="form-group">
    <label>
        Kimlik Numarası
    </label>
    <input type="text" name="KIMLIK_NO">
</div>
<div class="form-group">
    <label>
        Doğum Tarihi
    </label>
    <input type="date" name="DOGUM_TARIHI">
</div>
<div class="form-group">
    <label>
        Ülke
    </label>
    <input type="text" name="KIMLIK_NO">
</div>
<div class="form-group">
    <label>
        Cinsiyet
    </label>
    <label><input type="radio" name="CINSIYET" value="1"> Erkek</label>
    <label><input type="radio" name="CINSIYET" value="0"> Dişi</label>
</div>