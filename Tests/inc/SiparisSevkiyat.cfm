<!--- Siparişleri Listeleme --->
<cfquery name="orders" datasource="#DSN2#">
    SELECT 
ORDER_ID
,SIP_NO
,ONCELIK
,SEVK_TARIHI
,MUSTERI
,ASAMA
,DEPO
,SUM(SIPARIS_KG) AS SIPARIS_KG
,SUM(URETILEN_KG) AS URETILEN_KG
    
    FROM DBO.A_ORDERS --WHERE ORDER_ID >= 512 AND ORDER_ID < 514
    GROUP BY 
ORDER_ID
,SIP_NO
,ONCELIK
,SEVK_TARIHI
,MUSTERI
,ASAMA
,DEPO


ORDER BY SEVK_TARIHI DESC, ONCELIK, MUSTERI

</cfquery>

<!--- Form Gönderildiğinde Güncelleme İşlemi --->
<cfif structKeyExists(form, "updateAll")>
    <cfloop query="orders">
        <cfquery datasource="#DSN2#">
            UPDATE w3toruntex_1.orders
            SET 
                COMPANY_ID = <cfqueryparam value="#form['COMPANY_ID_' & orders.ORDER_ID]#" cfsqltype="cf_sql_varchar">,
                SHIP_DATE = <cfqueryparam value="#form['SHIP_DATE_' & orders.ORDER_ID]#" cfsqltype="cf_sql_date">,
                ORDER_NUMBER = <cfqueryparam value="#form['ORDER_NUMBER_' & orders.ORDER_ID]#" cfsqltype="cf_sql_varchar">
            WHERE ORDER_ID = <cfqueryparam value="#orders.ORDER_ID#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfloop>
    <cfset location(url="#request.self#?fuseaction=sales.list_order_shipping")>
</cfif>

<head>
    <title>YÜKLEME TAKİBİ</title>

    <!-- jQuery Kütüphanesi -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- jQuery UI Kütüphanesi ve CSS Dosyası -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Takvim İçin CSS -->
    <style>
        .ui-datepicker { z-index: 10000 !important; }
    </style>
    <script>
        $(function() {
            $(".datepicker").datepicker({
                dateFormat: "yy-mm-dd"
            });
        });
    </script>
</head>
<body>

<cf_box title="Sevkiyat Listesi" uidrop="1" hide_table_column="1" refresh=1>

<div>
    <cf_grid_list>
        <thead>
            <tr>
                <th>S.No<cf_get_lang dictionary_id='58577.Sira'></th>
                <th>Öncelik</th>
                <th>Yükleme Tarihi</th>
                <th>Müşteri</th>
                <th>Aşama</th>
                <th>Depo</th>
                <th>Sipariş Kg</th>
                <th>Üretilen Kg</th>

            </tr>
        </thead>
        
        <tbody>
            <form method="post" action="#request.self#?fuseaction=sales.list_order_shipping">
                <cfoutput query="orders">
                    <tr>
                        <td>#orders.SIP_NO#</td>
                        <td>#orders.ONCELIK#</td>
                        <td><input type="text" class="datepicker" name="SEVK_TARIHI_#orders.ORDER_ID#" value="#dateFormat(orders.SEVK_TARIHI, 'yyyy-mm-dd')#"></td>

                        <td>#orders.MUSTERI#</td>
                        <td>#orders.ASAMA#</td>
                        <td>#orders.DEPO#</td>
                        <td>#orders.SIPARIS_KG#</td>
                        <td>#orders.URETILEN_KG#</td>




                    </tr>
                </cfoutput>
                <tr>
                    <td colspan="5" style="text-align: center;">
                        <input type="submit" name="updateAll" value="Tümünü Güncelle">
                    </td>
                </tr>
            </form>
        </tbody>
    </cf_grid_list>

</div>

</cf_box>

</body>
