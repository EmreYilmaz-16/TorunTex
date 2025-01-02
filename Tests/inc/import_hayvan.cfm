<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=50" enctype="multipart/form-data" >
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 
        <input type="hidden" name="INVOICE_ID" value="<cfoutput>#attributes.INVOICE_ID#</cfoutput>">
        
        
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
  <cfquery name="GETSKIN" datasource="#DSN3#">
    select YEAR(INVOICE_DATE) AS IV_DATE from #dsn2#.INVOICE WHERE  INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>
<script>
    window.opener.document.getElementById("IV_DATE").value='<cfoutput>#GETSKIN.IV_DATE#</cfoutput>'
    window.opener.document.getElementById("INVOICE_ID").value='<cfoutput>#attributes.INVOICE_ID#</cfoutput>'
</script>
<cfoutput query="get_invoice_no">
    <cfquery name="GETSK" datasource="#DSN3#">
        select * from w3Toruntex_1.STOCKS WHERE STOCK_CODE='#col_1#'
    </cfquery>
      <cfquery name="GETSKI" datasource="#DSN3#">
        select * from #dsn2#.INVOICE_ROW WHERE STOCK_ID=#GETSK.STOCK_ID# AND INVOICE_ID=#attributes.INVOICE_ID#
    </cfquery>
    
    <script>
        window.opener.Ekle(#GETSK.PRODUCT_ID#,#GETSK.STOCK_ID#,'#GETSKI.WRK_ROW_ID#','#GETSK.PRODUCT_NAME#','#col_1#','#col_2#',1,1)
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