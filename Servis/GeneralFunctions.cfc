<cfcomponent>
    <CFSET DSN="w3Toruntex">
    <cffunction name="SaveFatFis" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="INS" datasource="#arguments.DSN3#" result="RES">
            INSERT INTO  STOK_FIS_FATURA(FIS_ID,STOCK_ID,FATURA_ID,AMOUNT,RECORD_DATE,RECORD_EMP,FIS_PERIOD_ID,FATURA_PERIOD_ID) VALUES(#arguments.FIS_ID#,#arguments.STOCK_ID#,#arguments.INVOICE_ID#,#arguments.AMOUNT#,GETDATE(),#arguments.EMPLOYEE_ID#,#arguments.PERIOD_ID#,#arguments.FATURA_PERIOD_ID#)
        </cfquery>
        <CFSET RETURNDATA.ARGS=arguments>
        <CFSET RETURNDATA.RES=RES>
        <cfreturn replace(serializeJSON(RETURNDATA),"//","")>
    </cffunction>
    <cffunction name="getBeyannameler" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="GetPeriods" datasource="#DSN#">
            SELECT * FROM w3Toruntex.SETUP_PERIOD WHERE OUR_COMPANY_ID=1
        </cfquery>
        <cfset i=0>
        <cfquery name="getBeyans" datasource="#dsn2#">   
           
SELECT T.*
	,PP.PROJECT_ID
	,PP.PROJECT_HEAD AS BEYANNAME_NO
	,DATEDIFF(DAY, T.SEVK_TARIHI, GETDATE()) AS GECEN_SURE
	,ISNULL(SUM(SFF.AMOUNT), 0) AS KULLANILAN
	,T.MIKTAR  - ISNULL(SUM(SFF.AMOUNT), 0) AS KALAN
FROM (
    <cfloop query="GetPeriods">
<cfset i=i+1>
	SELECT SF.PROJECT_ID
		,SFR.AMOUNT as MIKTAR 
		,SFR.AMOUNT2 AS MIKTAR2 
		,SF.FIS_ID
		,SF.FIS_DATE as SEVK_TARIHI
		,SFR.STOCK_ID
        ,SFR.UNIT AS BIRIM
        ,SFR.UNIT2 AS BIRIM2 
		,#PERIOD_ID# AS PERIOD_ID
		,SFR.LOT_NO AS KONTEYNER_NO 
	FROM w3Toruntex_#PERIOD_YEAR#_#OUR_COMPANY_ID#.STOCK_FIS AS SF
	INNER JOIN w3Toruntex_#PERIOD_YEAR#_#OUR_COMPANY_ID#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
	WHERE DEPARTMENT_OUT = 13
	<cfif i lt GetPeriods.recordCount>
	UNION ALL
</cfif>
</cfloop>
	) AS T
LEFT JOIN w3Toruntex.PRO_PROJECTS AS PP ON PP.PROJECT_ID = T.PROJECT_ID
LEFT JOIN w3Toruntex_1.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID = T.FIS_ID
	AND SFF.FIS_PERIOD_ID = T.PERIOD_ID
	AND SFF.STOCK_ID = T.STOCK_ID
GROUP BY PP.PROJECT_ID
	,T.MIKTAR 
	,T.MIKTAR2 
	,T.FIS_ID
	,SEVK_TARIHI
	,T.STOCK_ID
	,PERIOD_ID
	,KONTEYNER_NO 
	,T.PROJECT_ID
	,PP.PROJECT_HEAD
,T.BIRIM
,T.BIRIM2 

</cfquery>
            
            <cfset ReturnArr=arrayNew(1)>
            <cfloop query="getBeyans">
                <cfscript>
                        Item={
                            FIS_ID=FIS_ID,
                            SEVK_TARIHI="#dateFormat(SEVK_TARIHI,'dd/mm/yyyy')#",
                            STOCK_ID=STOCK_ID,
                            MIKTAR=MIKTAR,
                            BIRIM=BIRIM,
                            MIKTAR2=MIKTAR2,
                            BIRIM2=BIRIM2,
                            KONTEYNER_NO=KONTEYNER_NO,
                            BEYANNAME_NO=BEYANNAME_NO,
                            GECEN_SURE=GECEN_SURE,
                            KULLANILAN=KULLANILAN,
                            KALAN=KALAN
                        };
                        arrayAppend(ReturnArr,item);
                </cfscript>
            </cfloop>
            <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
</cfcomponent>