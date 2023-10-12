<cfif attributes.sayfa eq "git"><cfinclude template="inc/git_puller.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq -1><cfinclude template="inc/Welcome.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 1><cfinclude template="inc/RafToElleForm.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 2><cfinclude template="inc/RafToElleList.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 3><cfinclude template="inc/RafToEllePopup.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 4><cfinclude template="inc/EllecToYM.cfm"><cfabort></cfif>

