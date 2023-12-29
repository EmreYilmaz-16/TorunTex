<script>
$(document).ready(function(){
    console.log("Çalıştım")
    console.log(<cfoutput>#attributes.ship_id#</cfoutput>)
    var pt=$("#old_process_type").val()
    if(parseInt(pt)==88){
        $("#tabMenu ul").prepend("<li class='dropdown'><a style='font-weight:bold' onclick='FaturaKesCanim(<cfoutput>#attributes.ship_id#</cfoutput>)'><i class='fa fa-check'></i>Fatura Kes - PBS</a></li>")
    }
})
function FaturaKesCanim(iid) {
    windowopen('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=40&SHIP_ID='+iid)
}
</script>

