<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	
	document.getElementById('inicio1').value = rleg.start_location.lat();
	document.getElementById('inicio2').value = rleg.start_location.lng();
	document.getElementById('fin1').value = rleg.end_location.lat();
	document.getElementById('fin2').value = rleg.end_location.lng();
	document.getElementById('c').value = concat;

	data.waypoints = w;		
}
//===========================================================================fin del mapa

//==========================================================================PUNTOS DE ACOPIO
   
var lat = null;
var lng = null;
var map2 = null;
var geocoder = null;
var marker = null;
         
jQuery(document).ready(function(){
     lat = jQuery('#lat').val();
     lng = jQuery('#long').val();
	     
     jQuery('#pasar').click(function(){
        codeAddress();
        return false;
     });	 

    initialize();
});
     
    function initialize() {     
      geocoder = new google.maps.Geocoder();
       if(lat !='' && lng != ''){
         var latLng2 = new google.maps.LatLng(lat,lng);
      }
      else{
         var latLng2 = new google.maps.LatLng(-12.0553442,-77.0451853,14);
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
        updatePosition(latLng2);                 
    }
     
    function codeAddress() {
        var address = document.getElementById("direccion").value;
        geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map2.setCenter(results[0].geometry.location);
            marker.setPosition(results[0].geometry.location);
            updatePosition(results[0].geometry.location);
            google.maps.event.addListener(marker, 'dragend', function(){
                updatePosition(marker.getPosition());
            });
      } else {
          alert("No podemos encontrar la direcci&oacute;n, error: " + status);
      }
    });
  }
    
  function updatePosition(latLng){
       jQuery('#lat').val(latLng.lat());
       jQuery('#long').val(latLng.lng());
  }  
	
//============================================================================FIN DE PUNTOS DE ACOPIO

function initRutas(caso){
	$("#divMostrarRutas").empty();
		$.each(caso, function(i, caso) {			
			
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
							'<td colspan="2">'+ruta.comentario+'</td>'+
						'</tr>'+
					'</tbody>'+
				'</table>');
		});
}

$(document).ready(function(){
	goma();
	
	
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
		initRutas(caso);
	});
	$(document).on('click','#btnCancelPunto', function(e){
		$("#divRutasAsignado").show();
		$("#divNuevaRuta").hide();
		$("#divNuevPuntoAcopio").hide();
		vaciarPuntos();
		initRutas(caso);
	});
	
	$("#formRuta").validate({
		submitHandler: function(form){
			$.ajax({
				url: 'asignarRutasAcasos-'+$("#hdnIdCaso").text(),
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formRuta").serialize(),
		 		success: function(rutas){
		 			initRutas(caso);
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
	
//CREO QE AQUI ME EQUIVOCO.... CREO!!! Xd	
	$("#formAcopio").validate({
		submitHandler: function(form){
			$.ajax({
				url: 'asignarAcopiosAcasos-'+$("#hdnIdCaso").text(),
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formAcopio").serialize(),
		 		success: function(acopios){
		 			//initRutas(caso);
		 			//$("#divRutasAsignado").show();
		 			//$("#divNuevaRuta").hide();
		 			//$("#alertasMapa").show();
// 		 			$("#alertasMapa").append('<div class="alert alert-success" id="alertaVerde">'+
// 						 			        '<a class="close" data-dismiss="alert">×</a>'+
// 						 			        '<strong id="msgVerde">Guardado Correctamente</strong>'+
// 						 			    '</div>');
		 		}
			});
		}
	});
	
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
		$("#txtTitulo2").val("");
		$("#txtDescripcion2").val("");		
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
		<form:form class="form-horizontal">
			<fieldset>
				<legend>
					<span class=""><span class="colored">///</span> Asignar Rutas:</span>
					<span class="offset2"><button class="btn btn-primary btn-small asignar" type="button" id="btnAgregarRuta"><i class="icon-edit icon-white"></i> Agregar Ruta</button></span>
					<span class="offset1"><button class="btn btn-primary btn-small asignar" type="button" id="btnAgregarPuntoAcopio"><i class="icon-edit icon-white"></i> Agregar Punto de Acopio</button></span>
				</legend>
				<div id="divMostrarRutas">
				
				</div>
			</fieldset>
		</form:form>
	</div>
	
<!-- ============== RUTAS ====================== -->
<div id="divNuevaRuta" style="display:none;">	
	<div id="mappy" style="width:800px; height:550px; margin:0px auto 0px auto; border:1px solid #cecece; background:#F5F5F5"></div>
	<div id="listaRutas">
	</div>
	<div id="guardarRuta">
		<br>
		<button class="btn btn-primary btn-small" type="button" onClick="goma()">Reset</button> <button class="btn btn-primary btn-small" type="button" onClick="save_waypoints()">Obtener Coordenadas</button>
	    <br>
	    <fieldset class="well">
		<form:form class="form-horizontal span9" id="formRuta" action="crearRuta" commandName="RutasMapas">
			<legend class="span8">
			  	<span class="colored">///</span> Agregar Nueva Ruta:
		    </legend>
			<div class="span4">
		       		<div class="control-group">
		          		<label class="control-label">Latitud Punto A: </label>
		          		<div class="controls">
		          			<input id="inicio1" type="text" value="" name="inicioLat" class="span3">
		          		</div>
		       		</div>		       		
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label" title="Código Único de Identificación">Longitud Punto A: </label>
		          		<div class="controls">
		          			<input id="inicio2" type="text" value="" name="inicioLong" class="span3">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Latitud Punto B: </label>
		          		<div class="controls">
		          			<input id="fin1" type="text" value="" name="finLat" class="span3">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Longitud Punto B: </label>
		          		<div class="controls">
		          			<input id="fin2" type="text" value="" name="finLong" class="span3">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Way Points: </label>
		          		<div class="controls">
		          			<input id="c" type="text" value="" name="wp" class="span3">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Título: </label>
		          		<div class="controls">
		          			<input id="txtTitulo" type="text" value="" name="nombre" class="span3">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Descripción: </label>
		          		<div class="controls">
		          			<input id="txtDescripcion" type="text" value="" name="comentario" class="span3">
		          		</div>
		       		</div>
		       		<div class="form-actions span6">
		          		<button class="btn btn-success" type="submit" id="guardarRuta"><i class="icon-ok icon-white"></i> Guardar Ruta</button>
						<button class="btn btn-warning" type="button" id="btnCancelRuta"><i class="icon-arrow-left icon-white"></i> Cancel</button>
		       		</div>
		       	</div>			
		</form:form>
		</fieldset>
	</div>
</div>
	
<!-- ============ PUNTOS DE ACOPIO ============== -->
<div id="divNuevPuntoAcopio" style="display:none;">
<fieldset>
	<form:form class="form-horizontal span9" id="formAcopio" action="crearAcopio" commandName="PuntosAcopio">
	<button class="btn btn-primary btn-small" type="button" onClick="initialize()">Reset</button>
	 
<!-- 	<label>Direcci&oacute;n</label> -->
<!-- 	<input type="text" id="direccion" name="direccion" value=""/>  -->
<!-- 	<button id="pasar">Pasar al mapa</button> -->
	<div class="control-group">
		<label class="control-label">Dirección: </label>
		<div class="controls">
			<input type="text" id="direccion" name="direccion" value="" class="span3">
			<button class="btn btn-primary btn-small" type="button" id="pasar"><i class="icon-arrow-left icon-white"></i> Buscar Punto</button>
		</div>
	</div>
	 
	<!-- div donde se dibuja el mapa-->
	<div id="map_canvas" style="width:800px;height:600px;"></div>
	 <fieldset class="well">
	<!--campos ocultos donde guardamos los datos-->
	<div class="control-group">
		<label class="control-label">Latitud: </label>
		<div class="controls">
			<input name="lat" id="lat" type="text" value="" class="span3">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">Longitud: </label>
		<div class="controls">
			<input name="lng" id="long" type="text" value="" class="span3">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">Título: </label>
		<div class="controls">
			<input id="txtTitulo2" type="text" value="" name="nombre2" class="span3">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">Descripción: </label>
		<div class="controls">
			<input id="txtDescripcion2" type="text" value="" name="comentario2" class="span3">
		</div>
	</div>	
	<div class="form-actions span6">
		<button class="btn btn-success" type="submit" id="guardarPunto"><i class="icon-ok icon-white"></i> Guardar Punto</button>
		<button class="btn btn-warning" type="button" id="btnCancelPunto"><i class="icon-arrow-left icon-white"></i> Cancel</button>
	</div>
	</fieldset>
	</form:form>
</fieldset>
</div>

