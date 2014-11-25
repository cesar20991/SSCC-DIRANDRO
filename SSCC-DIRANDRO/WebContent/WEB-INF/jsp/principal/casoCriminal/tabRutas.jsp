<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#map_canvas img {
    border: none !important;
    max-width: none !important;
}
</style>
<script>
//================================================================inicio scripts del mapa de RUTAS
var map, ren, ser;
var data = {};

function goma(){
	map = new google.maps.Map( document.getElementById('mappy'), {'zoom':6, 'mapTypeId': google.maps.MapTypeId.ROADMAP, 'center': new google.maps.LatLng(-12.0553442,-77.0451853,14) });

	ren = new google.maps.DirectionsRenderer( {'draggable':true} );
	ren.setMap(map);
	ser = new google.maps.DirectionsService();
	
	ser.route({ 'origin': new google.maps.LatLng(-12.060447, -77.050068), 'destination':  new google.maps.LatLng(-12.058223, -77.041571), 'travelMode': google.maps.DirectionsTravelMode.DRIVING},function(res,sts) {
		if(sts=='OK')ren.setDirections(res);
	});	
}

function save_waypoints(){
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
	
	$('#inicio1').val(rleg.start_location.lat());
	$('#inicio2').val(rleg.start_location.lng());
	$('#fin1').val(rleg.end_location.lat());
	$('#fin2').val(rleg.end_location.lng());
	$('#c').val(concat);

	data.waypoints = w;		
}
//===========================================================================fin del mapa

//==========================================================================PUNTOS DE ACOPIO
   
var lat = null;
var lng = null;
var map2 = null;
var geocoder = null;
var marker = null;
         
$(document).ready(function(){
     lat = $('#lat').val();
     lng = $('#long').val();
	     
     $('#pasar').click(function(){
        codeAddress();
        return false;
     });	 

    initialize();
});
     
function initialize() {  
	var latLng2 ='';
  	geocoder = new google.maps.Geocoder();
  		if(lat !='' && lng != ''){
	 		latLng2 = new google.maps.LatLng(lat,lng);
  		}else{
     		latLng2 = new google.maps.LatLng(-12.0553442,-77.0451853,14);
  		}
   
   var myOptions = {
      center: latLng2,
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP 
   };
    
    map2 = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    marker = new google.maps.Marker({
        map: map2,
        position: latLng2,
        draggable: true 
    });        
    
    google.maps.event.addListener(marker, 'dragend', function(){
        updatePosition(marker.getPosition());
    });                
}

function updatePosition(latLng2){
    $('#lat').val(latLng2.lat());
    $('#long').val(latLng2.lng());
}

function codeAddress() {
	var address = $("#direccion").val();
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map2.setCenter(results[0].geometry.location);
            marker.setPosition(results[0].geometry.location);
            updatePosition(results[0].geometry.location);
            google.maps.event.addListener(marker, 'dragend', function(){
                updatePosition(marker.getPosition());
            });
        }else{
          alert("No podemos encontrar la dirección, error: " + status);
        }
    });
} 
    
    
	
//============================================================================FIN DE PUNTOS DE ACOPIO

function initRutas(rutas){
	$("#divMostrarRutas").empty();
		$.each(rutas, function(i, ruta) {			
			
			$("#divMostrarRutas").append(
					'<table class="table table-bordered table-condensed">'+
	 					'<tbody>'+
// 						'<tr>'+
// 							'<td rowspan="4" align="center" style="width: 90px; height: 100px;" id="tdImagen">'+imagen+'</td>'+
// 							'<td>Código Único de Identificación:</td>'+
// 							'<td align="center"><span id="hdrCodigoUnicoDeIdentificacion">'+sospechoso.codigoUnicoDeIdentificacion+'</span></td>'+							
// 							'<td><button class="btn btn-danger btn-mini asignar" id="cancelarAsigna_'+sospechoso.idSospechoso+'" type="button"><i class="icon-minus icon-white"></i></button></td>'+
// 						'</tr>'+
						'<tr>'+
							'<td colspan="2">Titulo:</td>'+
							'<td colspan="2">'+ruta.nombre+'</span></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="2">Descripción:</td>'+
							'<td colspan="2">'+ruta.comentarios+'</td>'+
						'</tr>'+
					'</tbody>'+
				'</table>');
		});
}

$(document).ready(function(){
	goma();
	
	$.ajax({
		url: 'getTabRubas-'+$("#hdnIdCaso").text(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(rutas){
			initRutas(rutas);
		}
	});
// 	$.ajax({
//  		url: 'asignarRutasAcasos-'+$("#hdnIdCaso").text(),
//  		type: 'post',
//  		dataType: 'json',
//  		data: '',
//  		success: function(rutas){
//  			initRutas(caso);
//  		}
//  	});
	
	
	$(document).on('click','#btnAgregarRuta', function(e){
		$("#divNuevaRuta").show();
		$("#divRutasAsignado").hide();		
		$("#divNuevPuntoAcopio").hide();
	});
	$(document).on('click','#btnAgregarPuntoAcopio', function(e){
		$("#divNuevaRuta").hide();
		$("#divRutasAsignado").hide();	
		$("#divNuevPuntoAcopio").show();
	});
	
	$(document).on('click','#btnCancelRuta', function(e){
		$("#divRutasAsignado").show();
		$("#divNuevaRuta").hide();
		$("#divNuevPuntoAcopio").hide();
		vaciarFormulario();
		//wsinitRutas(caso);
	});
	$(document).on('click','#btnCancelPunto', function(e){
		$("#divRutasAsignado").show();
		$("#divNuevaRuta").hide();
		$("#divNuevPuntoAcopio").hide();
		vaciarPuntos();
		//initRutas(caso);
	});
	
	$("#formRuta").validate({
		submitHandler: function(form){
			$.ajax({
				url: 'asignarRutasAcasos-'+$("#hdnIdCaso").text(),
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formRuta").serialize(),
		 		success: function(rutas){
		 			initRutas(rutas);
		 			$("#divRutasAsignado").show();
		 			$("#divNuevaRuta").hide();
		 			$("#alertasMapa").show();
		 			$("#alertasMapa").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Guardado Correctamente</strong>'+
						 			    '</div>');
		 		}
			});
		}
	});
	
	$("#formPuntosAcopio").validate({
		submitHandler: function(form){
			$.ajax({
				url: 'asignarRutasAcasos-'+$("#hdnIdCaso").text(),
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formPuntosAcopio").serialize(),
		 		success: function(rutas){
		 			initRutas(rutas);
		 			$("#divRutasAsignado").show();
		 			$("#divNuevPuntoAcopio").hide();
		 			$("#alertasMapa").show();
		 			$("#alertasMapa").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Guardado Correctamente</strong>'+
						 			    '</div>');
		 		}
			});
		}
	});
	
//CREO QE AQUI ME EQUIVOCO.... CREO!!! Xd	
// 	$("#formAcopio").validate({
// 		submitHandler: function(form){
// 			$.ajax({
// 				url: 'asignarAcopiosAcasos-'+$("#hdnIdCaso").text(),
// 		 		type: 'post',
// 		 		dataType: 'json',
// 		 		data: $("#formAcopio").serialize(),
// 		 		success: function(acopios){
// 		 			//initRutas(caso);
// 		 			//$("#divRutasAsignado").show();
// 		 			//$("#divNuevaRuta").hide();
// 		 			//$("#alertasMapa").show();
// // 		 			$("#alertasMapa").append('<div class="alert alert-success" id="alertaVerde">'+
// // 						 			        '<a class="close" data-dismiss="alert">×</a>'+
// // 						 			        '<strong id="msgVerde">Guardado Correctamente</strong>'+
// // 						 			    '</div>');
// 		 		}
// 			});
// 		}
// 	});
	
	function vaciarFormulario(){
		$("#inicio1").val("");
		$("#inicio2").val("");
		$("#fin1").val("");
		$("#fin2").val("");
		$("#c").val("");
		$("#txtTitulo").val("");
		$("#txtDescripcion").val("");		
	}
	function vaciarPuntos(){
		$("#lat").val("");
		$("#long").val("");
		$("#txtTitulo").val("");
		$("#txtDescripcion").val("");		
	}
});
</script>
<style>
#mappy{
    border: none !important;
    max-width: none !important;
}
</style>

	<div id="divRutasAsignado">
	<div id="alertasMapa" style="display: none;"></div>	
		<div class="panel panel-default">
			<div class="panel-heading">
			/// Asignar Rutas:
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-primary btn-sm asignar" type="button" id="btnAgregarRuta"><i class="icon-edit icon-white"></i> Agregar Ruta</button>
						<button class="btn btn-primary btn-sm asignar" type="button" id="btnAgregarPuntoAcopio"><i class="icon-edit icon-white"></i> Agregar Punto de Acopio</button>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div id="divMostrarRutas">
				
				</div>
			</div>
		</div>
	</div>
	
<!-- ============== RUTAS ====================== -->
<div id="divNuevaRuta" style="display:none;">
	<div class="panel panel-default">
		<div class="panel-heading">
			<button class="btn btn-primary btn-sm" type="button" onClick="goma()">Reset</button> 
			<button class="btn btn-primary btn-sm" type="button" onClick="save_waypoints()">Obtener Coordenadas</button>
		</div>
		<div class="panel-body">
			<form:form class="form-horizontal span9" id="formRuta" action="crearRuta" commandName="RutasMapas">
				<div id="mappy" style="width:800px; height:550px; margin:0px auto 0px auto; border:1px solid #cecece; background:#F5F5F5"></div>
				<div class="form-group">
	          		<label>Latitud Punto A: </label>
	          		<input id="inicio1" type="text" value="" name="inicioLat" class="form-control">
	       		</div>	
	       		<div class="form-group">
	          		<label>Longitud Punto A: </label>
	          		<input id="inicio2" type="text" value="" name="inicioLong" class="form-control">
	       		</div>
	       		<div class="form-group">
	          		<label>Latitud Punto B: </label>
	          		<input id="fin1" type="text" value="" name="finLat" class="form-control">
	       		</div>
	       		<div class="form-group">
	          		<label>Longitud Punto B: </label>
	          		<input id="fin2" type="text" value="" name="finLong" class="form-control">
	       		</div>
	       		<div class="form-group">
	          		<label>Way Points: </label>
	          		<input id="c" type="text" value="" name="wp" class="form-control">
	       		</div>
	       		<div class="form-group">
	          		<label>Título: </label>
	          		<input id="txtTitulo" type="text" value="" name="nombre" class="form-control">
	       		</div>
	       		<div class="form-group">
	          		<label>Descripción: </label>
	          		<input id="txtDescripcion" type="text" value="" name="comentario" class="form-control">
	       		</div>
	       		<button class="btn btn-outline btn-success" type="submit" id="guardarRuta"><i class="fa fa-check"></i> Guardar Ruta</button>
				<button class="btn btn-outline btn-warning" type="button" id="btnCancelRuta"><i class="fa fa-arrow-left"></i> Cancel</button>
			</form:form>
		</div>
	</div>	
</div>
	
<!-- ============ PUNTOS DE ACOPIO ============== -->
<div id="divNuevPuntoAcopio" style="display:none;">
	
	<div class="panel panel-default">
			<div class="panel-heading">
				Dirección:
				<input type="text" id="direccion" name="direccion" class="form-control">
				<button class="btn btn-outline btn-primary btn-small" type="button" id="pasar"><i class="icon-arrow-left icon-white"></i> Buscar Punto</button>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-small" type="button" onClick="initialize()">Reset</button>						
					</div>
				</div>
			</div>
			<div class="panel-body">
				<form:form class="form-horizontal span9" id="formPuntosAcopio" action="crearRuta" commandName="RutasMapas">
					<div id="map_canvas" style="width:800px; height:550px;"></div>
					<div class="form-group">
						<label>Latitud: </label>
						<input name="inicioLat" id="lat" type="text" value="" class="form-control">
					</div>
					<div class="form-group">
						<label>Longitud: </label>
						<input name="inicioLong" id="long" type="text" value="" class="form-control">
					</div>
					<div class="form-group">
						<label>Título: </label>
						<input id="txtTitulo" type="text" value="" name="nombre" class="form-control">
					</div>
					<div class="form-group">
						<label>Descripción: </label>
						<input id="txtDescripcion" type="text" value="" name="comentario" class="form-control">
					</div>
					<button class="btn btn-outline btn-success" type="submit" id="guardarPunto"><i class="fa fa-check"></i> Guardar Punto</button>
					<button class="btn btn-outline btn-warning" type="button" id="btnCancelPunto"><i class="fa fa-arrow-left"></i> Cancel</button>
				</form:form>
			</div>
		</div>
</div>

