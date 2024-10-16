<cfparam name="attributes.DosyaAd" default="" />
<cfparam name="product_cat_id" default="">
<cfparam name="PRODUCT_CATID" default="">
<cfparam name="PRODUCT_CAT" default="">
<cfparam name="is_show_detail_variation" default="1">
<cfdirectory action="list" directory="#expandPath("./#attributes.DosyaAd#")#" recurse="false" name="myLists">
<cfset myList=directoryList(expandPath("./#attributes.DosyaAd#"),false,"query","","type asc")>

<!---<cfdump var="#myLists#">
<cfdump var="#expandPath(".")#">
<cfdump var="#application#">---->
<style>
	.td1{ pading:20px; } .ASFGH{ height: 85vh; width: 500px; overflow-y: scroll; } 
</style>

<table style="width:100%">
	<tr>
		<td>
			<div class="ASFGH" >
        <cf_box height="100vh">
			<cf_ajax_list >
				<tr>
					<td>
						Dosya Adı 
					</td>
				</tr>
				<cfif listlen(attributes.DosyaAd,"/") gt 0>
					<cfset  a=listDeleteAt(attributes.DosyaAd, ListLen(attributes.DosyaAd,"/"), "/")>
					<cfoutput>
						<tr>
							<td>
								<a class="tableyazi" href="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=fe&DosyaAd=#a#">
									<img src="/img/foldero.png" width="30" height="30" />
									Ust Klasor 
								</a>
							</td>
						</tr>
					</cfoutput>
				</cfif>
				<cfoutput query="myList">
                    <cfset f_info=GetFileInfo("#directory#\#name#")>
               <!---   <cfdump var="#f_info#">---->
					<tr>
						<td valign="top" style="vertical-align:top">
							<div style="vertical-align:top">
								<cfif attributes.DosyaAd neq "">																	
                                    <cfset ace = "">
                                    <cfif type neq "Dir">
                                        <cfset ace=listLast(Name,".")>
										<a href="/#request.self#?fuseaction=#attributes.fuseaction#&sayfa=fe&DosyaAd=#attributes.DosyaAd#&download_file=#replace(replace(f_info.path,"#expandPath(".")#",""),"//","//")#" > <span class="kopkop"><img src="/img/#ace#.png" width="30" height="30" />#Name# </span></a>
                                    <cfelse>
                                    <a class="tableyazi" href="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=fe&DosyaAd=#attributes.DosyaAd#/#Name#"><img src="/img/folder.png" width="30" height="30" />#Name#</a>
                                    </cfif>																
								<cfelse>									
                                    <cfif type neq "Dir">
											<cfset ace=listLast(Name, ".")>

										<a href="#replace(replace(f_info.path,"#expandPath(".")#",""),"//","//")#" download>	<span class="kopkop"><img src="/img/#ace#.png" width="30" height="30" />#Name#</span></a>
										<cfelse>
                                        <a href="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=fe&DosyaAd=#Name#"><img src="/img/folder.png" width="30" height="30" />#Name#</a>
										</cfif>							
								</cfif>
						</td>
					</tr>
				</cfoutput>
			</table>
			</div> 
		</td>
    <cfif isDefined("attributes.download_file")>
      <cfzip action="zip" file="#expandPath('./#attributes.DosyaAd#/dwn.zip')#" overwrite="yes" >
        <cfzipparam  source="#expandPath('./#attributes.download_file#')#">
        </cfzip>
          <cfcontent deleteFile="true" file="#expandPath('./#attributes.DosyaAd#/dwn.zip')#" type="application/x-zip-compressed" >
          <cfheader name = "Content-disposition" value = 'attachment; filename="#expandPath('./#attributes.DosyaAd#/dwn.zip')#"'>
    </cfif>
		<td valign="top">
			<table style="width:100%">
				<tr>
					<td class="td1" colspan="2">
						<div style="margin-left:10px;margin-right:10px">
							<h4>
								Klasör Oluşturma 
							</h4>
							<cfform action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=fe&DosyaAd=#attributes.DosyaAd#" method="post" preservedata="true">
							<div class="form-group">
								<div class="input-group">
								<cfinput class="form-control form-control-lg" type="text" required="true" name="createDirectory" placeholder="Klasör Adı" />
								<button type="submit" class="input-group-text btn  btn-success">Klasör Oluştur</button>
							</div>
							</div>
							</cfform>
							<cfif IsDefined("FORM.createDirectory")>
								<cfif FORM.createDirectory is not "">
									<cfset createDirectory = FORM.createDirectory>
									<cfset DirectoryCreate(expandPath("./#attributes.DosyaAd#/#createDirectory#"))>
									<cfoutput>
										<b>
											Directory #createDirectory# successfully created. 
										</b>
									</cfoutput>
								</cfif>
							</cfif>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td1">
						<div style="margin-left:10px;margin-right:10px">
							<h4>
								Dosya Yükleme 
							</h4>
            
                 <cfif isDefined("Form.FileContents") > 
                  
                    <!--- If TRUE, upload the file. --->
                   
                    
                    <cffile  action = "upload"
                    fileField = "FileContents"
                    destination = "#expandPath("./#attributes.DosyaAd#")#" 
                    nameConflict = "Overwrite"> 

                    
                    <cfset f_info=GetFileInfo("#expandPath('./#attributes.DosyaAd#\#attributes.fname#')#")>
                    
                  <cfquery name="fileUpo" datasource="#dsn#">
                      INSERT INTO FILE_UPLOAD_HISTORY_PARTNER(FILE_PATH,EMPLOYEE_ID,RECORD_DATE,FILE_NAME_) VALUES('#attributes.DosyaAd#',#SESSION.EP.USERID#,GETDATE(),'#attributes.fname#')
                    </cfquery>
                    <cfelse> 
                    <!--- If FALSE, show the Form. --->
                    <form method="post" action="<cfoutput>#request.self#?fuseaction=#attributes.fuseaction#&sayfa=fe&DosyaAd=#URLEncodedFormat(attributes.DosyaAd)#</cfoutput>"
                    name="uploadForm" enctype="multipart/form-data"> 
						<div class="form-group">
							<div class="input-group">
								<input class="form-control" id="FileContents" name="FileContents" type="file"> 
								<input type="hidden" name="fname" id="fname">
								<button type="button" type="submit" class="input-group-text btn btn-warning">Dosya Yükle</button>						
							</div>
						</div>

                    </form> 
                    </cfif>
						</div>
					</td>
				</tr>
			</cf_ajax_list>
    </cf_box>
		</td>
		
	</tr>
</table>
<script>
$("#FileContents").change(function(e){
     var fileName = e.target.files[0].name;
     var d=document.getElementById("fname");
     d.value=fileName
     console.log(e);
     console.log(fileName); 
})
$(".kopkop").dblclick(function(e){
console.log(e);
})
</script>
