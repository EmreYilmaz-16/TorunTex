<cfparam name="attributes.is_rafli" default="0">                        <!--------  //BILGI RAFLI KAYITMI YAPILACAK   ------------->
<cfparam name="attributes.is_default_depo" default="0">                 <!--------  //BILGI DEFAULT DEPO VARMI        ------------->
<cfparam name="attributes.default_depo" default="0">                  <!--------  //BILGI DEFAULT DEPOLAR           ------------->
<cfparam name="attributes.is_product_code" default="1">                 <!--------  //BILGI ÜRÜN KODU SORULACAKMI     ------------->
<cfparam name="attributes.product_code_area" default="PRODUCT_CODE_2">  <!--------  //BILGI ÜRÜN KODU ARAMA ALANI     ------------->
<cfparam name="attributes.is_lot_no" default="1">                       <!--------  //BILGI LOT NO SORULACAKMI        ------------->
<!--------  
    //BILGI YUKARIDAKİ PARAMETRELERE GÖRE AŞAĞIDAKİ FORM ŞEKİLLENİR ÜRÜN KODU VE LOT  SORGUSU AYNI ANDA 0 OLAMAZ
    //BILGI ÜRÜN BARKODUNDA YER ALAN ALANIN ÜRÜN KARTINDAKİ HANGİ ALANLA EŞLŞECEĞİNİ BİLMEK İÇİN PRODUCT_CODE_AREA VERİSİ KULLANILIR BU ALAN YOKSA ÜRÜN KODUYLA SAYIM YAPAMAZSINIZ
    //BILGI RAFLI SAYIM YADA RAFSIZ SAYIM YAPILABİLİR
    //BILGI BU SAYFA SADECE SAYIM BELGESİNİ OLUŞTURUR BELGEYİ OLUŞTURDUKTAN SONRA SAYIM İŞLEMLERİNDEN BİRLEŞTİRME  VE STOK FİŞLERİNİN OLUŞTURULMASI AŞAMASI MANUEL YAPILACAKTIR
    //BILGI SAYIM TARİHİ BU GÜNÜN TARİHİ OLARAK DEFAULT OLARAK GELECEKTİR
    //BILGI EĞER DEFAULT DEPO TANIMLANMADIYSA SAYIM DEPOSU SEÇİLEN DEPO OLACAKTIR
    ------------->
<cfoutput>
<script>
var SayimSettings={
    is_rafli:#attributes.is_rafli#,
    is_default_depo:#attributes.is_default_depo#,
    default_depo:'#attributes.default_depo#',
    product_code_area:'#attributes.product_code_area#',
    is_lot_no:#attributes.is_lot_no#,
    is_product_code:#attributes.is_product_code#
}    
</script>
</cfoutput>
<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    
    <cfset attributes.seperator_type = 59><!--- Noktali Virgul Chr --->
<cfset upload_folder = "#upload_folder#store#dir_seperator#">

<cfscript>
	CRLF=chr(13)&chr(10);
	barcode_list = ArrayNew(1);
	for(row_i=1;row_i lte attributes.row_count;row_i=row_i+1)
		
         
                ArrayAppend(barcode_list,"#evaluate('attributes.PRODUCT_CODE#row_i#')#;#evaluate('attributes.AMOUNT#row_i#')#;#evaluate('attributes.LOT_NO#row_i#')#");
         </cfscript>
         <cfdump var="#ArrayToList(barcode_list,CRLF)#">
<cfset file_name = "#createUUID()#.txt">
<cffile action="write" output="#ArrayToList(barcode_list,CRLF)#" file="#upload_folder##file_name#" addnewline="yes" charset="iso-8859-9">
<cfdirectory directory="#upload_folder#" name="folder_info" sort="datelastmodified" filter="#file_name#">
<cfset file_name = folder_info.name>
<cfset file_size = folder_info.size>
<cfset form.store = attributes.txt_department_in>
<cfset attributes.department_id = ListGetAt(attributes.txt_department_in,1,'-')>
<cfset attributes.location_id = ListGetAt(attributes.txt_department_in,2,'-')>
<cfset attributes.process_date = Dateformat(now(),'dd/mm/yyyy')>
<cfset attributes.stock_identity_type = 2><!--- Tip Barkod --->

    <CFSET attributes.add_file_format_1="LOT_NO">
    <CFSET attributes.add_file_format_2="">

<CFSET attributes.add_file_format_3="">
<CFSET attributes.add_file_format_4="">
<cf_date tarih='attributes.process_date'>
    <cfset get_stock_date = date_add("h",23,attributes.process_date)>
    <cfset get_stock_date = date_add("n",59,get_stock_date)>
    <cfset count_product_problem=0>    
<cfinclude template="import_stock_count_display.cfm">
<!----<cfinclude template="import_stock_count_display.cfm">
<script type="text/javascript">
	<cfif not isdefined('error_flag')>
		alert('Sayım dosyanız başarıyla oluşturulmuştur !');
	</cfif>
	window.location.href = '<cfoutput>#request.self#?fuseaction=epda.prtotm_raf_sayim</cfoutput>';
</script>----->
    <cfabort>
</cfif>

<cfparam name="attributes.product_code_area" default="PRODUCT_CODE_2">  <!--------  //BILGI ÜRÜN KODU ARAMA ALANI     ------------->
<cf_box title="Sayim">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>Depo - Lokasyon</label>
                    <cfquery name="GETSL" datasource="#DSN#">
                        SELECT D.DEPARTMENT_ID,SL.LOCATION_ID,D.DEPARTMENT_HEAD,SL.COMMENT FROM STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID ORDER BY D.DEPARTMENT_ID
                    </cfquery>
                    <select name="DEPOLAMA" id="DEPOLAMA" onchange="setDept(this)">
                        <cfoutput query="GETSL" group="DEPARTMENT_ID">
                            <optgroup label="#DEPARTMENT_HEAD#">
                            <cfoutput><option value="#DEPARTMENT_ID#-#LOCATION_ID#">#COMMENT#</option></cfoutput>                                                                        
                            </optgroup>
                        </cfoutput>
                    </select>                             
            </td>
            <td>
                <div class="form-group">
                    <label>Ürün Kodu</label>
                    <input type="text" name="PRODUCT_CODE" id="PRODUCT_CODE"  placeholder="Ürün Kodu" onkeyup="getProduct(this,event,'<cfoutput>#attributes.product_code_area#</cfoutput>')">
                </div>
            </td>
            <td>
                <input type="button" class="btn" onclick="$('#frm1').submit()" value="Kaydet">
            </td>
        </tr>
    </table>
    <cfform id="frm1" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=39">
        <cf_big_list >
            <tr>
                <th>
                    Lot No
                </th>
                <th>
                    Ürün
                </th>         
                <th>
                    Miktar
                </th>
            </tr>
        <tbody id="SayimTable">
        
        </tbody>
        </cf_big_list>
        <input type="hidden" name="is_submit" value="1">
        <input type="hidden" name="row_count" id="RC" value="">
        <input type="hidden" name="TXT_DEPARTMENT_IN" id="TXT_DEPARTMENT_IN" value="">
        <input type="hidden" name="is_default_depo" id="is_default_depo" value="">
        <input type="hidden" name="is_rafli" id="is_rafli" value="">
        </cfform>
</cf_box>

<script src="/AddOns/Partner/js/sayim_2.js"></script>Partner\Tests\inc\sayim_2.cfm