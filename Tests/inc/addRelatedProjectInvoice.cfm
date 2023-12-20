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
<CF_BOX title="Proje">
<table border="1" cellspacing="0" cellpadding="0">
    <TR>
        <TH>
            PROJE
        </TH>
    </TR>

<cfoutput query="PROJECT">
    <CFSET DEVREDEN=0>
    <CFSET DEVREDEN1=0>
    <CFSET DEVREDEN2=0>
    <CFSET DEVREDEN3=0>
<cfquery name="getInvoices" datasource="#dsn#">
    select * from #dsn#.PROJECT_INVOICE_RELATIONSXXXXXX where PROJECT_ID=#PROJECT.PROJECT_ID#
</cfquery>
<CFSET "BAKIYE_#PROJECT_ID#"=PROJECT.AMOUNT>
<cfloop query="getInvoices">
    <cfquery name="GETFAT" datasource="#DSN#">
        SELECT * FROM FATURAXXXXXX WHERE INVOICE_ID=#INVOICE_ID#
    </cfquery>
    <cfloop query="GETFAT">
        <CFSET "BAKIYE_#PROJECT.PROJECT_ID#"-=GETFAT.AMOUNT>
        <CFSET DEVREDEN -=evaluate("BAKIYE_#PROJECT.PROJECT_ID#")>
        <CFSET DEVREDEN3 +=evaluate("BAKIYE_#PROJECT.PROJECT_ID#")>
    </cfloop>

</cfloop>
<CFSET DEVREDEN1 += (1* evaluate("BAKIYE_#PROJECT.PROJECT_ID#"))>
<CFSET DEVREDEN2 += (-1* evaluate("BAKIYE_#PROJECT.PROJECT_ID#"))>

<TR>
    <TD>
         #PROJECT.PROJECT_ID#
    </TD>



<td>
<table>
    <cfloop query="getInvoices">
<tr>
    <td>#getInvoices.INVOICE_ID#</td>    
</tr>
</cfloop>
</table>
</td>    


<td>
    <CFIF evaluate("BAKIYE_#PROJECT.PROJECT_ID#") LTE 0>0</CFIF>
    <SPAN style="color:red">#DEVREDEN#</SPAN>-
    <SPAN style="color:green">#DEVREDEN1#</SPAN>-
    <SPAN style="color:blue">#DEVREDEN2#</SPAN>-
    <SPAN style="color:magenta">#DEVREDEN3#</SPAN>-
    <SPAN style="color:orange">#evaluate("BAKIYE_#PROJECT.PROJECT_ID#")#</SPAN>
</td>
</tr>
</cfoutput>
</table>
</CF_BOX>