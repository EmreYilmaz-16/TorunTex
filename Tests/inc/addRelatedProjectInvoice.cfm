<!-----<cfscript >
    INVOICE_ROW=queryNew("INVOICE_ID,AMOUNT","INTEGER,DECIMAL");
    PROJECT=queryNew("PROJECT_ID,AMOUNT","INTEGER,DECIMAL");
    PROJECT_INVOICE_RELATIONS=queryNew("ID,PROJECT_ID,INVOICE_ID","INTEGER,INTEGER,INTEGER")
    
    Obj={INVOICE_ID=1,AMOUNT=100};
    queryAddRow(INVOICE_ROW,Obj);
    Obj={INVOICE_ID=2,AMOUNT=250 };
    queryAddRow(INVOICE_ROW,Obj);
    Obj={INVOICE_ID=3,AMOUNT=650};
    queryAddRow(INVOICE_ROW,Obj);
      writeDump(INVOICE_ROW)
      
    Obj={PROJECT_ID=3,AMOUNT=125};
    queryAddRow(PROJECT,Obj);
    Obj={PROJECT_ID=4,AMOUNT=175};
    queryAddRow(PROJECT,Obj);
    Obj={PROJECT_ID=5,AMOUNT=350};
    queryAddRow(PROJECT,Obj);
    Obj={PROJECT_ID=6,AMOUNT=350};
    queryAddRow(PROJECT,Obj);
    
    writeDump(PROJECT)
    
    Obj={PROJECT_ID=3,INVOICE_ID=1,ID=1};
    queryAddRow(PROJECT_INVOICE_RELATIONS,Obj);
    
    Obj={PROJECT_ID=3,INVOICE_ID=2,ID=2};
    queryAddRow(PROJECT_INVOICE_RELATIONS,Obj);
    
    Obj={PROJECT_ID=4,INVOICE_ID=2,ID=2};
    queryAddRow(PROJECT_INVOICE_RELATIONS,Obj);
    
     Obj={PROJECT_ID=5,INVOICE_ID=2,ID=2};
    queryAddRow(PROJECT_INVOICE_RELATIONS,Obj);
    
    writeDump(PROJECT_INVOICE_RELATIONS)
</cfscript>
---->
<cfquery name="PROJECT" datasource="#dsn#">
    SELECT * FROM PROJECTXXXXXX
</cfquery>

<table>
    <TR>
        <TH>
            PROJE
        </TH>
    </TR>
<cfoutput query="PROJECT">
<TR>
    <TD>
         #PROJECT.PROJECT_ID#
    </TD>
</TR>
</cfoutput>
</table>