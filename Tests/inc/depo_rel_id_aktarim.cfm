<cf_box title="RELATION ID Aktarım">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=41">
  <table> 
    <tr>
        <td>
            <div class="form-group">
                <label>Sipariş</label>
                <cfquery name="getOrders" datasource="#dsn3#">
                    SELECT * FROM ORDERS WHERE ORDER_STAGE <>262
                </cfquery>
                <select name="OrderData" id="OrderData" required>
                    <option value="">Seçiniz</option>
                    <cfoutput query="getOrders">
                        <option value="#ORDER_ID#|#DELIVER_DEPT_ID#|#LOCATION_ID#">#ORDER_NUMBER#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>
            <input type="hidden" name="is_submit" value="1">
            <button type="submit" class="btn btn-success">Aktarıma Başla</button>
        </td>
    </tr>
  </table>

</cfform>

<cfif isDefined("attributes.is_submit")>
    <cfquery name="getO" datasource="#dsn3#">
        SELECT * FROM ORDER_ROW WHERE ORDER_ID=#listGetAt(attributes.OrderData,1,"|")#
    </cfquery>
    <cfoutput query="getO">
        <cfquery name="GETR" datasource="#DSN2#">
            SELECT * FROM STOCKS_ROW WHERE STORE=#listGetAt(attributes.OrderData,2,"|")# AND STORE_LOCATION=#listGetAt(attributes.OrderData,3,"|")#
            AND STOCK_ID=#getO.STOCK_ID# AND UNIT2='#UNIT2#'
        </cfquery>
          <cfdump var="#GETR#">
        <CFIF GETR.recordCount>
          
            <cfloop query="GETR">
                <cfquery name="Up" datasource="#dsn2#">
                    UPDATE STOCKS_ROW SET PBS_RELATION_ID='#getO.WRK_ROW_ID#' WHERE STOCKS_ROW_ID=#GETR.TOCKS_ROW_ID#
                </cfquery>
            </cfloop>
        </CFIF>
    </cfoutput>
</cfif>
</cf_box>