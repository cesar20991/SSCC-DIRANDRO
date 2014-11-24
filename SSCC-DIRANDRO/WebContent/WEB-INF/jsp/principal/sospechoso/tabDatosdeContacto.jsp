<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
var totalCorreos = 0;
var totalTelefonos = 0;
var totalCelulares = 0;
var totalDirecciones = 0;

function initDatosContacto(sospechoso){
	$("#spnCorreos").empty();
	$("#spnTelefonos").empty();
	$("#spnCelulares").empty();
	$("#spnDirecciones").empty();
	
	$("#spnCorreos").append(sospechoso.correos);
	$("#spnTelefonos").append(sospechoso.telefonos);
	$("#spnCelulares").append(sospechoso.celulares);
	$("#spnDirecciones").append(sospechoso.direcciones);
	
	if($("#spnCorreos").text() == ''){
		totalCorreos = 0;
	}else{
		totalCorreos = ((sospechoso.correos).split(", ").length);
	}
	
	if($("#spnTelefonos").text() == ''){
		totalTelefonos = 0;
	}else{
		totalTelefonos = (sospechoso.telefonos).split(", ").length;
	}
	
	if($("#spnCelulares").text() == ''){
		totalCelulares = 0;
	}else{
		totalCelulares = (sospechoso.celulares).split(", ").length;
	}
	
	if($("#spnDirecciones").text() == ''){
		totalDirecciones = 0;
	}else{
		totalDirecciones = (sospechoso.direcciones).split(", ").length;	
	}
}

$(document).ready(function(){

	$("#formEditarContacto").validate({
		submitHandler: function(form){
			$("#hdnIdSospechosoDatos").val($("#hdnIdSospechoso").text());
			$.ajax({
				url: 'editarDatosContacto',
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formEditarContacto").serialize(),
		 		success: function(sospechoso){
		 			initDatosContacto(sospechoso);
		 			$("#divMostrarContacto").show();
		 			$("#divEditarContacto").hide();

		 			$('#txtTelefonos_0').val("");
		 			$('#txtCorreo_0').val("");
		 			$('#txtCelulares_0').val("");
		 			$('#txtDirecciones_0').val("");
		 			$("#divMensajes").show();
		 			$("#divMensajes").append('<div class="alert alert-success alert-dismissable">'+
					                            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+
					                           '<a href="#" class="alert-link">Editado Correctamente</a>.'+
					                        '</div>');
		 		}
			});
		}
	});
});
$(document).on('click','#btnEditarContacto', function(e){
	//TABS A OCULTAR Y MOSTRAR
	var correo = $("#spnCorreos").text().split(", ");
	$("#camposCorreo").empty();
	$("#txtCorreo_0").val(correo[0]);
	if((totalCorreos+1) >= 2){
		for(var numCorreos = 1; numCorreos < totalCorreos; numCorreos++){
			$("#camposCorreo").append('<div class="form-group input-group" id="campoCorreo_'+numCorreos+'">'+
							      			'<span class="input-group-addon">Correo Electrónico: </span>'+
							      			'<input class="form-control" type="text" name="txtCorreo" value="'+correo[numCorreos]+'" id="txtCorreo_'+numCorreos+'" data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido." >'+
							      			'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposCorreo" id="btnEliminarCampos_'+num+'" type="button"><i class="fa fa-minus"></i></button></span>'+
							   		'</div>');
		}
	}
	
	var tel = $("#spnTelefonos").text().split(", ");
	$("#camposTelefonos").empty();
	$("#txtTelefonos_0").val(tel[0]);
	if(totalTelefonos >= 2){
		for(var numTelefonos = 1; numTelefonos < totalTelefonos; numTelefonos++){
			$("#camposTelefonos").append('<div class="form-group input-group" id="campoTelefono_'+numTelefonos+'">'+
								      		'<span class="input-group-addon">Teléfonos: </span>'+
								      		'<input class="form-control" type="text" name="txtTelefonos" value="'+tel[numTelefonos]+'" id="txtTelefonos_'+numTelefonos+'" data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido." >'+
								      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposTelefonos" id="btnEliminarTelefonos_'+x+'" type="button"><i class="fa fa-minus"></i></button></span>'+
   										'</div>');
		}
		//x = totalTelefonos;
	}
	
	var cel = $("#spnCelulares").text().split(", ");
	$("#camposCelulares").empty();
	$("#txtCelulares_0").val(cel[0]);
	if(totalCelulares >= 2){
		for(var numCelulares = 1; numCelulares < totalCelulares; numCelulares++){
			$("#camposCelulares").append('<div class="form-group input-group" id="campoCelulares_'+numCelulares+'">'+
								      		'<span class="input-group-addon">Celulares: </span>'+
								      		'<input class="form-control" type="text" name="txtCelulares" value="'+cel[numCelulares]+'" id="txtCelulares_'+numCelulares+'" data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido." >'+
								      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposCelulares" id="btnEliminarCelulares_'+y+'" type="button"><i class="fa fa-minus"></i></button></span>'+
								   		'</div>');
		}
	}
	
	var direc = $("#spnDirecciones").text().split(", ");
	$("#camposDirecciones").empty();
	$("#txtDirecciones_0").val(direc[0]);
	if(totalDirecciones >= 2){
		for(var numDirecciones = 1; numDirecciones < totalDirecciones; numDirecciones++){
			$("#camposDirecciones").append('<div class="form-group input-group" id="campoDirecciones_'+numDirecciones+'">'+
								      		'<span class="input-group-addon">Direcciones: </span>'+
								      		'<input class="form-control" type="text" name="txtDirecciones" value="'+direc[numDirecciones]+'" id="txtDirecciones_'+numDirecciones+'" >'+
								      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposDirecciones" id="btnEliminarDirecciones_'+z+'" type="button"><i class="fa fa-minus"></i></button></span>'+
								   		'</div>');
		}
	}
	
	$("#divMostrarContacto").hide();
	$("#divEditarContacto").show();
});
$(document).on('click','#btnCancelEditar', function(e){
	//TABS A MOSTRAR Y OCULTAR
	$("#divMostrarContacto").show();
	$("#divEditarContacto").hide();
});
var num=1;
//METODOS PARA GENERAR Y ELIMINAR COMPONENTES
$(document).on('click','#btnGeneraCampos', function(e){
	$("#camposCorreo").append('<div class="form-group input-group" id="campoCorreo_'+num+'">'+
					      		'<span class="input-group-addon">Correo Electrónico: </span>'+
					      		'<input class="form-control" type="text" name="txtCorreo" id="txtCorreo_'+num+'" data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido." >'+
					      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposCorreo" id="btnEliminarCampos_'+num+'" type="button"><i class="fa fa-minus"></i></button></span>'+
					   		'</div>');
	num++;
});
$(document).on('click','.eliminarCamposCorreo', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoCorreo_"+id1).remove();
});
var x=1;
$(document).on('click','#btnGenerarTelefonos', function(e){
	$("#camposTelefonos").append('<div class="form-group input-group" id="campoTelefono_'+x+'">'+
					      		'<span class="input-group-addon">Teléfonos: </span>'+
					      		'<input class="form-control" type="text" name="txtTelefonos" id="txtTelefonos_'+x+'" data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido." >'+
					      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposTelefonos" id="btnEliminarTelefonos_'+x+'" type="button"><i class="fa fa-minus"></i></button></span>'+
					   		'</div>');
	x++;
});
$(document).on('click','.eliminarCamposTelefonos', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoTelefono_"+id1).remove();
});
var y=1;
$(document).on('click','#btnGenerarCelulares', function(e){
	$("#camposCelulares").append('<div class="form-group input-group" id="campoCelulares_'+y+'">'+
					      		'<span class="input-group-addon">Celulares: </span>'+
					      		'<input class="form-control" type="text" name="txtCelulares" id="txtCelulares_'+y+'" data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido." >'+
					      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposCelulares" id="btnEliminarCelulares_'+y+'" type="button"><i class="fa fa-minus"></i></button></span>'+
					   		'</div>');
	y++;
});
$(document).on('click','.eliminarCamposCelulares', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoCelulares_"+id1).remove();
});
var z=1;
$(document).on('click','#btnGenerarDirecciones', function(e){
	$("#camposDirecciones").append('<div class="form-group input-group" id="campoDirecciones_'+z+'">'+
					      		'<span class="input-group-addon">Direcciones: </span>'+
					      		'<input class="form-control" type="text" name="txtDirecciones" id="txtDirecciones_'+z+'" >'+
					      		'<span class="input-group-btn"><button class="btn btn-outline btn-danger eliminarCamposDirecciones" id="btnEliminarDirecciones_'+z+'" type="button"><i class="fa fa-minus"></i></button></span>'+
					   		'</div>');
	z++;
});
$(document).on('click','.eliminarCamposDirecciones', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoDirecciones_"+id1).remove();
});
//////////////////////////CONTACTOS
$(document).ready(function(){
	initContactos();

	$("#hdnIdSospechosoContacto").val($("#hdnIdSospechoso").text());
	
	$("#formRegistrarContacto").validate({
		submitHandler: function(form){
			if($("#hdnTipoOperacion").val() == 'crear'){
				$.ajax({
					url : 'crearContacto',
					type : 'post',
					dataType : 'json',
					data : $("#formRegistrarContacto").serialize(),
					success : function(contactos) {
						initLlenarTabla(contactos);
						$("#divMensajes").show();
			 			$("#divMensajes").append('<div class="alert alert-success alert-dismissable">'+
						                            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+
						                           '<a href="#" class="alert-link">Contacto creado correctamente</a>.'+
						                        '</div>');
					}
				});
			}else if($("#hdnTipoOperacion").val() == 'editar'){
				$.ajax({
					url : 'editarContacto',
					type : 'post',
					dataType : 'json',
					data : $("#formRegistrarContacto").serialize(),
					success : function(contactos) {
						initLlenarTabla(contactos);
						$("#divMensajes").show();
			 			$("#divMensajes").append('<div class="alert alert-success alert-dismissable">'+
						                            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+
						                           '<a href="#" class="alert-link">Contacto editado correctamente</a>.'+
						                        '</div>');
					}
				});
			}
		}
	});
	
});
function initLlenarTabla(contactos){
	$("#divResultadoContactos").empty();
	var resultado = '';
	resultado +='<table class="table table-striped table-bordered table-hover dataTable" id="tblContactos">'+
					'<thead>'+
  					'<tr>'+
  						'<th>Código</th>'+
  						'<th>Nombres</th>'+
  						'<th>Apellido Paterno</th>'+
  						'<th>Apellido Materno</th>'+
  						'<th>Teléfono</th>'+
  						'<th>Celular</th>'+
  						'<th>Correo Electrónico</th>'+
  						'<th>Dirección</th>'+
  						'<th>Departamente</th>'+
  						'<th>Provincia</th>'+
  						'<th>Distrito</th>'+
  						'<th>Acción Editar</th>'+
  						'<th>Acción Quitar</th>'+
  					'</tr>'+
					'</thead><tbody>';
					$.each(contactos, function(i, contacto){
						resultado +='<tr>'+
										'<td id="codigo_'+contacto.idContacto+'">'+contacto.codigo+'</td>'+
				  						'<td id="nombres_'+contacto.idContacto+'">'+contacto.nombres+'</td>'+
				  						'<td id="apePaterno_'+contacto.idContacto+'">'+contacto.apellidoPaterno+'</td>'+
				  						'<td id="apeMaterno_'+contacto.idContacto+'">'+contacto.apellidoMaterno+'</td>'+
				  						'<td id="telefono_'+contacto.idContacto+'">'+contacto.telefono+'</td>'+
				  						'<td id="celular_'+contacto.idContacto+'">'+contacto.celular+'</td>'+
				  						'<td id="correo_'+contacto.idContacto+'">'+contacto.correoElectronico+'</td>'+
				  						'<td id="direccion_'+contacto.idContacto+'">'+contacto.direccion+'</td>'+
				  						'<td id="departamento_'+contacto.idContacto+'">'+contacto.departamento+'</td>'+
				  						'<td id="provincia_'+contacto.idContacto+'">'+contacto.provincia+'</td>'+
				  						'<td id="distrito_'+contacto.idContacto+'">'+contacto.distrito+'</td>'+
				  						'<td><button type="button" class="btn btn-outline btn-primary btn-xs btn-circle contactos" id="editar_'+contacto.idContacto+'" data-toggle="modal" data-target="#modalContactos"><i class="fa fa-edit fa-fw"></i></button></td>'+
				  						'<td><button type="button" class="btn btn-outline btn-danger btn-xs btn-circle contactos" id="desasignar_'+contacto.idContacto+'"><i class="fa fa-minus"></i></button></td>'+
			 		  				'</tr>';
					});
					resultado +='</tbody></table>';
					$("#divResultadoContactos").append(resultado);
					$("#tblContactos").dataTable();
}
$(document).on('click','.contactos', function(e){
	var id = this.id;
	var idA = id.split("_")[0];
	var idN = id.split("_")[1];
	switch(idA){
		case 'editar':
			$("#txtIdContacto").val(idN);
			$("#hdnTipoOperacion").val("editar");
			$("#divCodContacto").show();
			$("#spnCodigoContacto").empty();
			$("#spnCodigoContacto").append($("#codigo_"+idN).text());
			$("#txtNombres").val($("#nombres_"+idN).text());
			$("#txtApePaterno").val($("#apePaterno_"+idN).text());
			$("#txtApeMaterno").val($("#apeMaterno_"+idN).text());
			$("#txtTelefono").val($("#telefono_"+idN).text());
			$("#txtCelular").val($("#celular_"+idN).text());
			$("#txtCorreoElectronico").val($("#correo_"+idN).text());
			$("#txtDireccion").val($("#direccion_"+idN).text());
			$("#txtDepartamento").val($("#departamento_"+idN).text());
			$("#txtProvincia").val($("#provincia_"+idN).text());
			$("#txtDistrito").val($("#distrito_"+idN).text());
		break;
		case 'desasignar':
			var respuesta = confirm('¿Esta seguro que desea quitar este contacto?');
			if(respuesta){
				$.ajax({
					url : 'quitarContacto-'+$("#hdnIdSospechoso").text()+'-'+idN,
					type : 'post',
					dataType : 'json',
					data : '',
					success : function(contactos) {
						initLlenarTabla(contactos);
						$("#divMensajes").show();
			 			$("#divMensajes").append('<div class="alert alert-danger alert-dismissable">'+
						                            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+
						                           '<a href="#" class="alert-link">Contacto eliminado correctamente</a>.'+
						                        '</div>');
					}
				});
			}			
		break;
	}
});
function initContactos(){
		$.ajax({
			url : 'getContactos-'+$("#hdnIdSospechoso").text(),
			type : 'post',
			dataType : 'json',
			data : '',
			success : function(contactos) {
				initLlenarTabla(contactos);
			}
		});
	}
$(document).on('click','#btnCrearContacto', function(e){
	$("#hdnTipoOperacion").val("crear");
	$("#divCodContacto").hide();
	limpiarFormContactos();
});
function limpiarFormContactos(){
	$("#txtNombres").val("");
	$("#txtApePaterno").val("");
	$("#txtApeMaterno").val("");
	$("#txtTelefono").val("");
	$("#txtCelular").val("");
	$("#txtCorreoElectronico").val("");
	$("#txtDireccion").val("");
	$("#txtDepartamento").val("");
	$("#txtProvincia").val("");
	$("#txtDistrito").val("");
}
</script>
<!-- MOSTRAR DATOS DE CONTACTO -->
<div id="divMensajes" style="display: none;"></div>
<div id="divMostrarDatosContacto">
	<div id="divMostrarContacto">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Datos de Contacto del Investigado:</span>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarContacto"><i class="fa fa-edit fa-fw"></i> Editar</button>
					</div>
				</div>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
				<div class="form-group">
	          		<label>Correo Electrónicos: </label>
	          		<span id="spnCorreos">&nbsp;</span>
	       		</div>
	       		<div class="form-group">
	          		<label>Teléfonos: </label>
	          		<span id="spnTelefonos">&nbsp;</span>
	       		</div>
	       		<div class="form-group">
	          		<label>Celulares: </label>
	          		<span id="spnCelulares">&nbsp;</span>
	       		</div>
	       		<div class="form-group">
	          		<label>Direcciones: </label>
	          		<span id="spnDirecciones">&nbsp;</span>
	       		</div>
			</div>
		</div>
	</div>
	<!-- EDITAR DATOS DE CONTACTO -->
	<div style="display: none;" id="divEditarContacto">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Datos de Contacto del Investigado:</span>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
				<form:form class="form-horizontal" id="formEditarContacto" action="editarContacto" commandName="sospechoso">
					<input type="hidden" name="idSospechoso" id="hdnIdSospechosoDatos">
					<div class="form-group input-group">
						<span class="input-group-addon">Correo Electrónico: </span>
		          		<input class="form-control" type="text" name="txtCorreo" id="txtCorreo_0" data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido." > 
		          		<span class="input-group-btn">
		          			<button class="btn btn-outline btn-success" id="btnGeneraCampos" type="button"><i class="fa fa-plus"></i></button>
		          		</span>
		       		</div>
		       		<div id="camposCorreo">
		       		</div>
		       		<div class="form-group input-group">
		          		<span class="input-group-addon">Teléfonos: </span>
		          		<input class="form-control" type="text" name="txtTelefonos" id="txtTelefonos_0" data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido." > 
		          		<span class="input-group-btn">
		          			<button class="btn btn-outline btn-success" id="btnGenerarTelefonos" type="button"><i class="fa fa-plus"></i></button>
		          		</span>
		       		</div>
		       		<div id="camposTelefonos">
		       		</div>
		       		<div class="form-group input-group">
		       			<span class="input-group-addon">Celulares: </span>
		          		<input class="form-control" type="text" name="txtCelulares" id="txtCelulares_0" data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido."  >
		          		<span class="input-group-btn">
		          			<button class="btn btn-outline btn-success" id="btnGenerarCelulares" type="button"><i class="fa fa-plus"></i></button>
		          		</span>
		       		</div>
		       		<div id="camposCelulares">
		       		</div>
		       		<div class="form-group input-group">
		          		<span class="input-group-addon">Direcciones: </span>
		          		<input class="form-control" type="text" name="txtDirecciones" id="txtDirecciones_0"  > 
		          		<span class="input-group-btn">
                        	<button class="btn btn-outline btn-success" id="btnGenerarDirecciones" type="button"><i class="fa fa-plus"></i></button>
                        </span>
		       		</div>
		       		<div id="camposDirecciones">
		       		</div>
		       		<hr>
		       		<div class="well">
			       		<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar</button>
				        <button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
				        <button class="btn btn-outline btn-warning" type="button" id="btnCancelEditar"><i class="fa fa-arrow-left"></i> Cancel</button>
		       		</div>
		       	</form:form>
			</div>
		</div>
	</div>
	<!-- CONTACTOS -->
	<div id="divMostrarContacto">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Contactos:</span>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnCrearContacto" data-toggle="modal" data-target="#modalContactos" ><i class="fa fa-edit fa-fw"></i> Crear Contacto</button>
					</div>
				</div>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
				<div class="table-responsive">
   					<div id="divResultadoContactos" class="dataTables_wrapper form-inline" role="grid" style="overflow-x: scroll; width: 99%;">
   					
   					</div>
   				</div>
			</div>
		</div>
	</div>
	<!-- MODAL -->
	<div class="modal fade" id="modalContactos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       <div class="modal-dialog">
           <div class="modal-content" style="width: 100%;">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   <h4 class="modal-title" id="myModalLabel">Agregar Contacto</h4>
               </div>
               <div class="modal-body">
					<div class="panel-body">
						<form:form class="form-horizontal" id="formRegistrarContacto" commandName="contacto">
	                   <input type="hidden" id="hdnIdSospechosoContacto" name="idSospechosoAux"/>
	                   <input type="hidden" id="hdnTipoOperacion"/>
	                   <input type="hidden" name="idContacto" id="txtIdContacto"/>
							<div class="form-group" style="display: none;" id="divCodContacto">
								<label>Código: </label> 
								<span id="spnCodigoContacto">&nbsp;</span>
							</div>
							<div class="form-group">
								<label>nombres: </label> 
								<input class="form-control" type="text" name="nombres"  id="txtNombres"  data-rule-required="true" data-msg-required="*">	
							</div>	
							<div class="form-group">
				          		<label >Apellido Paterno: </label>
			          			<input class="form-control" type="text" name="apellidoPaterno"  id="txtApePaterno" >
				       		</div>	       		
				       		<div class="form-group">
				          		<label >Apellido Materno: </label>
				          		<input class="form-control" type="text" name="apellidoMaterno"  id="txtApeMaterno" >
				       		</div>
				       		<div class="form-group">
				          		<label>Telefono: </label>
			          			<input class="form-control" type="text" name="telefono" id="txtTelefono"  data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido." >
				       		</div>
				       		<div class="form-group">
				          		<label >Celular: </label>
			          			<input class="form-control" type="text" name="celular" id="txtCelular"  data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido."  >
				       		</div>	
				       		<div class="form-group">
				          		<label >Correo Electrónico: </label>
			          			<input class="form-control" type="text" name="correoElectronico" id="txtCorreoElectronico"  data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido." >
				       		</div>
				       		<div class="form-group">
				          		<label >Direccion: </label>
			          			<input class="form-control" type="text" name="direccion" id="txtDireccion" >
				       		</div>	
				       		<div class="form-group">
				          		<label >Departamento: </label>
				          		<select class="form-control" id="txtDepartamento" name="departamento">
				          			<jsp:include page="../../componentes/selectDepartamento.jsp" />
				          		</select>
				       		</div>
				       		<div class="form-group">
				          		<label >Provincia: </label>
				          		<select class="form-control" id="txtProvincia" name="provincia">
				          			<jsp:include page="../../componentes/selectProvincia.jsp" />
				          		</select>
				       		</div>
				       		<div class="form-group">
				          		<label >Distrito: </label>
				          		<select class="form-control" name="distrito" id="txtDistrito">
				          			<jsp:include page="../../componentes/selectDistrito.jsp" />
				          		</select>
				       		</div>
							<hr class="">
							<div class="well">
								<button class="btn btn-outline btn-success" 
								id="btnRegistrarContacto" type="submit">
									<i class="fa fa-check"></i> Registrar Contacto
								</button>
								<button class="btn btn-outline btn-danger" type="reset">
									<i class="fa fa-refresh fa-fw"></i> Reset
								</button>
							</div>
						</form:form>
					</div>
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-outline btn-default" data-dismiss="modal">Close</button>
               </div>
           </div>
           <!-- /.modal-content -->
       </div>
       <!-- /.modal-dialog -->
   	</div>
	<!-- / MODAL -->
</div>