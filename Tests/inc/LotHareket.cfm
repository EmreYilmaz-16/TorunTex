<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=15">
    <input type="text" name="Barkod" id="Barkod">
   <input type="hidden" name="is_submit" value="1">
    <input type="submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <CFSET URUN_BARKODU="#attributes.Barkod#">
    <cfset URUN_BARKODU=replace(URUN_BARKODU,"||","|","all")>    
    <CFOUTPUT>
        <span styl="color:red"> #URUN_BARKODU#</span><br>
        <CFSET URUN_KODU="#listlen(URUN_BARKODU,"|")#">
        <CFSET URUN_KODU="#listgetat(URUN_BARKODU,"1","|")#">
        <CFSET LOT_NO="#listgetat(URUN_BARKODU,"1","|")#">
    <!---    <CFSET URUN_KODU="#listgetat(URUN_BARKODU,"1","|")#">
        #listgetat(URUN_BARKODU,"2","|")#<br>
        #listgetat(URUN_BARKODU,"3","|")#<br>---->
        <cfquery name="getData" datasource="#dsn2#">
            SELECT PC.PROCESS_CAT,SR.STOCK_IN,SR.STOCK_OUT,SR.STORE,SR.STORE_LOCATION,SR.STOCK_ID,SL.COMMENT,SR.UPD_ID FROM w3Toruntex_2023_1.STOCKS_ROW AS SR
INNER JOIN w3Toruntex_1.SETUP_PROCESS_CAT AS PC ON PC.PROCESS_TYPE=SR.PROCESS_TYPE
INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SR.STORE_LOCATION AND SL.DEPARTMENT_ID =SR.STORE
WHERE LOT_NO='#LOT_NO#' ORDER BY UPD_ID,SR.PROCESS_TYPE
        </cfquery>
        <cf_big_list>
            <tr>
                <th>
                    İşlem
                </th>
                <th>
                    +
                </th>
                <th>
                    -
                </th>
                <th>
                    Depo
                </th>
            </tr>
            <cfoutput query="getData">
                <tr>
                    <td>#PROCESS_CAT#</td>
                    <td>#tlformat(STOCK_IN)#</td>
                    <td>#tlformat(STOCK_OUT)#</td>
                    <td>#COMMENT#</td>
                </tr>
            </cfoutput>
        </cf_big_list>
    </CFOUTPUT>

</cfif>