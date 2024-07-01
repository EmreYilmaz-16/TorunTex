<cfcomponent>
<cfset dsn1="w3Toruntex_product">
    <cffunction name="GetCiftliks" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getc" datasource="#dsn1#">
         SELECT CIFTLIK,CIFTLIK_KOD,CIFTLIK_ID,CCT.CIFTLIK_TUR,CIFTLIK_TUR_ID  FROM 
w3Toruntex_product.CIFTLIK_CIFTLIKLER AS CCF
	LEFT JOIN 
	w3Toruntex_product.CIFTLIK_CIFTLIK_TUR AS CCT 
	ON CCF.CIFTLIK_TUR=CCT.CIFTLIK_TUR_ID
        </cfquery>
        <cfset ReturnData=arrayNew(1)>
        <cfloop query="getc">
            <cfscript>
            O={
                CIFTLIK=CIFTLIK,
                CIFTLIK_TUR=CIFTLIK_TUR,
                CIFTLIK_KOD=CIFTLIK_KOD,
                CIFTLIK_ID=CIFTLIK_ID
            };

            arrayAppend(ReturnData,O);
            
              
            </cfscript>
        </cfloop>

        <cfreturn replace(serializeJSON(ReturnData),"//","")>
    </cffunction>
    <cffunction name="getPadok" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getc" datasource="#dsn1#">
   SELECT TOP (1000) [PADOK_ID]
      ,[PADOK]
  FROM [w3Toruntex].[w3Toruntex_product].[CIFTLIK_PADOK]

        </cfquery>
        <cfset ReturnData=arrayNew(1)>
        <cfloop query="getc">
            <cfscript>
            O={
                PADOK_ID=PADOK_ID,
                PADOK=PADOK
                
            };

            arrayAppend(ReturnData,O);
            
              
            </cfscript>
        </cfloop>

        <cfreturn replace(serializeJSON(ReturnData),"//","")>
    </cffunction>
    <cffunction name="getHayvanTip" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getc" datasource="#dsn1#">
    SELECT PRODUCT_ID,STOCK_ID,PRODUCT_NAME,PROPERTY FROM w3Toruntex_1.STOCKS WHERE PRODUCT_CATID =34
        </cfquery>
        <cfset ReturnData=arrayNew(1)>
        <cfloop query="getc" group="PRODUCT_ID">
            <cfscript>
            O={
                PRODUCT_NAME=PRODUCT_NAME,
                TYPES=arrayNew(1),
                
            };
        
        
            
              
            </cfscript>
            <cfloop>
                <cfscript>
                    OO={
                        STOCK_ID=STOCK_ID,                    
                        PROPERTY=PROPERTY
                    };
                    arrayAppend(O.TYPES,OO);
                </cfscript>
            </cfloop>
            <cfscript>
                arrayAppend(ReturnData,O);
            </cfscript>
        </cfloop>

        <cfreturn replace(serializeJSON(ReturnData),"//","")>
    </cffunction>
    
</cfcomponent>