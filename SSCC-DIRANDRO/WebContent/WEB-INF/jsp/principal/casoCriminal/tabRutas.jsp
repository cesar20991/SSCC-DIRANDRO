<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
var map, ren, ser;
var data = {};

function goma()
{
	map = new google.maps.Map( document.getElementById('mappy'), {'zoom':6, 'mapTypeId': google.maps.MapTypeId.ROADMAP, 'center': new google.maps.LatLng(-12.0553442,-77.0451853,14) });

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
	var w=[];
	var rleg = ren.directions.routes[0].legs[0];
	data.start = {'lat': rleg.start_location.lat(), 'lng':rleg.start_location.lng()};
	data.end = {'lat': rleg.end_location.lat(), 'lng':rleg.end_location.lng()};
	var wp = rleg.via_waypoints;
	
	for(var i=0;i<wp.length;i++){
		w[i] = [wp[i].lat(),wp[i].lng()];
		if(i==(wp.length-1)){
			concat += w[i];
		}else{
			concat += w[i]+ "|";
		}	
	}
	
	document.getElementById('inicio1').value = rleg.start_location.lat();
	document.getElementById('inicio2').value = rleg.start_location.lng();
	document.getElementById('fin1').value = rleg.end_location.lat();
	document.getElementById('fin2').value = rleg.end_location.lng();
	document.getElementById('c').value = concat;

	data.waypoints = w;
	
	/*var str = JSON.stringify(data);*/
	
}
$(document).ready(function(){
	goma();
	
	$("#formRuta").validate({
		submitHandler: function(form){
			$.ajax({
				url: 'asignarRutasAcasos-'+$("#hdnIdCaso").text(),
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formRuta").serialize(),
		 		success: function(rutas){
		 			initRutas(caso);
		 			$("#divMostrarCasoCriminal").show();
		 			$("#divEditarCasoCriminal").hide();
		 			$("#alertas").show();
		 			$("#alertas").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Guardado Correctamente</strong>'+
						 			    '</div>');
		 		}
			});
		}
	});
});
</script>
<style>
#mappy{
    border: none !important;
    max-width: none !important;
}
</style>

<div id="mappy" style="width:800px; height:550px; margin:0px auto 0px auto; border:1px solid #cecece; background:#F5F5F5"></div>
<div id="divMostrarRutas" style="display:none;">
	<div id="mappyMostrar" style="width:800px; height:550px; margin:0px auto 0px auto; border:1px solid #cecece; background:#F5F5F5"></div>
	<div id="listaRutas">
	</div>
</div>
<div id="guardarRuta">
	<button type="button" onClick="save_waypoints()">Obtener Coordenadas</button>
    <br><button type="button" onClick="goma()">Reset</button>
<form:form class="form-horizontal" id="formRuta" action="crearRuta" commandName="RutasMapas">
	<label>inicio1</label>
    <input id="inicio1" type="text" value="" name="inicioLat" size="120"><br>
	<label>inicio2</label>
	    <input id="inicio2" type="text" value="" name="inicioLong" size="120"><br>
	<label>fin1</label>
	    <input id="fin1" type="text" value="" name="finLat" size="120"><br>
	<label>fin2</label>
	    <input id="fin2" type="text" value="" name="finLong" size="120"><br>
	
	<label>wp</label>
	<input id="c" type="text" value="" name="wp" size="120">
	<label>titulo</label>
	<input id="txtTitulo" type="text" value="" name="nombre" size="120">
	<label>descripcion</label>
	<input id="txtDescripcion" type="text" value="" name="comentario" size="120">
	<button type="submit" id="guardarRuta">Guardar Ruta</button>
</form:form>



</div>

