


<cf_box title="PDA Welcome">
<div style="display: flex;flex-direction: column;">
    <button style="margin-top:5px" class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=1'">Raftan Çuval Al</button>
<button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=4'">Yarı Mamül Çıkış </button>
<button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=5'">Raf Durumu</button>
<cfif session.ep.userid eq 144>
<button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=git'">Git Pull</button>
</cfif>
</div>
</cf_box>