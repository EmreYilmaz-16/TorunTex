<cfdump var="#attributes#">
<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
    <cfquery name="AddUpd" datasource="#DSN#" result="RES">
        <cfif len(attributes.ID) and attributes.ID neq 0>
            UPDATE STATION_PRINTER_RELATION_PBS SET (PRINTER_NAME='#attributes.PRINTER_NAME#',IP_ADDRESS='#attributes.IP_ADDRESS#',STORE_ID=#attributes.STORE_ID#,LOCATION_ID=#attributes.LOCATION_ID#) WHERE ID=#attributes.ID#
        <cfelse>
            INSERT INTO STATION_PRINTER_RELATION_PBS (PRINTER_NAME,IP_ADDRESS,STORE_ID,LOCATION_ID) VALUES ('#attributes.PRINTER_NAME#','#attributes.IP_ADDRESS#',#attributes.STORE_ID#,#attributes.LOCATION_ID#)
        </cfif>
    </cfquery>
    <CFIF LEN(attributes.ID) AND attributes.ID NEQ 0>
        <CFSET attributes.IID=attributes.ID>
    <CFELSE>
        <CFSET attributes.IID=RES.GENERATEDKEY>
    </CFIF>
<cfelse>
<cfdump var="#attributes#">
</cfif>
<cf_box title="Yazıcı Ekle">
<cfparam name="IID" default="0">
<cfquery name="GetIpa" datasource="#dsn#">
    SELECT SPR.*,SL.COMMENT,D.DEPARTMENT_HEAD FROM STATION_PRINTER_RELATION_PBS AS SPR 
    LEFT JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID =SPR.STORE_ID
    LEFT JOIN STOCKS_LOCATION AS SL ON SL.LOCATION_ID =SPR.LOCATION_ID AND SL.DEPARTMENT_ID=D.DEPARTMENT_ID 
    WHERE SPR.ID=#attributes.IID#
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#" id="frm1">
    <cfoutput query="GetIpa">
    <input type="hidden" name="ID" value="#ID#">
    <input type="hidden" name="is_submit" value="1">
    <div class="form-group">
        <label>Yazıcı Adı</label>
        <input class="form-control" type="text" name="PRINTER_NAME" value="#PRINTER_NAME#">
    </div>
    <div class="form-group">
        <label>İp Adresi</label>
        <input class="form-control" type="text" name="IP_ADDRESS" value="#IP_ADDRESS#">
    </div>
    <div class="form-group">
        <label>Depo</label>
        <input type="hidden" name="STORE_ID" id="deliver_dept_id" value="#STORE_ID#">
        <input type="hidden" name="LOCATION_ID" id="deliver_loc_id" value="#LOCATION_ID#">
        <input type="hidden"  id="branch_id" >    
    <div class="input-group">
        <input class="form-control" type="text" name="ISTASYON" id="deliver_dept_name" value="#DEPARTMENT_HEAD#-#COMMENT# ">
        <button type="button" class="input-group-text" style="background:##6a6a6a;color:white;padding: 0px 13px 0px 13px;" onclick="pencereac(1,null)"><i class="icon-ellipsis"></i></button>
    </div>
</div>
<button type="button" class="btn btn-success" onclick="$('##frm1').submit()">Kaydet</button>
<button type="button" class="btn btn-danger" onclick="">Sil</button>
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
    function sil(){
        $('#is_submit').val(2)
        $('#frm1').submit()
    }
</script>
</cf_box>