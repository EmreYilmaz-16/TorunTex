<cfquery name="gets" datasource="#dsn2#">
 SELECT SFR.AMOUNT,C.NICKNAME ,SL.COMMENT,O.ORDER_NUMBER,S.PRODUCT_NAME FROM w3Toruntex_2023_1.STOCK_FIS_ROW AS SFR
 LEFT JOIN w3Toruntex_2023_1.STOCK_FIS AS SF ON SF.FIS_ID=SFR.FIS_ID
 INNER JOIN w3Toruntex_2023_1.STOCKS_ROW AS SR ON SR.PBS_RELATION_ID=SFR.PBS_RELATION_ID AND SFR.FIS_ID =SR.UPD_ID
INNER JOIN w3Toruntex_1.ORDER_ROW AS ORR ON ORR.WRK_ROW_ID=SR.PBS_RELATION_ID
INNER JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
INNER JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID =O.COMPANY_ID
INNER JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=SR.STORE AND SL.LOCATION_ID=SR.STORE_LOCATION
INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID
WHERE SR.PROCESS_TYPE=110 AND SFR.PBS_RELATION_ID IS NOT NULL
AND SL.DEPARTMENT_ID=#attributes.DEPARTMENT_ID# AND SL.LOCATION_ID=#attributes.LOCATION_ID#
</cfquery>

<cf_grid_list>
  <thead>
    <tr>
        <th>
            Ürün
        </th>
        <th>
            Müşteri
        </th>
        <th>Sipariş No</th>
        <th>
            Miktar
        </th>
    </tr>
</thead>
<tbody>
    <cfoutput query="gets">
        <tr>
            <td>#PRODUCT_NAME#</td>
            <td>#NICKNAME#</td>            
            <td>#ORDER_NUMBER#</td>
            <td>#AMOUNT#</td>
        </tr>
    </cfoutput>
</tbody>
</cf_grid_list>