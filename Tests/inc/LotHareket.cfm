<cf_box title="Lot Hareketleri">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=15">
   <table>
    <tr>
        <td>
            <input class="form-control" type="text" name="Barkod" id="Barkod">
        </td>
        <td>
            <input type="hidden" name="is_submit" value="1">
            <button type="submit" class="btn btn-outline-success">Sorgula</button>
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
                <th>##</th>
                <th>
                    Tarih
                </th>
                <th>
                    Sipariş
                </th>
                <th>
                Müşteri
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
        <cfset ix=0>
            <cfloop from="1" to="#getLOTDATA.recordCount#" index="i"  >
<cfset ix=ix+1>
<cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i-1]>
<cfset ix=ix-1>
</cfif>
                <tr>
                   <!--- <td <cfif i neq getLOTDATA.recordCount and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1]>rowspan="2"</cfif>><div style="<cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1]>color:red;text-align:right</cfif>"><cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1]>&nbsp;&nbsp;#ix#<cfelse>#ix#</cfif></div></td>--->
                   <td>#i#</td>
                    <td>#dateformat(getLOTDATA.PROCESS_DATE[i],"dd/mm/yyyy")# #timeFormat(getLOTDATA.PROCESS_DATE[i],"HH:nn")#</td>
                    <td>#getLOTDATA.ORDER_NUMBER[i]#</td>
                    <td>#getLOTDATA.NICKNAME[i]#</td>
                    
                    <td>#getLOTDATA.PROCESS_CAT[i]#</td>
                    <td>#tlformat(getLOTDATA.STOCK_IN[i])#</td>
                    <td>#tlformat(getLOTDATA.STOCK_OUT[i])#</td>
                    <td>#getLOTDATA.COMMENT[i]#</td>
                </tr>
            </cfloop>
        </cf_big_list>
    </CFOUTPUT>

</cfif>
</cf_box>