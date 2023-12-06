
<cfset DEPARTMENT_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),1,"-")>
<cfset LOCATION_ID=listGetAt(listGetAt(attributes.SELECT1,1,"*"),2,"-")>
<cfset ORDER_ID=listGetAt(attributes.SELECT1,2,"*")>
<cfset SEPET_ID=listGetAt(attributes.SELECT1,3,"*")>

<cf_box title="Sevkiyat İşlemi">
    <input type="hidden" name="SEPET_ID" id="SEPET_ID" value="<CFOUTPUT>#SEPET_ID#</CFOUTPUT>">
    <input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="<CFOUTPUT>#DEPARTMENT_ID#</CFOUTPUT>">
    <input type="hidden" name="LOCATION_ID" id="LOCATION_ID" value="<CFOUTPUT>#LOCATION_ID#</CFOUTPUT>">
    <input type="hidden" name="ORDER_ID" id="ORDER_ID" value="<CFOUTPUT>#ORDER_ID#</CFOUTPUT>">
    <div class="form-group">
        <label>Barkod</label>
        <input type="text" class="form-control" name="BARKOD" id="BARKOD" placeholder="Barkod Okutunuz" onkeyup="islemYap(this,event)">
    </div>
    <table class="table table-warning table-stripped" id="Sepetim">
        <cfquery name="GETDATA" datasource="#DSN3#">
    SELECT S.PRODUCT_NAME
        ,S.PRODUCT_ID
        ,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT AS AMOUNT_
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2 AS AMOUNT2_
        ,SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT) AS AMOUNT
        ,SUM(SEVKIYAT_SEPET_ROW_READ_PBS.AMOUNT2) AS AMOUNT2
    FROM w3Toruntex_1.SEVKIYAT_SEPET_ROW_PBS
    LEFT JOIN w3Toruntex_1.SEVKIYAT_SEPET_ROW_READ_PBS ON SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID = SEVKIYAT_SEPET_ROW_READ_PBS.SEPET_ROW_ID
    LEFT JOIN w3Toruntex_1.STOCKS AS S ON S.PRODUCT_ID = SEVKIYAT_SEPET_ROW_PBS.PRODUCT_ID
    WHERE SEVKIYAT_SEPET_ROW_PBS.SEPET_ID = #SEPET_ID#
    GROUP BY S.PRODUCT_NAME
        ,S.PRODUCT_ID
        ,SEVKIYAT_SEPET_ROW_PBS.SEPET_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.WRK_ROW_ID
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT
        ,SEVKIYAT_SEPET_ROW_PBS.AMOUNT2
        </cfquery>
         <cfquery name="getO" datasource="#dsn3#">
            SELECT PRODUCT_ID FROM ORDER_ROW WHERE ORDER_ID=#ORDER_ID#
        </cfquery>
        <cfset vls=valueList(getO.PRODUCT_ID)>
        <cfoutput query="GETDATA">
            <tr <cfif not listFind(vls,PRODUCT_ID)>class="bg-danger"<cfelse><cfif AMOUNT2 eq AMOUNT2_>class="bg-success"<cfelseif AMOUNT2 gt AMOUNT2_>class="bg-primary"  </cfif> </cfif>  data-PRODUCT_ID='#PRODUCT_ID#' data-SEPET_ROW_ID="#SEPET_ROW_ID#"> 
                <td id="AMOUNT_#PRODUCT_ID#">
                    
                    <cfif len(AMOUNT)>#AMOUNT#<CFELSE>0</cfif>/ #AMOUNT_#
                </td>
                <td id="AMOUNT2_#PRODUCT_ID#">
                    <cfif len(AMOUNT2)>#AMOUNT2#<CFELSE>0</cfif> / #AMOUNT2_#
                </td>
                <td id="PRODUCT_NAME_#PRODUCT_ID#">
                    #PRODUCT_NAME#
                </td>
            </tr>
        </cfoutput>
    </table>
    </cf_box>
    <script src="/AddOns/Partner/js/sevkiyat.js"></script>
