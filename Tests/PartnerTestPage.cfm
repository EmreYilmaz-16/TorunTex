<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<cfif attributes.sayfa eq "git"><cfinclude template="inc/git_puller.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq -1><cfinclude template="inc/Welcome.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 1><cfinclude template="inc/RafToElleForm.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 2><cfinclude template="inc/RafToElleList.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 3><cfinclude template="inc/RafToEllePopup.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 4><cfinclude template="inc/EllecToYM.cfm"><cfabort></cfif>


<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>