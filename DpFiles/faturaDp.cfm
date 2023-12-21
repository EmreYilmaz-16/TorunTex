<script>
$(document).on('ready',function(){
var fatid=getParameterByName('iid');
var elem=document.getElementsByClassName("detailHeadButton")
$(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:#0489c7' title='Kullanılan Beyannameler' onclick='pencereac(1,"+fatid+")'><i class='icon-exchange'></i></a></li>")

})

function pencereac(tip,iid) {
    if(tip==1){
        windowopen("/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=32&INVOICE_ID="+iid)
    }
}


    function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
</script>