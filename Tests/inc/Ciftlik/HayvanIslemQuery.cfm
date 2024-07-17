<cfstoredproc procedure="HAYVAN_ISLEM" datasource="#dsn3#">
    <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.HAYVAN_ID#">
    <cfif len(attributes.GEBELIK_DATE)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.GEBELIK_DATE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfprocparam cfsqltype="cf_sql_bit" value="#attributes.G_IS_ACTIVE#">
    <cfif len(attributes.AGIRLIK_DATE)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.AGIRLIK_DATE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.AGIRLIK)>    
        <cfprocparam cfsqltype="cf_sql_float" value="#attributes.AGIRLIK#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_float" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.AGIRLIK)>    
        <cfprocparam cfsqltype="cf_sql_float" value="#attributes.AGIRLIK#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_float" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.KONTROL_DATE)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.KONTROL_DATE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.KONTROL)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.KONTROL#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.TEDAVI_DATE)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.TEDAVI_DATE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.TEDAVI)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.TEDAVI#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.TOHUMLAMA_DATE)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.TOHUMLAMA_DATE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.T_ADET)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.T_ADET#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.BIRTH_DATE)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.BIRTH_DATE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.COUNTRY)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.COUNTRY#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.GENDER)>    
        <cfprocparam cfsqltype="cf_sql_bit" value="#attributes.GENDER#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_bit" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.F_KIMLIK_NO)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.F_KIMLIK_NO#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.A_KIMLIK_NO)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.A_KIMLIK_NO#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.B_KIMLIK_NO)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.B_KIMLIK_NO#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.HTIP)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.HTIP#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.SURU_AGIRLIK)>    
        <cfprocparam cfsqltype="cf_sql_float" value="#attributes.SURU_AGIRLIK#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_float" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.TASMA_ID)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.TASMA_ID#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.TASMA_ETIKET)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.TASMA_ETIKET#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.BEKLENEN_HAMILELIK)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.BEKLENEN_HAMILELIK#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.LAKTASYON_GUNU)>    
        <cfprocparam cfsqltype="cf_sql_varchar" value="#attributes.LAKTASYON_GUNU#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_varchar" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.LAKTASYON_SAYI)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.LAKTASYON_SAYI#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.SON_KURU_TARIH)>    
        <cfprocparam cfsqltype="cf_sql_timestamp" value="#attributes.SON_KURU_TARIH#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_timestamp" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.GUNLUK_HAREKET)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.GUNLUK_HAREKET#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.GUNLUK_DINLENME)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.GUNLUK_DINLENME#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.GUNLUK_BESLENME)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.GUNLUK_BESLENME#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.GUNLUK_GEVIS_SURE)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.GUNLUK_GEVIS_SURE#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.SAGLIK_ORANI)>    
        <cfprocparam cfsqltype="cf_sql_float" value="#attributes.SAGLIK_ORANI#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_float" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.KIZGINLIK_INDEXI)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.KIZGINLIK_INDEXI#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>
    <cfif len(attributes.SON_KIZGINLIK_TARIHI)>    
        <cfprocparam cfsqltype="cf_sql_integer" value="#attributes.SON_KIZGINLIK_TARIHI#">
    <cfelse>
        <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
    </cfif>

</cfstoredproc>