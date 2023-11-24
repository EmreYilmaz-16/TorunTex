<cf_box title="Lot Hareketleri">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=15">
   <table>
    <tr>
        <td>
            <input class="form-control" type="text" name="Barkod" id="Barkod">
        </td>
        <td>
            <input type="hidden" name="is_submit" value="1">
            <input type="submit">
        </td>
    </tr>
   </table>
    
   
</cfform>

<cfif isDefined("attributes.is_submit")>
    <CFSET URUN_BARKODU="#attributes.Barkod#">
    <cfset URUN_BARKODU=replace(URUN_BARKODU,"||","|","all")>    
    <CFOUTPUT>
        <span styl="color:red"> #URUN_BARKODU#</span><br>
        <CFSET URUN_KODU="#listlen(URUN_BARKODU,"|")#">
        <CFSET URUN_KODU="#listgetat(URUN_BARKODU,"1","|")#">
        <CFSET LOT_NO="#listgetat(URUN_BARKODU,"2","|")#">
    <!---    <CFSET URUN_KODU="#listgetat(URUN_BARKODU,"1","|")#">
        #listgetat(URUN_BARKODU,"2","|")#<br>
        #listgetat(URUN_BARKODU,"3","|")#<br>---->
        <cfquery name="getLOTDATA" datasource="#dsn2#">
            SELECT PC.PROCESS_CAT,SR.STOCK_IN,SR.STOCK_OUT,SR.STORE,SR.STORE_LOCATION,SR.STOCK_ID,SL.COMMENT,SR.UPD_ID,O.ORDER_NUMBER,C.NICKNAME,SR.PROCESS_DATE FROM w3Toruntex_2023_1.STOCKS_ROW AS SR
INNER JOIN w3Toruntex_1.SETUP_PROCESS_CAT AS PC ON PC.PROCESS_TYPE=SR.PROCESS_TYPE
INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SR.STORE_LOCATION AND SL.DEPARTMENT_ID =SR.STORE
INNER JOIN w3Toruntex_1.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID=SR.PBS_RELATION_ID
INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
INNER JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
WHERE SR.LOT_NO='#LOT_NO#' ORDER BY UPD_ID,SR.STOCK_OUT DESC
        </cfquery>

        <cf_big_list>
            <tr>
                <th>
                    Sipariş
                </th>
                <th>
                Müşteri
                </th>
                <th>

                </th>
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
            <cfloop query="getLOTDATA" >
                <tr>
                    <td>#ORDER_NUMBER#</td>
                    <td>#NICKNAME#</td>
                    <td>#PROCESS_CAT#</td>
                    <td>#tlformat(STOCK_IN)#</td>
                    <td>#tlformat(STOCK_OUT)#</td>
                    <td>#COMMENT#</td>
                </tr>
            </cfloop>
        </cf_big_list>
    </CFOUTPUT>

</cfif>
</cf_box>