﻿<cfparam name="attributes.INVOICE_ID"  default="24">
<cfquery name="getIvr" datasource="#dsn2#">
    SELECT *
	,ISNULL(AMOUNT, 0) - ISNULL(AC, 0) AS KALAN
	,ISNULL(AMOUNT2, 0) - ISNULL(AC2, 0) AS KALAN2
FROM (
	SELECT INVOICE_NUMBER
		,I.INVOICE_ID
        ,YEAR(I.INVOICE_DATE) AS IV_DATE
		,IR.AMOUNT
		,IR.AMOUNT2
		,I.PROCESS_STAGE
		,S.STOCK_ID
        ,S.PRODUCT_ID
		,S.PRODUCT_CODE_2
		,S.PRODUCT_NAME
		,IR.WRK_ROW_ID
        ,IR.LOT_NO
		,(
			SELECT SUM(AMOUNT)
			FROM #dsn2#.SHIP_ROW AS SR
			INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
			WHERE 1 = 1
				AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
				AND S.SHIP_TYPE = 811
			) AS AC
		,(
			SELECT SUM(ISNULL(AMOUNT2,0))
			FROM #dsn2#.SHIP_ROW AS SR
			INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
			WHERE 1 = 1
				AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
				AND S.SHIP_TYPE = 811
			) AS AC2
	FROM #dsn2#.INVOICE AS I
	INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
	INNER JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID = IR.STOCK_ID
	WHERE INVOICE_CAT = 591
		--    AND ISNULL(I.PROCESS_STAGE, 0) <> 258
	) AS IRRS
    WHERE INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>

<cf_big_list>
    <thead>
        <tr>
           
            <th>
                Ürün
            </th>
            <th>
                AMOUNT
            </th>
            <th>
                Miktar2
            </th>
            <th>
                Miktar
            </th>
            <th>
                Miktar2
            </th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="getIvr">
            <tr>
               
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
                    #KALAN#
                </td>
                <td>
                    #KALAN2#
                </td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="SatirEkle(#INVOICE_ID#,#STOCK_ID#,#PRODUCT_ID#,'#WRK_ROW_ID#',#AMOUNT#,#AMOUNT2#,'#KALAN2#','#PRODUCT_NAME#','#PRODUCT_CODE_2#','#LOT_NO#',#IV_DATE#)">Seç</button>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</cf_big_list>

