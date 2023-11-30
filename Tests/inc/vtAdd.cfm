<cfquery name="getData" datasource="#dsn#">
 SELECT  *FROM (
SELECT AC.name AS KOLON_ADI,ST.name AS TABLO_ADI,SS.name AS SEMA_ADI,STY.name AS TIP,AC.is_identity AS IDENT,AC.max_length  FROM sys.all_columns AS AC 
INNER JOIN sys.tables AS ST ON AC.object_id=ST.object_id
INNER JOIN sys.types AS STY ON STY.user_type_id=AC.user_type_id
INNER JOIN sys.schemas AS SS ON SS.schema_id=ST.schema_id
) AS TK WHERE TABLO_ADI='#attributes.tb#' AND SEMA_ADI='#attributes.sc#'
 
   <!--- select COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA='#attributes.sc#' and TABLE_NAME='#attributes.tb#'---->
</cfquery>

<cfdump var="#getData#">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=#attributes.sayfa#">
    <input type="hidden" name="is_submit" value="1">
    <cfoutput>
        <input type="hidden" name="tb" value="#attributes.tb#">
        <input type="hidden" name="sc" value="#attributes.sc#">
        <table>
        <cfloop query="getData">
            <cfif getData.IDENT neq 1>
            <tr>
                <td>
                    <div class="form-group">
                        <label>#KOLON_ADI#</label>
                        <cfif TIP EQ "bit">
                            <select name="#KOLON_ADI#">
                                <option value="1">Aktif</option>
                                <option value="0">Pasif</option>
                            </select>
                        <cfelseif TIP eq "datetime">
                            <input type="date" name="#KOLON_ADI#">
                        <cfelseif TIP eq "nvarchar" OR TIP eq "varchar">
                            <input type="text" name="#KOLON_ADI#" <cfif max_length neq -1>maxlength="#max_length#"</cfif>>
                        </cfif>
                    </div>
                    
                </td>
            </tr>
        </cfif>
        </cfloop>
        <tr>
            <td>
                <input type="submit">
            </td>
        </tr>
    </table>
    </cfoutput>
</cfform>
<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
</cfif>
