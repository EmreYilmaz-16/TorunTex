<cfswitch expression="#attributes.str_code#">
	<!--- process --->
	<cfcase value="getCompanyRisk">
		<cfset param_1 = listgetat(attributes.ext_params,1,"*")> 		
		<cfset form.str_sql= "SELECT * FROM COMPANY WHERE COMPANY_ID=#param_1#">
	</cfcase> 

	<cfdefaultcase>
		<cfset form.str_sql = "SELECT * FROM WRK_SESSION">
		
	
	</cfdefaultcase>
</cfswitch>