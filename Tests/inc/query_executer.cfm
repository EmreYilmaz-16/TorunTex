<cfset ReturnValue=structNew();
<cftry>
<cfset ResWords="insert,update,delete">
<cfset RecOp=0>
<cfloop list="#ResWords#" item="Aword">
    <cfif findNoCase(attributes.query,Aword)>
        <cfset RecOp=1>
    </cfif>
</cfloop>
<cfif not isDefined("attributes.data_source")>
    <cfset DataSource="#dsn#">
<cfelse>
    <cfset DataSource=attributes.data_source>
</cfif>

<cfif RecOp eq 1>
    <cfquery name="ReturnQuery" datasource="#DataSource#" result="Res">
        #preserveSingleQuotes(attributes.sql_query)#
    </cfquery>
    <cfset ReturnValue.recordCount=Res.recordCount>
    <cfset ReturnValue.RESULT=Res>
<cfelse>
    <cfquery name="ReturnQuery" datasource="#DataSource#" result="Res">
        #preserveSingleQuotes(attributes.sql_query)#
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
</cfif>
<cfcatch>
    <cfset ReturnValue.recordCount=0>
    <cfset ReturnValue.RESULT=ReturnArr>
</cfcatch>

</cftry>

<cfoutput>
    #Replace(SerializeJSON(ReturnValue),'//','')#
</cfoutput>