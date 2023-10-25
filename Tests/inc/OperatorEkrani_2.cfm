<div class="row">
    <div class="col col-9">
        <cf_seperator id="getP2" header="Duyurukar"  style="display:none;">
            <div id="getP2"  style="display:none;">
                <ul>
                    <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</li>
                    <li>Nunc mollis mauris nec laoreet consequat.</li>
                    <li>Donec porttitor magna in odio condimentum, vel efficitur lacus sodales.</li>
                </ul>
            </div>
    </div>
    <div class="col col-3">
        <table style="width: 100%;">
            <tbody>
                <tr>
                    <td style="text-align: center;">
                        <button type="button" class="btn btn-lg btn-outline-secondary" onclick="ShowStations()">KLB</button>                        
                    </td>
                    <td style="text-align: center;">                        
                        <button type="button" class="btn btn-lg btn-outline-primary" onclick="LogIn()">Kullanıcı Girişi</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <div class="col col-12">                
        <cf_grid_list style="width:100%">
            <tr>
                <td id="Location">KLB</td>
                <td id="Complate">%80</td>
                <td id="Customer">Emre Cooop</td>
                <td id="Country">Türkiye</td>
                <td id="Color">
                    <div style="display: flex;">
                        <span style="width: 50%;display: block;">Şeffaf-Kırmızı</span> 
                        <span id="color1" style="display:block;border: solid 0.5px black;background: none;width: 25%;">&nbsp;&nbsp;&nbsp;</span> 
                        <span id="color1" style="display:block;border: solid 0.5px black;background: red;width: 25%;">&nbsp;&nbsp;&nbsp;</span>
                    </div>
                </td>
            </tr>
        </cf_grid_list>
    </div>
</div>