<cfparam name="attributes.sayfa" default="-1">
<cfif not isDefined("attributes.default_style")>
<cfif not isDefined("attributes.isAjax") or attributes.isAjax neq 1>
    <script src="/AddOns/Partner/js/datetime.1-3.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</cfif>
</cfif>
<cfif attributes.sayfa eq "vt"><cfinclude template="inc/VtSorgu.cfm"><cfabort></cfif>                       <!--- //BILGI VERİ TABANI SORGU GÖNDERME  -----> 
<cfif attributes.sayfa eq "git"><cfinclude template="inc/git_puller.cfm"><cfabort></cfif>                   <!--- //BILGI GİTTEN DEĞİŞİKLİKLERİ ALIR ----->
<cfif attributes.sayfa eq "ex"><cfinclude template="inc/ExCellAktar.cfm"><cfabort></cfif>                   <!--- //BILGI İLİŞKİLİ ÜRÜN AKTARIM ----->
<cfif attributes.sayfa eq "pu"><cfinclude template="inc/importProductUnit.cfm"><cfabort></cfif>             <!--- //BILGI ÜRÜN BİRİM AKTARIMI İÇİN KULLANILDI ----->
<cfif attributes.sayfa eq "fe"><cfinclude template="../Admin/folder_explorer.cfm"><cfabort></cfif>          <!--- //BILGI DOSYA YÖNETİCİSİ ----->
<cfif attributes.sayfa eq "vtAdd"><cfinclude template="inc/vtAdd.cfm"><cfabort></cfif>                      <!--- //BILGI VERİ TABANINA FORM TADINDA VERİ YAZMA ----->
<cfif attributes.sayfa eq "query_executer"><cfinclude template="inc/query_executer.cfm"><cfabort></cfif>    <!--- //BILGI PBS JS QUERY ----->
<cfif attributes.sayfa eq "fis_sil"><cfinclude template="inc/stokFisSil.cfm"><cfabort></cfif>               <!--- //BILGI tüm stok fişlerini siler ----->

<cfif attributes.sayfa eq -1><cfinclude template="inc/Welcome.cfm"><cfabort></cfif>


<cfif attributes.sayfa eq 1><cfinclude template="inc/RafToElleForm.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 2><cfinclude template="inc/RafToElleList.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 3><cfinclude template="inc/RafToEllePopup.cfm"><cfabort></cfif>
<!---
<cfif attributes.sayfa eq 4><cfinclude template="inc/EllecToYM.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 5><cfinclude template="inc/MasaSevk.cfm"><cfabort></cfif>---->

<cfif attributes.sayfa eq 6><cfinclude template="inc/rafDurumu.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 7><cfinclude template="inc/MasaGonderPopup.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 8><cfinclude template="inc/OperatorEkrani.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 9><cfinclude template="inc/OperatorEkrani_2.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq "9_2"><cfinclude template="inc/OperatorEkrani_3.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq "9_3"><cfinclude template="inc/OperatorEkrani_4.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 10><cfinclude template="inc/logInEmployee.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 11><cfinclude template="inc/istasyonUretim.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 12><cfinclude template="inc/digerSiparis.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 13><cfinclude template="inc/CuvalTasi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 14><cfinclude template="inc/CuvalTasiQuery.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 15><cfinclude template="inc/LotHareket.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 16><cfinclude template="inc/siparisList.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 17><cfinclude template="inc/duyuruGoster.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 18><cfinclude template="inc/etiket_2.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 19><cfinclude template="inc/sip_depo.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 20><cfinclude template="inc/ip_adres_list.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 21><cfinclude template="inc/ip_address_add_update.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 22><cfinclude template="inc/Sevkiyat.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 23><cfinclude template="inc/Sevkiyat_2.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 24><cfinclude template="inc/Sevkiyat_2_UPD.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 25><cfinclude template="inc/sevkiyatListesi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 26><cfinclude template="inc/sayim_main.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 27><cfinclude template="inc/faturaKesHazirlik.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 28><cfinclude template="inc/addRelatedProjectInvoice.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 29><cfinclude template="inc/sevkMain.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 30><cfinclude template="inc/sevkCikar.cfm"><cfabort></cfif>
<!---<cfif attributes.sayfa eq 31><cfinclude template="inc/tasimaYeni.cfm"><cfabort></cfif>--->
<cfif attributes.sayfa eq 32><cfinclude template="inc/FaturaFis.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 33><cfinclude template="inc/RafToElle_yeni.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 34><cfinclude template="inc/antrepo_urun_sec.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 35><cfinclude template="inc/RafElleYeni_QUERY.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 36><cfinclude template="inc/ithal_mal_girisi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 37><cfinclude template="inc/invoice_row_sec.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 38><cfinclude template="inc/ithalgirisQuery.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 39><cfinclude template="inc/sayim_2.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 40><cfinclude template="inc/faturakes_ss.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 41><cfinclude template="inc/depo_rel_id_aktarim.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 42><cfinclude template="inc/fatura_print.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 43><cfinclude template="inc/SiparisListesi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 44><cfinclude template="inc/SearchSku.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 45><cfinclude template="inc/getLotDetay.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 46><cfinclude template="inc/dashboard.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 47><cfinclude template="inc/urun_etiket.cfm"><cfabort></cfif>

<cfif attributes.sayfa eq 48><cfinclude template="../Ciftlik/Form/add_animal.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 49><cfinclude template="inc/canli_hayvan_ithal_mal_girisi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 50><cfinclude template="inc/import_hayvan.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 51><cfinclude template="inc/ithalHayvangirisQuery.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 52><cfinclude template="inc/import_hayvan_ozellik.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 53><cfinclude template="inc/list_hayvan.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 54><cfinclude template="inc/update_hayvan.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 55><cfinclude template="../Ciftlik/Display/Sevkiyat.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 56><cfinclude template="../Ciftlik/Display/sevkMain.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 57><cfinclude template="../Ciftlik/Form/Sevkiyat_2.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 58><cfinclude template="../Ciftlik/Form/Sevkiyat_2_UPD.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 59><cfinclude template="inc/import_hayvan_sevkiyat.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 60><cfinclude template="inc/TopluHayvanGirisi.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 61><cfinclude template="inc/TopluHayvanMilli.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 62><cfinclude template="inc/HayvanAktar.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 63><cfinclude template="inc/SiparisLotDetay.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 64><cfinclude template="inc/TopluTasima.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 65><cfinclude template="inc/sku_toplu_tasima.cfm"><cfabort></cfif>
<cfif attributes.sayfa eq 67><cfinclude template="inc/StokRaporu.cfm"></cfif>
<cfif attributes.sayfa eq "CiftlikWelcome"><cfinclude template="inc/Ciftlik_welcome.cfm"><cfabort></cfif>


<cfif not isDefined("attributes.default_style")>
<cfif not isDefined("attributes.isAjax") or attributes.isAjax neq 1>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</cfif>
</cfif>


