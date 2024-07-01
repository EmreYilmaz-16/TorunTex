<cfset AnimalService = createObject("component","AddOns.Partner.Ciftlik.cfc.animal.cfc")>
    <cfset Ciflikler=AnimalService.GetCiftliks()>
    <cfset Padoklar=AnimalService.getPadok()>
    <cfset AnimalTypes=AnimalService.getHayvanTip()>


<cfdump var="#AnimalTypes#">