


<cf_box title="PDA Welcome">
<div style="display: flex;flex-direction: column;">
    <button style="margin-top:5px" class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=1'">Raftan Çuval Al</button>
    <button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=4'">Yarı Mamül Çıkış </button>
    <button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=5'">Masa Çıkış </button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=6'">Raf Durumu</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=8'">Operator Ekrani</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=9'">Operator Ekrani</button>
    <cfif session.ep.userid eq 144>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=git'">Git Pull</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=vt'">VT Sorgu</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=ex'">EX</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=Pu'">Import Units</button>
    </cfif>
</div>
</cf_box>
Merhaba