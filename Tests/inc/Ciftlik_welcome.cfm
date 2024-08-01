<title>Çiftlik Welcome</title>


<cf_box title="Çiftlik Welcome">
    <div style="display: flex;flex-direction: column;">
  
       
    
    
        <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=53','_blank')">Canlı Hayvan Listesi</button>
        <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=48','_blank')">Canlı Hayvan Ekle</button>
        <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=49','_blank')">Canlı Hayvan İthal Mal Girişi</button>
        <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="windowopen('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=52','wide')">Canlı Hayvan Özellik İmport</button>
        <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="windowopen('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=55','wide')">Canlı Hayvan Sevkiyat</button>
        <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="openBoxDraggable('index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=60','wide')">Canlı Hayvan Toplu Giriş</button>
       
    </div>
    </cf_box>
    <!----
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
    
    ------>