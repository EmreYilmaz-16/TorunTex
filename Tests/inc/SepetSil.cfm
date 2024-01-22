<cfquery name="gets" datasource="#dsn3#">
SELECT * FROM(
SELECT SEVK_NO,SEVKIYAT_SEPET_PBS.ORDER_ID,O.ORDER_NUMBER,C.NICKNAME,SC.COUNTRY_NAME,SL.COMMENT,SEVKIYAT_SEPET_PBS.SEPET_ID,
(SELECT COUNT(*) FROM w3Toruntex_1.SEVKIYAT_SEPET_ROW_READ_PBS WHERE SEPET_ROW_ID IN (SELECT SEPET_ROW_ID FROM w3Toruntex_1.SEVKIYAT_SEPET_ROW_PBS
WHERE SEPET_ID=SEVKIYAT_SEPET_PBS.SEPET_ID)) AS CC
 FROM w3Toruntex_1.SEVKIYAT_SEPET_PBS LEFT JOIN w3Toruntex_1.ORDERS AS O ON O.ORDER_ID=SEVKIYAT_SEPET_PBS .ORDER_ID
LEFT JOIN w3Toruntex.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID
LEFT JOIN w3Toruntex.SETUP_COUNTRY AS SC ON SC.COUNTRY_ID=C.COUNTRY
LEFT JOIN w3Toruntex.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SEVKIYAT_SEPET_PBS.LOCATION_ID AND SL.DEPARTMENT_ID=SEVKIYAT_SEPET_PBS.DEPARTMENT_ID
) AS RT WHERE CC=0 OR ORDER_NUMBER IS NULL
</cfquery>

<cf_box title="Silinebilir Sevkiyat Belgeleri">

    <cf_grid_list>
        <thead>
            <tr>
                <th>
                    Sevk No
                </th>
                <th>
                    Sipariş No
                </th>
                <th>
                    Müşteri
                </th>			
                <th>
                    Ülkesi
                </th>
                <th>
                    Depo
                </th>
                <th>İrsaliyler</th>
                <th colspan="2">
    
                </th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="getSepetler">
            <tr>
                <td>
                    #SEVK_NO#
                </td>
                <td>
                    #ORDER_NUMBER#
                </td>
                <td>
                    #NICKNAME#
                </td>
                <td>
                    #COUNTRY_NAME#
                </td>
                <td>
                    #COMMENT#
                </td>                                             
                <td>
                    <button type="button" onclick="Sil(#SEPET_ID#)" class="btn btn-danger">Sil</button>
                </td>
            </tr>
        </cfoutput>
        </tbody>
    </cf_grid_list>
    
    
</cf_box>