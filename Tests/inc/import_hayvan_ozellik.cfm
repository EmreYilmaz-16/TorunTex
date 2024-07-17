<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=52" enctype="multipart/form-data" >
    <div class="row">
        <div class="col col-6">
            <div class="form-group">
                <input type="file" name="file_11" id="file_11">
                <input type="hidden"  name="FileName" id="FileName">                                                 
            </div>
            <input type="submit">
            <input type="hidden" name="is_submit">
        </div>
        <div class="col col-6">
            <b>Excel Formatı</b>
            <table style="width:100%">
                <tr>
                    <th>1. Kolon</th>
                    <td>Küpe No</td>
                </tr>
                <tr>
                    <th>2. Kolon</th>
                    <td>Cinsiyet</td>
                </tr>
                <tr>
                    <th>3. Kolon</th>
                    <td>Doğum Tarihi</td>
                </tr>
                <tr>
                    <th>4. Kolon</th>
                    <td>Tohumlama Tarihi</td>
                </tr>
                <tr>
                    <th>5. Kolon</th>
                    <td>Boğa Küpe No</td>
                </tr>
                <tr>
                    <th>6. Kolon</th>
                    <td>Baba Küpe No</td>
                </tr>
                <tr>
                    <th>7. Kolon</th>
                    <td>Anne Küpe No</td>
                </tr>
                <tr>
                    <th>8. Kolon</th>
                    <td>Ana Süt Verimi /Laktasyon</td>
                </tr>
            </table>
        </div>
    </div>
   
  

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


    <cfloop query="get_invoice_no">
<cftry>
<cfquery name="LookAnimal" datasource="#dsn1#">
            SELECT * FROM CIFTLIK_HAYVANLAR WHERE LOT_NO='#col_1#'
        </cfquery>
        <cfif LookAnimal.recordCount>
            <div class="alert alert-warning">
            <cfoutput>#col_1#</cfoutput> Küpe Numaralı Hayvan Daha Önce İmport Edilmiş
            </div>
        <cfelse>
            <cfquery name="AddAnimal_1" datasource="#dsn1#" result="resb">
                INSERT INTO CIFTLIK_HAYVANLAR (LOT_NO,BIRTH_DATE,COUNTRY,GENDER,F_KIMLIK_NO,A_KIMLIK_NO,B_KIMLIK_NO)
                VALUES (
                    '#col_1#',
                    '#col_3#',
                    'İTHAL',
                    <cfif col_2 eq "Dişi">0<cfelse>1</cfif>,
                    '#col_6#',
                    '#col_7#',
                    '#col_5#'
                )
            </cfquery>
            <cfquery name="AddAnimal_2" datasource="#dsn1#">
                INSERT INTO CIFTLIK_TOHUMLAMA (HAYVAN_ID,TOHUMLAMA_DATE,T_ADET) VALUES(#resb.GENERATEDKEY#,'#col_4#',1)
            </cfquery>
        </cfif>
        <cfcatch>
            <div class="alert alert-warning">
                <cfoutput>#cfcatch.message#</cfoutput>
                <cfdump var="#cfcatch#">
                <cfoutput>#col_1#</cfoutput> Küpe Numaralı Hayvan İmport Edilemedi
                </div>
        </cfcatch>
    </cftry>
    </cfloop>


</cfif>




<script>    
    $('#file_11').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
    </script>
