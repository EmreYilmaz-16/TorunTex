<style>

    .guncelle-butonu {
        font-weight: bold; 
    }
    tr.highlight-row td {
        background-color: #b1ff9e;
        font-weight:bold;
    }

   
    
</style>
    <cfquery name="orders" datasource="#DSN2#">
        SELECT 
            ORDER_ID,
            SIP_NO as ORDER_NUMBER,
            ONCELIK,
            SEVK_TARIHI as SHIP_DATE,
            CASE WHEN SEVK_TARIHI IS NOT NULL THEN 1 ELSE 0 END AS SEVK,
            MUSTERI,
            RENK,
            ASAMA,
            DEPO,
            SUM(ISNULL(SIPARIS_KG,0)) AS SIPARIS_KG,
            SUM(ISNULL(URETILEN_KG,0)) AS URETILEN_KG,
            ROUND(SUM(ISNULL(URETILEN_KG,0))/SUM(ISNULL(SIPARIS_KG,1)),2)*100 AS DOLULUK
        FROM DBO.A_ORDERS 
        
        GROUP BY 
            ORDER_ID,
            SIP_NO,
            ONCELIK,
            SEVK_TARIHI,
            MUSTERI,
            RENK,
            ASAMA,
            DEPO
        ORDER BY SEVK DESC, SEVK_TARIHI , ONCELIK, MUSTERI
    </cfquery>
    
    
    <!--- Form Gönderildiğinde Güncelleme İşlemi --->
    <cfif structKeyExists(form, "updateAll")>
    
        <cfoutput query="orders">
            <cfquery datasource="#DSN2#">
                UPDATE w3toruntex_1.orders
                SET 
                    SHIP_DATE = <cfqueryparam value="#form['SHIP_DATE_' & orders.ORDER_ID]#" cfsqltype="cf_sql_date">
                WHERE ORDER_ID = <cfqueryparam value="#orders.ORDER_ID#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfoutput>
    
    
        <!--- Sayfayı yenilemek için yönlendirme --->
        <cflocation url="#request.self#?fuseaction=sales.list_order_shipping" addToken="false">
    </cfif>
    
    <head>
        <title>Yükleme Takibi</title>
    </head>
    <body>
    
    <cf_box title="Sevkiyat Listesi" uidrop="1" hide_table_column="1" >
    
    <div>
        <cf_grid_list>
            <thead>
                <tr>
                    <th>S.No<cf_get_lang dictionary_id='58577.Sira'></th>
                        <th>Öncelik</th>
                        <th>Yükleme Tarihi</th>
                        <th>Doluluk Oranı</th>
                        <th>Müşteri</th>
                        <th>Renk</th>
                        <th>Aşama</th>
                        <th>Depo</th>
                        <th>Sipariş Kg</th>
                        <th>Üretilen Kg</th>
                        <th>Acente</th>
                        <th>Araç Türü</th>
                </tr>
            </thead>
            
            <tbody>
                <form method="post">
                    <cfoutput query="orders">
                        <tr class="<cfif NOT isNull(orders.SHIP_DATE) AND len(trim(orders.SHIP_DATE)) GT 0>highlight-row</cfif>">
                            <td>#orders.ORDER_NUMBER#</td>
                            <td>#orders.ONCELIK#</td>
                            <td><input type="date"  name="SHIP_DATE_#orders.ORDER_ID#" value="#dateFormat(orders.SHIP_DATE, 'yyyy-mm-dd')#"></td>
                            <td style="text-align: right">#orders.DOLULUK# %</td>
                            <td>#orders.MUSTERI#</td>
                            <td>#orders.RENK#</td>
                            <td>#orders.ASAMA#</td>
                            <td>#orders.DEPO#</td>
                            <td>#orders.SIPARIS_KG#</td>
                            <td>#orders.URETILEN_KG#</td>
                            <td>-</td>
                            <td>-</td>
                        </tr>
                    </cfoutput>
    
    
    
                    <tr>
                        <td colspan="11" style="text-align: center; font-weight: bold;">
    
                            <input type="submit" class="guncelle-butonu" name="updateAll" value="Tümünü Güncelle">
                        </td>
                    </tr>
                </form>
            </tbody>
        </cf_grid_list>
    
    </div>
    
    </cf_box>
    
    </body>
    