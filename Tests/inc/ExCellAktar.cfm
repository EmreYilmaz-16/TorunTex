<!---
<cfquery name="Sq" datasource="#DSN#">
    select * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA='w3Toruntex_2024_2'
</cfquery>
<cfoutput query="sq">
<cfquery name="d" datasource="#dsn#">
    <CFIF TABLE_TYPE eq 'VIEW'>
        DROP VIEW w3Toruntex_2024_2.#TABLE_NAME#
        <CFELSE>
            DROP TABLE w3Toruntex_2024_2.#TABLE_NAME#
    </CFIF>
</cfquery>
</cfoutput>

<cfabort>
---->
<cfform method="post"  enctype="multipart/form-data" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=ex">
    <input type="file" name="file_11" id="file_11">
    <input type="hidden"  name="FileName" id="FileName">
    <input type="hidden"  name="is_submitted" id="is_submitted">
    <input type="submit">
</cfform>

<cfif isdefined("attributes.is_submitted")> 
	<cfif isDefined("attributes.FileName") and len(attributes.FileName)>
		<cffile action = "upload" fileField = "file_11" destination = "#expandPath("./ExDosyalar")#"  nameConflict = "Overwrite" result="resul"> 	
	    <cfspreadsheet  action="read" src = "#expandPath("./ExDosyalar/#attributes.fileName#")#" query = "res">	
	    <cfquery name = "get_invoice_no" dbtype = "query">
		    SELECT DISTINCT
			    col_1,
			    col_2, 
			    col_3
          
		    FROM
			    res     
	    </cfquery>
        <cfloop query="get_invoice_no">
        <cfquery name="getMainProduct" datasource="#dsn3#">
            SELECT PRODUCT_ID FROM STOCKS WHERE PRODUCT_NAME='#col_1#'
        </cfquery>
        <cfif getMainProduct.recordCount eq 0>
            Ürün Bulunamadı <cfoutput>#col_1#</cfoutput> <br>
        <cfelse>
            <cfloop from="2" to="3" index="i">
            <cfset ColData=evaluate("get_invoice_no.col_#i#")>
            <cfquery name="getInsProduct" datasource="#dsn3#">
                SELECT PRODUCT_ID FROM STOCKS WHERE PRODUCT_NAME='#ColData#'
            </cfquery>
            <cfif getInsProduct.recordCount>
                <cfquery name="Ins" datasource="#dsn3#">
                    INSERT INTO #dsn3#.RELATED_PRODUCT ( PRODUCT_ID,RELATED_PRODUCT_ID,RELATED_PRODUCT_NO) 
                    VALUES (#getMainProduct.PRODUCT_ID#,#getInsProduct.PRODUCT_ID#,#i#)
                </cfquery>
            <cfelse>
                Ürün Bulunamadı <cfoutput>#ColData#</cfoutput> <br>        
            </cfif>
            
        </cfloop>    
    </cfif>
    </cfloop>
    </cfif>
    
</cfif>

<script>
    $('#file_11').change(function(e){
        var fileName = e. target. files[0]. name;
        $("#FileName").val(fileName)
    });
</script>
