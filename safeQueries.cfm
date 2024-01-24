<cfswitch expression="#attributes.str_code#">
	<!--- process --->
	<cfcase value="getCompanyRisk">
		<cfset param_1 = listgetat(attributes.ext_params,1,"*")> 	
        <cfset param_2 = listgetat(attributes.ext_params,2,"*")> 	
        <cfset param_3 = listgetat(attributes.ext_params,3,"*")> 		
		<cfset form.str_sql= "SELECT PRICE,MONEY FROM #param_3#.PRICE WHERE PRICE_CATID =(SELECT PRICE_CAT FROM COMPANY_CREDIT WHERE COMPANY_ID=#param_1#) AND PRODUCT_ID=#param_2#">
	</cfcase> 

	<cfdefaultcase>
		<cfset form.str_sql = "SELECT * FROM WRK_SESSION">
		
	
	</cfdefaultcase>
</cfswitch>