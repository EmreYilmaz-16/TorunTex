<cfset InfoArray = ArrayNew(1)>
<cfset ReturnValue=structNew()>
<cftry>
<cfset ResWords="insert,update,delete,INSERT,UPDATE,DELETE">
<cfset RecOp=0>
<cfloop list="#ResWords#" item="Aword">
    <cfif findNoCase(Aword,attributes.str_sql)>
        <cfset RecOp=1>
    </cfif>
</cfloop>
<cfif not isDefined("attributes.data_source")>
    <cfset DataSource="#dsn#">
<cfelse>
    <cfset DataSource=evaluate(attributes.data_source)>
</cfif>

<cfif RecOp eq 1>
    <cfquery name="ReturnQuery" datasource="#DataSource#" result="Res">
        #preserveSingleQuotes(attributes.str_sql)#
    </cfquery>
    <cfset ReturnValue.recordCount=Res.recordCount>
    <cfset ReturnValue.RESULT=Res>
    <cfset ReturnValue.CALISAN_1="BIRINCI QUERY CALISTI">
<cfelse>
    <cfquery name="ReturnQuery" datasource="#DataSource#" result="Res">
        #preserveSingleQuotes(attributes.str_sql)#
    </cfquery>
    <cfset ReturnArr=arrayNew(1)>
  <cfoutput query="ReturnQuery">            
    <cfset QueryItem=structNew()>
    <cfloop list="#Res.COLUMNLIST#" item="item">
        <cfset "QueryItem.#item#"=evaluate(item) >        
        </cfloop>    
        <cfscript>
            arrayAppend(ReturnArr,QueryItem);
        </cfscript>
    </cfoutput>
    <cfset ReturnValue.recordCount=ReturnQuery.recordCount>
    <cfset ReturnValue.RESULT=ReturnArr>
    <cfset ReturnValue.CALISAN_2="IKINCI QUERY CALISTI">
</cfif>
<cfcatch>
    <cfset ReturnValue.recordCount=0>
    <cfset ReturnValue.RESULT=cfcatch>
</cfcatch>

</cftry>
<cfset InfoArray[1]=ReturnValue>
<cfoutput>
    #Replace(SerializeJSON(InfoArray),'//','')#
</cfoutput>