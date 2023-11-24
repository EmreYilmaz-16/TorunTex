<cfparam name="attributes.sayfa" default="-1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<cfif attributes.sayfa eq "vt"><cfinclude template="inc/VtSorgu.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq "git"><cfinclude template="inc/git_puller.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq "ex"><cfinclude template="inc/ExCellAktar.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq "pu"><cfinclude template="inc/importProductUnit.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq "fe"><cfinclude template="../Admin/folder_explorer.cfm"><cfabort></cfif>


<cfif attributes.sayfa eq -1><cfinclude template="inc/Welcome.cfm"><cfabort></cfif>


<cfif attributes.sayfa eq 1><cfinclude template="inc/RafToElleForm.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 2><cfinclude template="inc/RafToElleList.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 3><cfinclude template="inc/RafToEllePopup.cfm"><cfabort></cfif>
<!---
<cfif attributes.sayfa eq 4><cfinclude template="inc/EllecToYM.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 5><cfinclude template="inc/MasaSevk.cfm"><cfabort></cfif>---->
<cfif attributes.sayfa eq 6><cfinclude template="inc/rafDurumu.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 7><cfinclude template="inc/MasaGonderPopup.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 8><cfinclude template="inc/OperatorEkrani.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 9><cfinclude template="inc/OperatorEkrani_2.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 10><cfinclude template="inc/logInEmployee.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 11><cfinclude template="inc/istasyonUretim.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 12><cfinclude template="inc/digerSiparis.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 13><cfinclude template="inc/CuvalTasi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 14><cfinclude template="inc/CuvalTasiQuery.cfm"><cfabort></cfif>



<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>