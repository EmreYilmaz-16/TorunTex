<cfcomponent>
    <cffunction name="SaveFatFis" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="INS" datasource="#arguments.DSN2#" result="RES">
            INSERT INTO  STOK_FIS_FATURA(FIS_ID,STOCK_ID,FATURA_ID,AMOUNT,RECORD_DATE,RECORD_EMP) VALUES(#arguments.FIS_ID#,#arguments.STOCK_ID#,#arguments.INVOICE_ID#,#arguments.AMOUNT#,GETDATE(),#arguments.EMPLOYEE_ID#)
        </cfquery>
        <CFSET RETURNDATA.ARGS=arguments>
        <CFSET RETURNDATA.RES=RES>
        <cfreturn replace(serializeJSON(RETURNDATA),"//","")>
    </cffunction>
    <cffunction name="getBeyannameler" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getBeyans" datasource="#dsn2#">   
            SELECT * FROM (
                SELECT SF.FIS_ID
                    ,SF.FIS_DATE AS SEVK_TARIHI
                    ,SFR.STOCK_ID AS STOCK_ID
                    ,SFR.AMOUNT AS MIKTAR
                    ,SFR.UNIT AS BIRIM
                    ,SFR.AMOUNT2 AS MIKTAR2
                    ,SFR.UNIT2 AS BIRIM2
                    ,SFR.LOT_NO AS KONTEYNER_NO
                    ,PP.PROJECT_HEAD AS BEYANNAME_NO
                    ,DATEDIFF(DAY, SF.FIS_DATE, GETDATE()) AS GECEN_SURE	
                    ,ISNULL(SUM(SFF.AMOUNT),0) AS KULLANILAN
                    ,SFR.AMOUNT-ISNULL(SUM(SFF.AMOUNT),0) AS KALAN
                FROM #arguments.dsn2#.STOCK_FIS AS SF
                INNER JOIN #arguments.dsn2#.STOCK_FIS_ROW AS SFR ON SFR.FIS_ID = SF.FIS_ID
                INNER JOIN #arguments.dsn#.PRO_PROJECTS AS PP ON PP.PROJECT_ID = SF.PROJECT_ID
                LEFT  JOIN #arguments.dsn2#.STOK_FIS_FATURA AS SFF ON SFF.FIS_ID=SF.FIS_ID AND SFF.STOCK_ID=SFR.STOCK_ID
                WHERE DEPARTMENT_OUT = 13
                GROUP BY
                SF.FIS_ID
                    ,SF.FIS_DATE 
                    ,SFR.STOCK_ID
                    ,SFR.AMOUNT 
                    ,SFR.UNIT 
                    ,SFR.AMOUNT2
                    ,SFR.UNIT2 
                    ,SFR.LOT_NO
                    ,PP.PROJECT_HEAD
            ) AS T WHERE T.KALAN>0
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