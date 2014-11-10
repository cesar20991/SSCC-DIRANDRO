<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).on('click','#btnOcultar', function(e){
	$("#formularioGuardar").hide();
	$("#btnOcultar").hide();
	$("#btnMostrar").show();
});
$(document).on('click','#btnMostrar', function(e){
	$("#formularioGuardar").show();
	$("#btnOcultar").show();
	$("#btnMostrar").hide();
});
var contarInformes = 0;
function initArchivos(archivos){	
		$.each(archivos, function(i, archivo) {
			var imagen = '';
			var btnUsar = '';
			if(archivo.tituloArchivo == 'Informe Policial'){
				contarInformes++;
			}
			if(tipoEntidad == 'sospechoso'){
				btnUsar = btnUsar + '<button class="btn btn-outline btn-primary btn-circle accion" type="button" id="usarS_'+archivo.idArchivo+'"><i class="fa fa-user fa-fw"></i></button>';
			}else if(tipoEntidad == 'usuario'){
				btnUsar = btnUsar + '<button class="btn btn-outline btn-primary btn-circle accion" type="button" id="usarU_'+archivo.idArchivo+'"><i class="fa fa-user fa-fw"></i></button>';
			}else if(tipoEntidad == 'inmueble'){
				btnUsar = btnUsar + '<button class="btn btn-outline btn-primary btn-circle accion" type="button" id="usarI_'+archivo.idArchivo+'"><i class="fa fa-user fa-fw"></i></button>';
			}else if(tipoEntidad == 'vehiculo'){
				btnUsar = btnUsar + '<button class="btn btn-outline btn-primary btn-circle accion" type="button" id="usarV_'+archivo.idArchivo+'"><i class="fa fa-user fa-fw"></i></button>';
			}
			
			if(archivo.tipoArchivo == "image/jpeg" | archivo.tipoArchivo == "image/png"){
				imagen = '<div class="mask"><a href="'+archivo.url+'" rel="prettyPhoto" class="info"><img src="'+archivo.url+'" alt="logo" style="width: 90px; height: 120px;"/></a></div>';
			}else if(archivo.tipoArchivo == "image/gif"){
				imagen = '<div class="mask"><a href="'+archivo.url+'" rel="prettyPhoto" class="info"><img src="'+archivo.url+'" alt="logo" style="width: 90px; height: 120px;"/></a></div>';
			}else{
				imagen = '<div class="mask"><a href="'+archivo.url+'" rel="prettyPhoto" class="info"><img src="img/hojaBlanca.jpg" alt="logo" style="width: 90px; height: 120px;"/></a></div>';
			}
			
			$("#divMostrarArchivo").append(
				'<form method="post" id="formEditarArchivo_'+archivo.idArchivo+'">'+
					'<table class="table table-bordered table-hover">'+
						'<tbody>'+
						'<tr>'+
							'<td rowspan="4" style="width: 90px; height: 100px;">'+imagen+' <input type="text" id="url_'+archivo.idArchivo+'" name="url" value="'+archivo.url+'" style="display: none;"></td>'+
							'<td>Nombre de Archivo:</td>'+
							'<td align="center"><span id="tblNombre"><a href="'+archivo.url+'" rel="prettyPhoto" class="info">'+archivo.nombreArchivo+'</a></span></td>'+
							'<td>Acciones:</td>'+
							'<td id="acciones_'+archivo.idArchivo+'"><button class="btn btn-outline btn-danger btn-circle accion" id="separar_'+archivo.idArchivo+'" type="button"><i class="fa fa-times fa-fw"></i></button> <button class="btn btn-outline btn-primary btn-circle accion" type="button" id="editar_'+archivo.idArchivo+'"><i class="fa fa-edit fa-fw"></i></button> '+btnUsar+'</td>'+
							'<td id="accionesEditar_'+archivo.idArchivo+'" style="display: none;"><button class="btn btn-outline btn-success btn-circle accion" id="guardar_'+archivo.idArchivo+'" type="button"><i class="fa fa-check"></i></button> <button class="btn btn-outline btn-warning btn-circle accion" type="button" id="cancelar_'+archivo.idArchivo+'"><i class="fa fa-arrow-left"></i></button></td>'+
						'</tr>'+
						'<tr>'+
							'<td>Tamaño:</td>'+
							'<td><span id="tblTamanio">'+archivo.tamanio+'</span> KB</td>'+
							'<td>Tipo Archivo:</td>'+
							'<td><span id="tblTipoArchivo_'+archivo.idArchivo+'">'+archivo.tipoArchivo+'</span></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="1">Titulo Archivo:</td>'+
							'<td colspan="3"><span id="tblTitulo_'+archivo.idArchivo+'">'+archivo.tituloArchivo+'</span> <input type="text" id="txtTitulo_'+archivo.idArchivo+'" name="tituloArchivo" style="display: none;" class="form-control"></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="1">Descripcion:</td>'+
							'<td colspan="3"><span id="tblDescripcion_'+archivo.idArchivo+'">'+archivo.descripcion+'</span> <textarea  class="form-control" name="descripcion" id="txtDescripcion_'+archivo.idArchivo+'" rows="5" style="display: none;"></textarea></td>'+
						'</tr>'+
					'</tbody>'+
				'</table>'+
			'</form>');
		});
}

$(document).on('click','.accion', function(e){
	var id = (this.id).split("_")[0];
	var id1 = (this.id).split("_")[1];
	
	switch(id){
		case "editar":
			$("#acciones_"+id1).hide();
			$("#accionesEditar_"+id1).show();
			
			$("#tblTitulo_"+id1).hide();
			$("#tblDescripcion_"+id1).hide();
			$("#txtTitulo_"+id1).show();
			$("#txtDescripcion_"+id1).show();
			
			$("#txtTitulo_"+id1).val($("#tblTitulo_"+id1).text());
			$("#txtDescripcion_"+id1).val($("#tblDescripcion_"+id1).text());
		break;
		case "cancelar":
			$("#acciones_"+id1).show();
			$("#accionesEditar_"+id1).hide();
			
			$("#tblTitulo_"+id1).show();
			$("#tblDescripcion_"+id1).show();
			$("#txtTitulo_"+id1).hide();
			$("#txtDescripcion_"+id1).hide();
		break;
		case "guardar":
			$.ajax({
				url: 'editarArchivo-'+id1+"-"+tipoEntidad+"-"+idEntidad,
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formEditarArchivo_"+id1).serialize(),
		 		success: function(archivos){
		 			$("#alertasArchivos").show();
					$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        '<strong id="msgVerde">Editado Correctamente</strong>'+
					 			    '</div>');
		 			$("#divMostrarArchivo").empty();
		 			initArchivos(archivos);
		 		}
			});
		break;
		case "separar":
			var respuesta = confirm('¿Esta seguro que desea Eliminar a este archivo?');
			if(respuesta){
				$.ajax({
					url: 'separarArchivo-'+id1+"-"+tipoEntidad+"-"+idEntidad,
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarArchivo_"+id1).serialize(),
			 		success: function(archivos){
			 			$("#alertasArchivos").show();
						$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Eliminado Correctamente</strong>'+
						 			    '</div>');
			 			$("#divMostrarArchivo").empty();
			 			initArchivos(archivos);
			 		}
				});
			}			
		break;
		case "usarU":
			if($("#tblTipoArchivo_"+id1).text() == 'image/jpeg' | $("#tblTipoArchivo_"+id1).text() == 'image/png' | $("#tblTipoArchivo_"+id1).text() == 'image/gif'){
				$.ajax({
					url: 'asignarArchivo-'+idEntidad,
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarArchivo_"+id1).serialize(),
			 		success: function(perfil){
			 			$("#alertasArchivos").show();
						$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Imagen asignada correctamente.</strong>'+
						 			    '</div>');
			 			initPerfil(perfil);		
			 		}
				});
			}else{
				$("#alertasArchivos").show();
				$("#alertasArchivos").append('<div class="alert alert-danger" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">No es posible asignar el archivo.</strong>'+
				 			    '</div>');
			}			
		break;
		case "usarS":
			if($("#tblTipoArchivo_"+id1).text() == 'image/jpeg' | $("#tblTipoArchivo_"+id1).text() == 'image/png' | $("#tblTipoArchivo_"+id1).text() == 'image/gif'){
				$.ajax({
					url: 'asignarArchivoSospechoso-'+idEntidad,
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarArchivo_"+id1).serialize(),
			 		success: function(sospechoso){
			 			$("#alertasArchivos").show();
						$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Imagen asignada correctamente.</strong>'+
						 			    '</div>');
			 			initSospechoso(sospechoso);	
			 		}
				});
			}else{
				$("#alertasArchivos").show();
				$("#alertasArchivos").append('<div class="alert alert-danger" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">No es posible asignar el archivo.</strong>'+
				 			    '</div>');
			}			
		break;
		case "usarI":
			if($("#tblTipoArchivo_"+id1).text() == 'image/jpeg' | $("#tblTipoArchivo_"+id1).text() == 'image/png' | $("#tblTipoArchivo_"+id1).text() == 'image/gif'){
				$.ajax({
					url: 'asignarArchivoInmueble-'+idEntidad,
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarArchivo_"+id1).serialize(),
			 		success: function(inmueble){
			 			$("#alertasArchivos").show();
						$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Imagen asignada correctamente.</strong>'+
						 			    '</div>');
						initInmueble(inmueble);	
			 		}
				});
			}else{
				$("#alertasArchivos").show();
				$("#alertasArchivos").append('<div class="alert alert-danger" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">No es posible asignar el archivo.</strong>'+
				 			    '</div>');
			}
		break;
		case "usarV":
			if($("#tblTipoArchivo_"+id1).text() == 'image/jpeg' | $("#tblTipoArchivo_"+id1).text() == 'image/png' | $("#tblTipoArchivo_"+id1).text() == 'image/gif'){
				$.ajax({
					url: 'asignarArchivoVehiculo-'+idEntidad,
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarArchivo_"+id1).serialize(),
			 		success: function(vehiculo){
			 			$("#alertasArchivos").show();
						$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Imagen asignada correctamente.</strong>'+
						 			    '</div>');
						initVehiculo(vehiculo);	
			 		}
				});
			}else{
				$("#alertasArchivos").show();
				$("#alertasArchivos").append('<div class="alert alert-danger" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">No es posible asignar el archivo.</strong>'+
				 			    '</div>');
			}
		break;
	}
	
});

$(document).ready(function(){
	$("#hdnTipoEntidad").val(tipoEntidad);
	switch(tipoEntidad){
		case 'usuario':
			if($("#hdnIdPerfil").text() != ""){
				$("#hdnIdEntidad").val($("#hdnIdPerfil").text());
				idEntidad = $("#hdnIdPerfil").text();
			}else{
				$("#hdnIdEntidad").val('${pageContext.session.getAttribute("idPerfil")}');
				idEntidad = '${pageContext.session.getAttribute("idPerfil")}';
			}
		break;
		case 'sospechoso':
			$("#hdnIdEntidad").val($("#hdnIdSospechoso").text());
			idEntidad = $("#hdnIdSospechoso").text();
		break;
		case 'casoCriminal':
			$("#hdnIdEntidad").val($("#hdnIdCaso").text());
			idEntidad = $("#hdnIdCaso").text();
		break;
		case 'inmueble':
			$("#hdnIdEntidad").val($("#hdnIdInmueble").text());
			idEntidad = $("#hdnIdInmueble").text();
		break;
		case 'vehiculo':
			$("#hdnIdEntidad").val($("#hdnIdVehiculo").text());
			idEntidad = $("#hdnIdVehiculo").text();
		break;
	}

	$.ajax({
		url: 'getArchivos',
 		type: 'post',
 		dataType: 'json',
 		data: $("#formArchivos").serialize(),
 		success: function(archivos){
 			initArchivos(archivos);
 		}
	});
	
	$("#formArchivos").ajaxForm({
			success: function(archivos){
				$("#alertasArchivos").show();
				$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">Adjuntado Correctamente</strong>'+
				 			    '</div>');
				$("#divMostrarArchivo").empty();
				initArchivos(archivos);
		    },
		    error: function()
		    {
		        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
		    }
	});
	
});
</script>
<div id="alertasArchivos" style="display: none;">
</div>
<div id="divArchivo">
<div class="panel panel-default">
	<div class="panel-heading">
		/// Subir Archivos
		<div class="pull-right">
			<div class="btn-group">
				<button class="btn btn-outline btn-default btn-sm" type="button" id="btnOcultar"><i class="icon-chevron-up"></i> Ocultar</button>
				<button class="btn btn-outline btn-default btn-sm" type="button" id="btnMostrar" style="display: none;"><i class="icon-chevron-down"></i> Mostrar</button>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<div id="divGuardarArchivo">
			<form:form method="post" action="newArchivo" enctype="multipart/form-data" id="formArchivos">
				<div id="formularioGuardar">
					<div class="form-group">
			        	<input class="input-file" type="file" name="files" multiple="multiple"/>
			        	<!-- <div id="progress">
					        <div id="bar"></div>
					        <div id="percent">0%</div>
						</div> -->
						
			        	<input type="hidden" id="hdnTipoEntidad" name="tipoEntidad">
			        	<input type="hidden" id="hdnIdEntidad" name="idEntidad">
			        	
			        	<div id="message"></div>
			        </div>	    
				    <div class="form-actions">
			        	<button type="submit" class="btn btn-outline btn-success" id="guardarArchivos"><i class="fa fa-check"></i> Guardar Archivos</button>
			        </div>
				</div>
			    <!-- <input type="submit" name="new"/> -->
			    
			</form:form>
		</div>
		<hr>
		<div id="divMostrarArchivo">
		
		</div>
	</div>
</div>
	
		
	
</div>
