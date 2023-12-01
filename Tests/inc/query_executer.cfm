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
<cfelse>

</cfif>