﻿


<cf_box title="PDA Welcome">
<div style="display: flex;flex-direction: column;">
    <button style="margin-top:5px" class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=1','_blank')">Raftan Çuval Al</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=6')">Raf Durumu</button>
    
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=9','_blank')">Operator Ekrani</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=9_2','_blank')">Operator Ekrani V2</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=9_3','_blank')">Operator Ekrani V3</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=13','_blank')">Çuval Taşı</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=31','_blank')">Çuval Taşı V2</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=15','_blank')">Lot Hareketleri</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=22','_blank')">Sevkiyat İşlemleri</button>
    <button style="margin-top:5px"  class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=25','_blank')">Sevkiyat Listesi</button>
    <cfif isDefined("attributes.ymcik")>
        <button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=4','_blank')">Yarı Mamül Çıkış </button>
        <button style="margin-top:5px"   class="btn btn-outline-primary" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=5','_blank')">Masa Çıkış </button>
    </cfif>
    <cfif listfind("1,2,144,145,146",session.ep.userid)>
        <button style="margin-top:5px"  class="btn btn-outline-warning" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=20','_blank')">Yazıcı Ekle</button>
        <button style="margin-top:5px"  class="btn btn-outline-warning" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=26','_blank')">Sayım</button>
    </cfif>
    <cfif session.ep.userid eq 144>


    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=git','_blank')">Git Pull</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=vt','_blank')">VT Sorgu</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=ex','_blank')">EX</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=Pu','_blank')">Import Units</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=fe','_blank')">Dosya Gezgini</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=fis_sil','_blank')">Fişlerin Tamamını Sil</button>
    <button style="margin-top:5px"  class="btn btn-outline-danger" onclick="window.open('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=28','_blank')">FTEST</button>
    </cfif>
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