<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>rutas</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script> -->
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<script src="js/jquery.validate.min.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<style>
.error {
	color: rgb(255, 0, 0);
}
</style>
<script>
var map, ren, ser;
var data = {};
function goma()
{
	map = new google.maps.Map( document.getElementById('mappy'), {
		'zoom':6, 
		'mapTypeId': google.maps.MapTypeId.ROADMAP, 
		'center': new google.maps.LatLng(-12.0553442,-77.0451853,14) 
	});

	ren = new google.maps.DirectionsRenderer( {
		'draggable':true
	});

	ren.setMap(map);
	ser = new google.maps.DirectionsService();
	
	ser.route({ 
		'origin': new google.maps.LatLng(-12.060447, -77.050068), 
		'destination':  new google.maps.LatLng(-12.058223, -77.041571), 
		'travelMode': google.maps.DirectionsTravelMode.DRIVING},function(res,sts) {
		if(sts=='OK')ren.setDirections(res);
	});
	
	google.maps.event.addListener(ren, 'click', function() {
		alert("entre ctm");
		var w=[],wp;
		var rleg = ren.directions.routes[0].legs[0];
		data.start = {'lat': rleg.start_location.lat(), 'lng':rleg.start_location.lng()};
		data.end = {'lat': rleg.end_location.lat(), 'lng':rleg.end_location.lng()};
		var wp = rleg.via_waypoints;	
		for(var i=0;i<wp.length;i++){
			w[i] = [wp[i].lat(),wp[i].lng()];	
		}
		data.waypoints = w;
		alert(rleg.start_location.lat());
   		$("#c").val(rleg.start_location.lat());
  	});
}

function save_waypoints()
{
	var w=[],wp;
	var rleg = ren.directions.routes[0].legs[0];
	data.start = {'lat': rleg.start_location.lat(), 'lng':rleg.start_location.lng()};
	data.end = {'lat': rleg.end_location.lat(), 'lng':rleg.end_location.lng()};
	var wp = rleg.via_waypoints;	
	for(var i=0;i<wp.length;i++){
		w[i] = [wp[i].lat(),wp[i].lng()];	
	}
	data.waypoints = w;
	
	var str = JSON.stringify(data);

	var jax = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
	jax.open('POST','process.php');
	jax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	jax.send('command=save&mapdata='+str);
	jax.onreadystatechange = function(){ if(jax.readyState==4) {
		if(jax.responseText.indexOf('bien')+1){
			alert('Puntosa de Acopio Grabados Correctamente');
		}else {
			alert(jax.responseText);
		}
	}}
}
</script>
</head>
<body onLoad="goma()">
<div id="mappy" style="width:900px; height:550px; margin:0px auto 0px auto; border:1px solid #cecece; background:#F5F5F5"></div>
<div style="width:900px; text-align:center; margin:0px auto 0px auto; margin-top:10px;">
	<input type="button" value="Grabar Puntos de Acopoio" onClick="save_waypoints()">
	<input name="ce" type="text" id="c" class="span4">
</div>
</body>
</html>