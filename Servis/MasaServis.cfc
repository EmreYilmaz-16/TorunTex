<cfcomponent>
    <cffunction name="SendMasa" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfdump var="#arguments#">
        <cfset F=structKeyArray(arguments)>
        <cfset FormData=deserializeJSON(f[1])>
        <cfdump var="#FormData#">
        <cfif isDefined("FormData.RAF_DATA")>
            merhaba
        <cfelse>
            NO MERHABA
        </cfif>




    </cffunction>
</cfcomponent>