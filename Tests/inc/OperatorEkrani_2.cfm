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
<div class="row">
    <div class="col col-3">
        
    <div class="form-group">
        <label>Ürün</label>
        <select class="form-control form-select sel" id="select_1" placeholder="Ürün Seçiniz" aria-label="Default select example">
            <option selected>Ürün</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
          </select>
        </div>
        <div class="form-group">
            <label>Sipariş</label>
          <select class="form-control form-select sel" id="select_2" placeholder="Sipariş Seçiniz" aria-label="Default select example">
            <option selected>Sipariş</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
            <option value="3">Three</option>
          </select>
        </div>
    </div>

<div class="col col-6">
</div>
    <div class="col col-3">
        <div style="height:30vh;overflow-y: scroll;" id="OrderData">
            <table class="table table-striped table-lg tableFixHead">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">First</th>
                    <th scope="col">Last</th>
                    <th scope="col">Handle</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                  </tr>
                  <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                  </tr>
                  <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                  </tr>
                </tbody>
              </table>
        </div>
    </div>
</div>


<script>
    $(document).ready(function(){
    document.getElementById("wrk_main_layout").setAttribute("class","container-fluid");
    $(".sel").selectize();
})
</script>
<script src="/JS/sselec/selectize/dist/js/standalone/selectize.js"></script>
<link rel="stylesheet" href="/JS/sselec/selectize/dist/css/selectize.bootstrap5.css">