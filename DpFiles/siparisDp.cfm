<script>
    $(document).on('ready',function(){
    var fatid=getParameterByName('order_id');
    var btn=document.createElement("span")
    btn.setAttribute("class","input-group-addon btnPointer icon-ellipsis")
    btn.setAttribute("style","background:#6a6a6a;color:white")
    btn.setAttribute("onclick","pencereac(1,"+fatid+")")
    $(document.getElementById("item-deliver_dept_name")).find(".input-group")[0].appendChild(btn)

    
    })
    
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
    function pencereac(tip,idd){
        if(tip==2){
        windowopen('index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&ACTION_ID='+idd,'wide');}else if(tip==1){
            openBoxDraggable('index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=19');
        }else if(tip==3){
             windowopen('index.cfm?fuseaction=objects.popup_print_files_old&action=sales.list_order&action_id='+idd+'&print_type=73','wide');
        }else if(tip==4){
            windowopen('index.cfm?fuseaction=objects.popup_rekactions_prt&action=ORDER&action_id='+idd,'wide');
        }
    }
    ///objects.popup_rekactions_prt
    </script>