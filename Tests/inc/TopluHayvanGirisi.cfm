<cfset GETF=getFatura()>
<div class="form-group">
    <select name="INVO">
        <cfoutput query="GETF">
            <option value="#INVOICE_ID#">#INVOICE_NUMBER#</option>
        </cfoutput>
    </select>
</div>



<cffunction name="getFatura">
    <cfquery name="GETF" datasource="#DSN2#">
        SELECT DISTINCT INVOICE_ID
            ,INVOICE_NUMBER
            ,PROCESS_STAGE
            ,PROJECT_HEAD
        FROM (
            SELECT INVOICE_NUMBER
                ,I.INVOICE_ID
                ,IR.AMOUNT
                ,IR.AMOUNT2
                ,I.PROCESS_STAGE
                ,PPR.PROJECT_HEAD AS PROJECT_HEAD               
            FROM #dsn2#.INVOICE AS I
            INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
            LEFT JOIN #dsn#.PRO_PROJECTS AS PPR ON PPR.PROJECT_ID = I.PROJECT_ID
            WHERE INVOICE_CAT = 591 AND PPR.BRANCH_ID=5
            --    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
            ) AS IRRS
        

</cfquery>
<cfreturn GETF>
</cffunction>
<cffunction name="getLocation">
    <cfquery name="getl" datasource="#dsn#">
        SELECT * FROM STOCKS_LOCATION WHERE DEPARTMENT_ID=18
    </cfquery>
    <cfreturn getl>
</cffunction>