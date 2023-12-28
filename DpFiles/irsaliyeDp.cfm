<script>
$(document).ready(function(){
    var pt=$("#old_process_type").val()
    if(parseInt(pt)==88){
        $("#tabMenu ul").prepend("<li class='dropdown'><a onclick='FaturaKesCanim(<cfoutput>#attributes.ship_id#</cfoutput>)'>Fatura Kes - PBS</a></li>")
    }
})
function FaturaKesCanim(iid) {
    windowopen('/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=40&SHIP_ID='+iid)
}
</script>

