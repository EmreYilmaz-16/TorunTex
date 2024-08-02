<div style="padding:10px">
<cf_box title="Canlı Hayvan Transfer">
<cfquery name="getDep" datasource="#dsn3#">
    SELECT DEPARTMENT_LOCATION,COMMENT FROM w3Toruntex.STOCKS_LOCATION WHERE DEPARTMENT_ID=18
</cfquery>
<script>
    var LocationArr=[
        <cfoutput query="getDep">
            {
                DEPARTMENT_LOCATION:"#DEPARTMENT_LOCATION#",
                COMMENT:"#COMMENT#",
            },
        </cfoutput>
    ]
</script>
<table>
    <tr>
        <td>    
            <div class="form-group">
                <label>Çıkış Lokasyonu</label>
                <select name="LOCATION_OUT" id="LOCATION_OUT" onchange="GetLocationIn(this)"></select>
            </div>
        </td>
    </tr>
    <tr>
        <td>    
            <div class="form-group">
                <label>Giriş Lokasyonu</label>
                <select name="LOCATION_IN" id="LOCATION_IN"></select>
            </div>
        </td>
    </tr>

</table>


</cf_box>

<script>
    $(document).ready(function (params) {
        for (let index = 0; index < LocationArr.length; index++) {
            const element = LocationArr[index];
            var Opt=document.createElement("option");
            Opt.value=element.DEPARTMENT_LOCATION;
            Opt.innerText=element.COMMENT;
            document.getElementById("LOCATION_OUT").appendChild(Opt)
        }
    })
    function GetLocationIn(el) {
        var Ox=LocationArr.filter(p=>p.DEPARTMENT_LOCATION != el.value)
       $("#LOCATION_IN").html("");
        for (let index = 0; index < Ox.length; index++) {
            const element = Ox[index];
            var Opt=document.createElement("option");
            Opt.value=element.DEPARTMENT_LOCATION;
            Opt.innerText=element.COMMENT;
            document.getElementById("LOCATION_IN").appendChild(Opt)
        }
    }
</script>
</div>