<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=50" enctype="multipart/form-data" >
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 
        <input type="hidden" name="INVOICE_ID" value="<cfoutput>#attributes.INVOICE_ID#</cfoutput>">
        <input type="hidden" name="IV_DATE" value="<cfoutput>#attributes.IV_DATE#</cfoutput>">
        
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
    <cfquery name="GETSK" datasource="#DSN3#">
        select * from w3Toruntex_1.STOCKS WHERE STOCK_CODE='#col_1#'
    </cfquery>
      <cfquery name="GETSKI" datasource="#DSN3#">
        select * from w3Toruntex_2024_1.INVOICE_ROW WHERE STOCK_ID=#GETSK.STOCK_ID# AND INVOICE_ID=#attributes.INVOICE_ID#
    </cfquery>
    <script>
        window.opener.SatirEkle(#attributes.INVOICE_ID#,#GETSK.STOCK_ID#,#GETSK.PRODUCT_ID#,'#GETSKI.WRK_ROW_ID#',1,1,0,'#GETSK.PRODUCT_NAME#','#col_1#','#col_2#','#attributes.IV_DATE#')
    </script>

</cfoutput>


</cfif>


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