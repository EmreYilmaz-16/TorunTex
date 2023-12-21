<cfcomponent>
    <cffunction name="SaveFatFis" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="INS" datasource="#arguments.DSN2#">
            INSERT INTO  STOK_FIS_FATURA(FIS_ID,STOCK_ID,FATURA_ID,AMOUNT,RECORD_DATE,RECORD_EMP) VALUES(#arguments.FIS_ID#,#arguments.STOCK_ID#,#arguments.INVOICE_ID#,#arguments.AMOUNT#,GETDATE(),#arguments.EMPLOYEE_ID#)
        </cfquery>
        <cfreturn replace(serializeJSON(arguments),"//","")>
    </cffunction>
</cfcomponent>