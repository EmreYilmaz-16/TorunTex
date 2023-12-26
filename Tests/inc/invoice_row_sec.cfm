<cfparam name="attributes.INVOICE_ID"  default="24">
<cfquery name="getIvr" datasource="#dsn2#">
    SELECT *
	,ISNULL(AMOUNT, 0) - ISNULL(AC, 0) AS KALAN
	,ISNULL(AMOUNT2, 0) - ISNULL(AC2, 0) AS KALAN2
FROM (
	SELECT INVOICE_NUMBER
		,I.INVOICE_ID
		,IR.AMOUNT
		,IR.AMOUNT2
		,I.PROCESS_STAGE
		,S.STOCK_ID
		,S.PRODUCT_CODE_2
		,S.PRODUCT_NAME
		,IR.WRK_ROW_ID
		,(
			SELECT SUM(AMOUNT)
			FROM w3Toruntex_2023_1.SHIP_ROW AS SR
			INNER JOIN w3Toruntex_2023_1.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
			WHERE 1 = 1
				AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
				AND S.SHIP_TYPE = 811
			) AS AC
		,(
			SELECT SUM(AMOUNT2)
			FROM w3Toruntex_2023_1.SHIP_ROW AS SR
			INNER JOIN w3Toruntex_2023_1.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
			WHERE 1 = 1
				AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
				AND S.SHIP_TYPE = 811
			) AS AC2
	FROM w3Toruntex_2023_1.INVOICE AS I
	INNER JOIN w3Toruntex_2023_1.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
	INNER JOIN w3Toruntex_1.STOCKS AS S ON S.STOCK_ID = IR.STOCK_ID
	WHERE INVOICE_CAT = 591
		--    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
	) AS IRRS
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
                    #AMOUNT#
                </td>
                <td>
                    #AMOUNT2#
                </td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="SatirEkle(#INVOICE_ID#,#STOCK_ID#,'#WRK_ROW_ID#')">Seç</button>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</cf_big_list>

