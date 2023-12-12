<style>
.btnBoy{
    width:25%;
    left:40%
}
    @media screen and (max-width: 600px) {
        .btnBoy{
    width:100%;
    left:0px
}
}
</style>
<div class="btnBoy" style="position: fixed;top: 50%;bottom: 50%;background: aliceblue;height: 150px;">
   <cfoutput> <button class="btn form-control btn-lg btn-success" onclick="window.location.href='/index.cfm?fuseaction=settings.emptypopup_partner_test_page&sayfa=24&SELECT1=#attributes.SELECT1#'" style="font-size: 30pt;">
        Ekle
    </button>
    
    <button class="btn form-control btn-lg btn-danger" style="font-size: 30pt;">
        Çıkar
    </button>
</cfoutput>
    </div>