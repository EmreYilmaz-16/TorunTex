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
        var pw=document.getElementById("CardId").value
        var R=null;
        if(ev.type=='click'){
             R=wrk_query("select EMPLOYEE_NAME,EMPLOYEE_SURNAME,EMPLOYEE_ID from w3Toruntex.EMPLOYEES where OZEL_KOD2='"+pw+"'","dsn")
        }else{
            if(ev.keyCode==13){
                R=wrk_query("select EMPLOYEE_NAME,EMPLOYEE_SURNAME,EMPLOYEE_ID from w3Toruntex.EMPLOYEES where OZEL_KOD2='"+pw+"'","dsn")
            }
        }
        var LoginnedEmployee={
            EMPLOYEE_ID:R.EMPLOYEE_ID[0],
            EMPLOYEE_NAME:R.EMPLOYEE_NAME[0],
            EMPLOYEE_SURNAME:R.EMPLOYEE_SURNAME[0]
        };
        localStorage.setItem("LoginnedEmployee",JSON.stringify(LoginnedEmployee))
    }
</script>

</cf_box>