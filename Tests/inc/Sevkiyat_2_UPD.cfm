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
    <table class="table table-sm table-stripped">
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
        <cfoutput query="GETDATA">
            <tr>
                <td data-sepet_row="#SEPET_ROW_ID#" data-PRODUCT_ID='#PRODUCT_ID#'>
                    #AMOUNT# / #AMOUNT_#
                </td>
                <td>
                    #AMOUNT2# / #AMOUNT2_#
                </td>
                <td>
                    #PRODUCT_NAME#
                </td>
            </tr>
        </cfoutput>
    </table>
    </cf_box>
    <script src="/AddOns/Partner/js/sevkiyat.js"></script>