


<cf_box title="PDA Welcome">
<div style="display: flex;flex-direction: column;">
    <button style="margin-top:5px" class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=1'">Raftan Çuval Al</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=6'">Raf Durumu</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=8'">Operator Ekrani</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=9'">Operator Ekrani</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=13'">Çuval Taşı</button>
    <cfif isDefined("attributes.ymcik")>
        <button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=4'">Yarı Mamül Çıkış </button>
        <button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=5'">Masa Çıkış </button>
    </cfif>
    <cfif session.ep.userid eq 144>


    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=git'">Git Pull</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=vt'">VT Sorgu</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=ex'">EX</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=Pu'">Import Units</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=fe'">Dosya Gezgini</button>
    </cfif>
</div>
</cf_box>

<cf_pbs_barcode format="jpg" type="code128" value="EMRE|EMREEEE||EMREEEEEE" show="1"  height="50">
<cf_workcube_barcode type="code128" value="EMRE|EMREEEE||EMREEEEEE"  show="1"  height="50">
    <script src="/AddOns/Partner/js/qrcode.js"></script>
    <div id="qrcode" style="text-align:-webkit-center"></div>
    <div id="qrvalue" style="visibility: hidden;display:none">EMRE|EMREEEE||EMREEEEEE</div>
    <script type="text/javascript">
        var qrcode = new
        QRCode(document.getElementById("qrcode"), {
        width:175,
        height : 175
        });

        function makeCode (msg) {
        var elText = document.getElementById("text");
        qrcode.makeCode(msg);
        }
        makeCode(document.getElementById("qrvalue").innerHTML);
    </script>

