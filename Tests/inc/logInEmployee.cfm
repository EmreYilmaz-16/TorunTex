<cf_box>
<div class="form-group">
    <label>Şifre</label>
    <div class="input-group">
        <input type="text" class="form-control form-control-lg" id="CardId" onkeyup="LogIn(event)">
        <button class="btn btn-outline-success" onclick="LogIn(event)" type="button" id="button-addon2"><span class="icn-md icon-remove"></span></button>
    </div>
</div>
<div id="ResArea" style="color:red;height:3vh"></div>
<div id="Stations" style="height:10vh">

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
     
        console.log(R);
        if(R.recordcount>0){
           var LoginnedEmployee={
            EMPLOYEE_ID:R.EMPLOYEE_ID[0],
            EMPLOYEE_NAME:R.EMPLOYEE_NAME[0],
            EMPLOYEE_SURNAME:R.EMPLOYEE_SURNAME[0]
        };
            localStorage.setItem("ACTIVE_USER",JSON.stringify(LoginnedEmployee))
            CreateStation(R.EMPLOYEE_ID[0])
            document.getElementById("ResArea").innerText=""
        }else{
            document.getElementById("ResArea").innerText="Kullanıcı Bulunamadı / Şifre Hatalı"
        }
    }
    function CreateStation(EMP_ID) {
       var ResA= wrk_query("SELECT STATION_NAME,STATION_ID FROM WORKSTATIONS WHERE EMP_ID LIKE '%"+EMP_ID+"%'","DSN3")
       $(document.getElementById("Stations")).html("")
    for(let i=0;i<ResA.STATION_ID.length;i++){
        var btn=document.createElement("button")
        btn.setAttribute("class","btn btn-lg btn-outline-primary")
        btn.innerText=ResA.STATION_NAME[i]
        btn.setAttribute("style","margin-right:7px")
        document.getElementById("Stations").appendChild(btn)
    }
    }
</script>

</cf_box>