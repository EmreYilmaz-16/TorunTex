<cfswitch expression="#attributes.str_code#">
	<!--- process type--->
	<cfcase value="getCompanyRisk">
		<cfset param_1 = listgetat(attributes.ext_params,1,"*")> 	
        <cfset param_2 = listgetat(attributes.ext_params,2,"*")> 	
        <cfset param_3 = listgetat(attributes.ext_params,3,"*")> 		
		<cfset form.str_sql= "SELECT PRICE,MONEY FROM #param_3#.PRICE WHERE PRICE_CATID =(SELECT PRICE_CAT FROM COMPANY_CREDIT WHERE COMPANY_ID=#param_1#) AND PRODUCT_ID=#param_2#">
	</cfcase> 
    <cfcase value="getProductPackegeWeight">
		<cfset param_1 = listgetat(attributes.ext_params,1,"*")> 	        
		<cfset form.str_sql= "select PROPERTY3 from PRODUCT_INFO_PLUS  where PRODUCT_ID=#param_1#">
	</cfcase> 
	<cfcase value="getBasketInfoId">
		<cfset param_1 = listgetat(attributes.ext_params,1,"*")> 	        
		<cfset form.str_sql= "Select BASKET_INFO_TYPE_ID from SETUP_BASKET_INFO_TYPES where BASKET_INFO_TYPE='#param_1#' AND OPTION_NUMBER=1">
	</cfcase> 
	<cfdefaultcase>
		<cfset form.str_sql = "SELECT * FROM WRK_SESSION">
		
	
	</cfdefaultcase>
</cfswitch>

