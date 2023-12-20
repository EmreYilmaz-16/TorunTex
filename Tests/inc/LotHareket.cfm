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
SELECT S1.*,C.NICKNAME,PROCESS_CAT FROM (
SELECT 
	SR.STOCK_IN
	,SR.STOCK_OUT
	,STOCK_IN - STOCK_OUT AS PSSPK
	,SR.STORE
	,SR.STORE_LOCATION
	,SR.STOCK_ID
	,SL.COMMENT
	,SR.UPD_ID
	,O.ORDER_NUMBER	
	,SR.PROCESS_DATE
	,SR.UNIT2
	,SR.PROCESS_TYPE	
	,SR.LOT_NO
	,SR.PBS_RELATION_ID
	,O.COMPANY_ID
	,CASE WHEN SR.PROCESS_TYPE=71 THEN 1 ELSE 0 END AS TS
FROM w3Toruntex_2023_1.STOCKS_ROW AS SR
LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID = SR.STORE_LOCATION
	AND SL.DEPARTMENT_ID = SR.STORE
LEFT JOIN w3Toruntex_1.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID = SR.PBS_RELATION_ID
LEFT JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID = ORR.ORDER_ID

) S1
LEFT JOIN ( 
SELECT PROCESS_CAT PI1,COMPANY_ID,FIS_TYPE AS PROCESS_TYPE,0 AS PS,FIS_ID FROM	w3Toruntex_2023_1.STOCK_FIS 
UNION ALL 
SELECT PROCESS_CAT PI1,COMPANY_ID,SHIP_TYPE AS PROCESS_TYPE ,1 AS PS,SHIP_ID AS FIS_ID FROM	w3Toruntex_2023_1.SHIP 
) AS SF
ON SF.FIS_ID = S1.UPD_ID AND SF.PS=S1.TS
LEFT JOIN w3Toruntex_1.SETUP_PROCESS_CAT AS PC ON PC.PROCESS_TYPE = SF.PROCESS_TYPE
	AND PC.PROCESS_CAT_ID = SF.PI1
LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID= ISNULL(SF.COMPANY_ID,S1.COMPANY_ID)
WHERE S1.LOT_NO='#LOT_NO#'
 ORDER BY UPD_ID,S1.STOCK_OUT DESC,PROCESS_DATE DESC
        </cfquery>

        <cf_grid_list >
        <thead>
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
                    Miktar
                </th>  
                <th>
                    Miktar2
                </th>                   
                <th>
                    Depo
                </th>
            </tr>
        </thead>
        <cfset ix=0>
        <cfset iy=1>
        <tbody>
            <cfloop from="1" to="#getLOTDATA.recordCount#" index="i"  >
<cfset ix=ix+1>
<cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i-1]>
<cfset ix=ix-1>
</cfif>
<cfset RS=1>
<cfif i neq getLOTDATA.recordCount and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1] ><CFSET RS=2><cfelse></cfif>
                <tr>
                   
                    <cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i-1]><cfelse> <td rowspan="#RS#">#ix# <cfif i neq getLOTDATA.recordCount and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1] ></cfif></td></cfif>
                      <CFSET RS=1>
                      <cfif i neq getLOTDATA.recordCount and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1] ><CFSET RS=2><cfelse></cfif>
                      <cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i-1]><cfelse>    <td rowspan="#RS#">#dateformat(getLOTDATA.PROCESS_DATE[i],"dd/mm/yyyy")# #timeFormat(getLOTDATA.PROCESS_DATE[i],"HH:nn")#</td></cfif>
                    <cfset RS=1>
                        <td rowspan="#RS#">#getLOTDATA.ORDER_NUMBER[i]#</td>
                     <td rowspan="#RS#">#getLOTDATA.NICKNAME[i]#</td>
                     <cfif i neq getLOTDATA.recordCount and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i+1] ><CFSET RS=2><cfelse></cfif>
                     <cfif i neq 1 and getLOTDATA.UPD_ID[i] eq getLOTDATA.UPD_ID[i-1]><cfelse>    <td rowspan="#RS#">#getLOTDATA.PROCESS_CAT[i]#</td></cfif>
                        <cfset RS=1>
                    <td style="text-align:right">
                        <div class="<cfif getLOTDATA.PSSPK[i] lt 0>text-danger<cfelse>text-success</cfif> bold">#tlformat(getLOTDATA.PSSPK[i])#</div>
                    </td>
                    <td style="text-align:right">
                        <div class="<cfif getLOTDATA.PSSPK[i] lt 0>text-danger<cfelse>text-success</cfif> bold">#tlformat(1)# #getLOTDATA.UNIT2[i]#</div>
                    </td>
                   <!--- <td style="text-align:right"><div class="<cfif getLOTDATA.STOCK_IN[i] neq 0>text-success</cfif>" style="<cfif getLOTDATA.STOCK_IN[i] neq 0>font-weight:bold</cfif>"><cfif getLOTDATA.STOCK_IN[i] neq 0>#tlformat(getLOTDATA.STOCK_IN[i])#</cfif></div></td>
                    <td style="text-align:right"><div class="<cfif getLOTDATA.STOCK_OUT[i] neq 0>text-danger</cfif>" style="<cfif getLOTDATA.STOCK_OUT[i] neq 0>font-weight:bold</cfif>"><cfif getLOTDATA.STOCK_OUT[i] neq 0>#tlformat(getLOTDATA.STOCK_OUT[i])#</cfif></div></td>---->
                    <td style="text-align:right">#getLOTDATA.COMMENT[i]#</td>
                </tr>
            </cfloop>
        </tbody>
        </cf_grid_list>
    </CFOUTPUT>

</cfif>
</cf_box>