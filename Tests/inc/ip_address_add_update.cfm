<cfparam name="IID" default="0">
<cfquery name="GetIpa" datasource="#dsn#">
    SELECT SPR.*,SL.COMMENT,D.DEPARTMENT_HEAD FROM STATION_PRINTER_RELATION_PBS AS SPR 
    LEFT JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID =SPR.STORE_ID
    LEFT JOIN STOCKS_LOCATION AS SL ON SL.LOCATION_ID =SPR.LOCATION_ID AND SL.DEPARTMENT_ID=D.DEPARTMENT_ID 
    WHERE SPR.ID=#attributes.IID#
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#">
    <cfoutput query="GetIpa">
    <input type="hidden" name="IID" value="#ID#">
    <input type="text" name="PRINTER_NAME" value="#PRINTER_NAME#">
    <div class="form-group">
        <input type="hidden" name="STORE_ID" id="deliver_dept_id" value="#STORE_ID#">
        <input type="hidden" name="LOCATION_ID" id="deliver_loc_id" value="#LOCATION_ID#">
        <input type="hidden"  id="branch_id" >
    
    <div class="input-group">
        <input type="text" name="ISTASYON" id="deliver_dept_name" value="#PRINTER_NAME#">
        <span class="input-group-addon btnPointer icon-ellipsis" style="background:#6a6a6a;color:white" onclick="pencereac(1,null)"></span>
    </div>
</div>
</cfoutput>
</cfform>
<script>
   function pencereac(tip,idd){
        if(tip==2){
        windowopen('index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&ACTION_ID='+idd,'wide');}else if(tip==1){
            openBoxDraggable('index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=19&all=1');
        }else if(tip==3){
             windowopen('index.cfm?fuseaction=objects.popup_print_files_old&action=sales.list_order&action_id='+idd+'&print_type=73','wide');
        }else if(tip==4){
            windowopen('index.cfm?fuseaction=objects.popup_rekactions_prt&action=ORDER&action_id='+idd,'wide');
        }
    }
</script>