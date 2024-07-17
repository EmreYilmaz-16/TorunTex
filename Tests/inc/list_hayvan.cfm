<cfquery name="getAnimals" datasource="#dsn3#">
    SELECT * FROM CIFTLIK_HAYVANLARIM2
</cfquery>

<cf_big_list>
    <tr>
        <th>
            Küpe No
        </th>
        <th>
            Cins
        </th>
        <th>
            Sürü Ekleme Tarihi
        </th>
        <th>
            Son Tohumlama Tarihi
        </th>
        <th>
            TGS
        </th>
        <th>
            Çiftlik / Padok
        </th>
        <th></th>
    </tr>
    <cfoutput query="getAnimals">
        <tr>
            <td>#LOT_NO#</td>
            <td>#PROPERTY#</td>
            <td>#dateformat(SURU_GIRIS_DATE,"dd/mm/yyyy")#</td>
            <td>#dateformat(TOHUMLAMA_DATE,"dd/mm/yyyy")#</td>
            <td>#TAHMINI_GEBELIK_SURESI#</td>
            <td>#CIFTLIK_T# / #PADOK_T#</td>
            <td><a href="javascript://" onclick="windowopen('/index.cfm?fuseaction=#attributes.fuseaction#&sayfa=54&iid=#HAYVAN_ID#','wide')"></a></td>
        </tr>
    </cfoutput>
</cf_big_list>