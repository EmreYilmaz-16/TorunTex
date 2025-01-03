<cf_box title="Stok Raporu">
<cfform name="stok_form" id="stok_form" method="post" action="index.cfm?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#" onsubmit="return false;">
<input type="hidden" name="is_submit" value="1">
    <table>
        <tr>
            <td>
                <div class="form-group" id="item-product_id">
                    <label >Ürün </label>						
                    <div>
                        <div class="input-group">
                            <input type="hidden" name="product_id" id="product_id">
                            <input name="product_name" type="text" id="product_name" placeholder="Ürün " onfocus="AutoComplete_Create('product_name','PRODUCT_NAME','PRODUCT_NAME','get_product','0','PRODUCT_ID','product_id','','3','100');" value="" autocomplete="off" style=""><div id="product_name_div_2" name="product_name_div_2" class="completeListbox" autocomplete="on" style="width: 772px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 337.5px; z-index: 159; display: none;"></div>
                            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_product_names&product_id=stok_form.product_id&field_name=stok_form.product_name&keyword='+encodeURIComponent(document.stok_form.product_name.value));"></span>
                        </div>
                    </div>
                </div>
            </td>
            <td>
                <div class="form-group" id="item-list_type">
                    <label>Stok Bazında</label>
                    <select name="list_type" style="widows:100px;" id="list_type" onchange="show_shelf();">
                        <option value="1" selected="">Stok Bazında </option>                     
                        <option value="5">Lot Bazında</option>
                    </select>
                </div>
            </td>
            <td>
                <div class="form-group" id="item-amount_flag">
                    <label>Stok Durumu </label>
                    <select name="amount_flag" id="amount_flag" onchange="show_strategy_type();">
                        <option value="" selected="">Stok Durumu </option>
                        <option value="3">Sıfır Stok </option>
                        <option value="0">Negatif Stok </option>
                        <option value="1">Pozitif Stok </option>
                        
                    </select>
                </div>
            </td>
            
            <td>
                <div class="form-group" id="item-department_id">
                    <label>Depo </label>
                    

<link href="../../JS/temp/scroll/jquery.mCustomScrollbar.css" rel="stylesheet">
<script src="../../JS/temp/scroll/jquery.mCustomScrollbar.concat.min.js"></script>
<input name="branch_id" type="hidden" id="branch_id" value=""><input name="department_id" type="hidden" id="department_id" value=""><input name="location_id" type="hidden" id="location_id" value="">
<div class="ui-cfmodal" id="wrkDepartmentLocationDiv_location_name"></div>
<div class="input-group">
<input type="text" placeholder="Depo " name="location_name" id="location_name" autocomplete="off" onblur="compenentInputValueEmptyinglocation_1(this);" value="" onkeypress="if(event.keyCode==13) {compenentAutoCompletelocation_1(this,'wrkDepartmentLocationDiv_location_name','&RETURNQUERYVALUE=LOCATION_NAME,DEPARTMENT_ID,LOCATION_ID,BRANCH_ID&FIELDID=location_id&BOXHEIGHT=200&WIDTH=120&LISTPAGE=0&JS_PAGE=0&IS_DEPARTMENT=1&UPDPAGEURL=project.prodetail█id=&IS_STORE_MODULE=0&LINE_INFO=1&RETURNINPUTVALUE=location_name,department_id,location_id,branch_id&STATUS=1&USER_LEVEL_CONTROL=1&DEPARTMENT_FLDID=department_id&COMPENENT_NAME=get_department_location&FIELDNAME=location_name&IS_SUBMIT=0&BRANCH_FLDID=branch_id&BOXWIDTH=250&CALL_FUNCTION=1&IS_STORE_KONTROL=1&RETURNQUERYVALUE2=DEPARTMENT_ID,DEPARTMENT_HEAD&ADDPAGEURL=project.addpro&USER_LOCATION=1&TITLE=Depo - Lokasyon&columnList=LOCATION_NAME@Lokasyon,'); return false;}"> 
<span class="input-group-addon btnPointer icon-ellipsis" id="plus_this_department" name="plus_this_department" title="Depo - Lokasyon " onclick="if(1){compenentAutoCompletelocation_1('','wrkDepartmentLocationDiv_location_name','&RETURNQUERYVALUE=LOCATION_NAME,DEPARTMENT_ID,LOCATION_ID,BRANCH_ID&FIELDID=location_id&BOXHEIGHT=200&WIDTH=120&LISTPAGE=0&JS_PAGE=0&IS_DEPARTMENT=1&UPDPAGEURL=project.prodetail█id=&IS_STORE_MODULE=0&LINE_INFO=1&RETURNINPUTVALUE=location_name,department_id,location_id,branch_id&STATUS=1&USER_LEVEL_CONTROL=1&DEPARTMENT_FLDID=department_id&COMPENENT_NAME=get_department_location&FIELDNAME=location_name&IS_SUBMIT=0&BRANCH_FLDID=branch_id&BOXWIDTH=250&CALL_FUNCTION=1&IS_STORE_KONTROL=1&RETURNQUERYVALUE2=DEPARTMENT_ID,DEPARTMENT_HEAD&ADDPAGEURL=project.addpro&USER_LOCATION=1&TITLE=Depo - Lokasyon&columnList=LOCATION_NAME@Lokasyon,')};"></span>
</div>
<script type="text/javascript">
function compenentAutoCompletelocation_1(object_,div_id,comp_url){
    other_parameters = 'is_delivery§/location_type§/sistem_company_id§/is_ingroup§/user_level_control§1/is_store_module§0/xml_all_depo§/status§1';//alt+789=§ ve alt+987=█ 

     var keyword_ =(!object_)?'':object_.value;
     if(keyword_.length < 3 && object_ != ""){
        alert("En az 3 karakter giriniz.");
        return false;}
     else{
        document.getElementById(div_id).style.display='';
        if(keyword_ == '')
        keyword_ = "0";
        openBoxDraggable('index.cfm?fuseaction=objects.popup_wrk_list_comp&keyword='+keyword_+comp_url+'&comp_div_id=wrkDepartmentLocationDiv_location_name&other_parameters='+other_parameters);
        return false;	
     }
     return false;	
}
function compenentInputValueEmptyinglocation_1(object_)
{
    var keyword_ = object_.value;
    if(keyword_.length == 0)
    {
        
            document.getElementById('location_name').value ='';
        
            document.getElementById('department_id').value ='';
        
            document.getElementById('location_id').value ='';
        
            document.getElementById('branch_id').value ='';
            
    }
}
</script>
                </div>
            </td>
            <td>
                <input type="submit">
            </td>
        </tr>
    </table>
</cfform>
<cfif isDefined("attributes.is_submit")>
    <cfdumpvar var="#form#">
</cfif>

</cf_box>
