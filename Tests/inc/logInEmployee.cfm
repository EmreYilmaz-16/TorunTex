<cf_box>
<div class="form-group">
    <label>Şifre</label>
    <div class="input-group">
        <input type="text" class="form-control form-control-lg" id="CardId" onkeyup="LogIn(event)">
        <button class="btn btn-outline-success" onclick="LogIn(event)" type="button" id="button-addon2"><span class="icn-md icon-remove"></span></button>
    </div>
</div>
<div id="ResArea" style="color:red"></div>
<div id="Stations">

</div>

<button type="button" class="btn btn-danger" onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')">VAZGEÇ</button>

<script>
    function LogIn(ev){
        console.log(ev);
    }
</script>

</cf_box>