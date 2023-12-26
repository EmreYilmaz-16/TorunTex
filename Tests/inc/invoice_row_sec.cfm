<cfparam name="attributes.INVOICE_ID"  default="24">
<cfquery name="getIvr" datasource="#dsn2#">
    SELECT WRK_ROW_ID,AMOUNT,AMOUNT2,UNIT,UNIT2,S.PRODUCT_CODE_2,S.PRODUCT_NAME FROM INVOICE_ROW AS IR
    INNER JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=IR.STOCK_ID
     WHERE INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>

<cf_big_list>
    <thead>
        <tr>
            <th>
                Ürün Kodu
            </th>
            <th>
                Ürün
            </th>
            <th>
                Miktar
            </th>
            <th>
                Miktar2
            </th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="getIvr">
            <tr>
                <td>
                    #PRODUCT_CODE_2#
                </td>
                <td>
                    #PRODUCT_NAME#
                </td>
                <td>
                    #AMOUNT2#
                </td>
                <td>
                    #AMOUNT2#
                </td>
            </tr>
        </cfoutput>
    </tbody>
</cf_big_list>