<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=59" enctype="multipart/form-data" >
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 

        
        
    </div>
  
<input type="submit">
<input type="hidden" name="is_submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cffile action = "upload"
    fileField = "file_11"
    destination = "#expandPath("./ExDosyalar")#" 
    nameConflict = "Overwrite" result="resul"> 

    <cfspreadsheet  action="read" src = "#expandPath("./ExDosyalar/#attributes.fileName#")#" query = "res">

    <cfquery name = "get_invoice_no" dbtype = "query" result="ressa">
        SELECT * FROM res     
    </cfquery>   


<cfoutput query="get_invoice_no">

    
    <script>
        window.opener.islemYap_LOT('#col_1#');
    </script>

</cfoutput>


</cfif>

<script>    
    $('#file_11').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
    </script>

STOCK_ID, 
PRODUCT_ID,
WRK_ROW_ID,
MIKTAR, "1"
MIKTAR2,
KALAN2,
PRODUCT_NAME,
PRODUCT_CODE,
LOT_NO,
IV_DATE
function Ekle(
  PRODUCT_ID,
  STOCK_ID,
  WRK_ROW_ID,
  PRODUCT_NAME,
  PRODUCT_CODE,
  LOT_NO,
  MIKTAR,
  MIKTAR2
)
function SatirEkle(
  INVOICE_ID,
  STOCK_ID,
  PRODUCT_ID,
  WRK_ROW_ID,
  MIKTAR,
  MIKTAR2,
  KALAN2,
  PRODUCT_NAME,
  PRODUCT_CODE,
  LOT_NO,
  IV_DATE
) 