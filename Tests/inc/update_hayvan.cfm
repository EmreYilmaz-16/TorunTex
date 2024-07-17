<cfquery name="GetAnimalTypes" datasource="#dsn3#">
    select STOCK_ID,PRODUCT_NAME,PRODUCT_ID,PROPERTY from w3Toruntex_1.STOCKS WHERE PRODUCT_CODE LIKE '01H.%' AND PROPERTY <>''
</cfquery>
<cfquery name="Hayvan_Tip" datasource="#dsn1#">
    SELECT  HTIP_ID
      ,TIP
  FROM CIFTLIK_HAYVAN_TIP

</cfquery>
<cfdump var="#attributes#">
<cfform>
<input type="hidden" name="HAYVAN_ID" value="<cfoutput>#attributes.iid#</cfoutput>">
    <cf_tab defaultOpen="sayfa_1" divId="sayfa_1,sayfa_2,sayfa_3,sayfa_4,sayfa_5,sayfa_6" divLang="Genel Bilgiler;Tohumlama- Gebelik;Süt Verim;Ağırlık Bilgileri;Kontrol;Tedavi">
        <div id="unique_sayfa_1" class="ui-info-text uniqueBox">
            <table>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Küpe No</label>
                            <input type="text" name="LOT_NO">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Boğa Küpe No</label>
                            <input type="text" name="B_KULAK_NO">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Anne Küpe No</label>
                            <input type="text" name="A_KULAK_NO">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Baba Küpe No</label>
                            <input type="text" name="F_KULAK_NO">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Ülke</label>
                            <input type="text" name="COUNTRY">
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Cinsiyeet</label>
                            <select name="GENDER">
                                <option value="0">Dişi</option>
                                <option value="1">Erkek</option>
                            </select>
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label>Cins</label>
                            <select name="TIP">
                                <cfoutput query="Hayvan_Tip" >
                              
                                            <option value="#HTIP_ID#">#TIP#</option>
                                       
                                </cfoutput>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="unique_sayfa_2" class="ui-info-text uniqueBox">
            <h1>Lorem Ipsum 2</h1>
            <p>Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500 lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.</p>
        </div>
        <div id="unique_sayfa_3" class="ui-info-text uniqueBox">
            <h1>Lorem Ipsum 3</h1>
            <p>Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500 lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.</p>
        </div>
        <div id="unique_sayfa_4" class="ui-info-text uniqueBox">
            <h1>Lorem Ipsum 4</h1>
            <p>Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500 lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.</p>
        </div>
        <div id="unique_sayfa_5" class="ui-info-text uniqueBox">
            <h1>Lorem Ipsum 5</h1>
            <p>Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500 lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960 larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.</p>
        </div>
           <div id="unique_sayfa_6" class="ui-info-text uniqueBox">
            <table>
                <tr>
                    <td>
                        <div class="form-group">
                            <label>Sürü Katılım Ağırlığı</label>
                            <input type="text" name="SURU_AGIRLIK">
                        </div>
                    </td>
                    <td>
                        <div>
                            Son Ağırlık
                        </div>
                        <table>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <label>Tartim Tarihi</label>
                                        <input type="text" name="TARTIM_DATE">
                                    </div>
                                </td>
                                <td>
                                    <div class="form-group">
                                        <label>Tartim KG</label>
                                        <input type="text" name="AGIRLIK">
                                    </div>
                                </td>
                            </tr>
                        </table>
                     
                    </td>
                </tr>
            </table>
        </div>
    </cf_tab>


</cfform>