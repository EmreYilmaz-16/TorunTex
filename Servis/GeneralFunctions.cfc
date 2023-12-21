<cfcomponent>
    <cffunction name="SaveFatFis" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfreturn replace(serializeJSON(arguments),"//","")>
    </cffunction>
</cfcomponent>