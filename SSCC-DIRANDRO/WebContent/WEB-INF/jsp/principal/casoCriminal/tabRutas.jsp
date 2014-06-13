<script>
var map, ren, ser;
var data = {};

function goma()
{
	map = new google.maps.Map( document.getElementById('mappy'), {'zoom':6, 'mapTypeId': google.maps.MapTypeId.ROADMAP, 'center': new google.maps.LatLng(-12.0553442,-77.0451853,14) })

	ren = new google.maps.DirectionsRenderer( {'draggable':true} );
	ren.setMap(map);
	ser = new google.maps.DirectionsService();
	
	ser.route({ 'origin': new google.maps.LatLng(-12.060447, -77.050068), 'destination':  new google.maps.LatLng(-12.058223, -77.041571), 'travelMode': google.maps.DirectionsTravelMode.DRIVING},function(res,sts) {
		if(sts=='OK')ren.setDirections(res);
	});	
}

function save_waypoints()
{
var concat ='';
	var w=[],wp;
	var rleg = ren.directions.routes[0].legs[0];
	data.start = {'lat': rleg.start_location.lat(), 'lng':rleg.start_location.lng()}
	data.end = {'lat': rleg.end_location.lat(), 'lng':rleg.end_location.lng()}
	var wp = rleg.via_waypoints
	
	for(var i=0;i<wp.length;i++){
		w[i] = [wp[i].lat(),wp[i].lng()]
		concat += w[i]+ "|";
		
	}
	
	document.getElementById('inicio1').value = rleg.start_location.lat();
	document.getElementById('inicio2').value = rleg.start_location.lng();
	document.getElementById('fin1').value = rleg.end_location.lat();
	document.getElementById('fin2').value = rleg.end_location.lng();
	document.getElementById('c').value = concat;

	data.waypoints = w;
	
	var str = JSON.stringify(data);
	
}
$(document).ready(function(){
	goma();
});
</script>


<div id="mappy" style="width:900px; height:550px; margin:0px auto 0px auto; border:1px solid #cecece; background:#F5F5F5"></div>
<div style="width:900px; text-align:center; margin:0px auto 0px auto; margin-top:10px;">
	<input type="button" value="Grabar Puntos de Acopoio" onClick="save_waypoints()">
    <br>

<label>inicio1</label>
    <input id="inicio1" type="text" value="" size="120"><br>
<label>inicio2</label>
    <input id="inicio2" type="text" value="" size="120"><br>
<label>fin1</label>
    <input id="fin1" type="text" value="" size="120"><br>
<label>fin2</label>
    <input id="fin2" type="text" value="" size="120"><br>

	<label>wp</label>
    <input id="c" type="text" value="" size="120">
</div>

