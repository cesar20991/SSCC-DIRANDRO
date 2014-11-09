<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
function initSospechoso(sospechoso){
	//CABECERA...
	$("#hdrCodigoUnicoDeIdentificacion").empty();
	$("#hdrPrimerApellido").empty();
	$("#hdrSegundoApellido").empty();
	$("#hdrPrenombres").empty();
	$("#hdrAlias").empty();
	$("#hdrSexo").empty();
	//
	$("#hdrCodigoUnicoDeIdentificacion").append(sospechoso.codigoUnicoDeIdentificacion);
	$("#hdrPrimerApellido").append(sospechoso.primerApellido);
	$("#hdrSegundoApellido").append(sospechoso.segundoApellido+",");
	$("#hdrPrenombres").append(sospechoso.preNombres);
	$("#hdrAlias").append(sospechoso.alias);
	//...FINAL CABECERA
	if(sospechoso.sexo == 'F'){
		$("#hdrSexo").append("Femenino");
	}else if(sospechoso.sexo == 'M'){
		$("#hdrSexo").append("Masculino");
	}
	//TAB PRINCIPAL
	$("#spnCodigoUnicoDeIdentificacion").empty();
	$("#spnPrimerApellido").empty();
	$("#spnSegundoApellido").empty();
	$("#spnPrenombres").empty();
	$("#spnAlias").empty();
	$("#spnSexo").empty();
	$("#spnFecNac").empty();
	$("#spnDepartamentoNacimiento").empty();
	$("#spnProvinciaNacimiento").empty();
	$("#spnDistritoNacimiento").empty();
	$("#spnGradoInstruccion").empty();
	$("#spnEstadoCivil").empty();
	$("#spnEstatura").empty();
	$("#spnInscripcion").empty();
	$("#spnNombrePadre").empty();
	$("#spnNombreMadre").empty();
	$("#spnEmision").empty();
	$("#spnRestriccion").empty();
	$("#spnDomicilio").empty();
	$("#spnDepartamentoDeNacimiento").empty();
	$("#spnProvinciaDeNacimiento").empty();
	$("#spnDistritoDeNacimiento").empty();
	$("#spnMultasElectorales").empty();
	$("#tdImagen").empty();
	
	if(sospechoso.urlSospechoso == null){
		$("#tdImagen").append('<img src="img/skills.png" alt="foto" style="width: 90px; height: 120px;" />');
	}else{
		$("#tdImagen").append('<img src="'+sospechoso.urlSospechoso+'" alt="logo" style="width: 90px; height: 120px;" />');
	}
	$("#spnCodigoUnicoDeIdentificacion").append(sospechoso.codigoUnicoDeIdentificacion);
	$("#spnPrimerApellido").append(sospechoso.primerApellido);
	$("#spnSegundoApellido").append(sospechoso.segundoApellido);
	$("#spnPrenombres").append(sospechoso.preNombres);
	$("#spnAlias").append(sospechoso.alias);
	if(sospechoso.sexo == 'F'){
		$("#spnSexo").append("Femenino");
	}else if(sospechoso.sexo == 'M'){
		$("#spnSexo").append("Masculino");
	}	 			
	
	if(sospechoso.fechaDeNacimiento != null){
		var fec  = sospechoso.fechaDeNacimiento;
		$("#spnFecNac").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	}else{
		$("#spnFecNac").append('');
	}	
	
	$("#spnDepartamentoNacimiento").append(sospechoso.departamentoDeNacimiento);
	$("#spnProvinciaNacimiento").append(sospechoso.provinciaDeNacimiento);
	$("#spnDistritoNacimiento").append(sospechoso.distritoDeNacimiento);
	$("#spnGradoInstruccion").append(sospechoso.gradoDeInstruccion);
	$("#spnEstadoCivil").append(sospechoso.estadoCivil);
	$("#spnEstatura").append(sospechoso.estatura);
	if(sospechoso.fechaDeInscripcion != null){
		var fec  = sospechoso.fechaDeInscripcion;
		$("#spnInscripcion").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	}else{
		$("#spnInscripcion").append('');
	}
	$("#spnNombrePadre").append(sospechoso.nombrePadre);
	$("#spnNombreMadre").append(sospechoso.nombreMadre);
	if(sospechoso.fechaDeEmision != null){
		var fec  = sospechoso.fechaDeEmision;
		$("#spnEmision").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	}else{
		$("#spnEmision").append('');
	}
	$("#spnRestriccion").append(sospechoso.restriccion);
	$("#spnDomicilio").append(sospechoso.domicilio);
	$("#spnDepartamentoDeDomicilio").append(sospechoso.departamentoDeDomicilio);
	$("#spnProvinciaDeDomicilio").append(sospechoso.provinciaDeDomicilio);
	$("#spnDistritoDeDomicilio").append(sospechoso.distritoDeDomicilio);
	$("#spnMultasElectorales").append(sospechoso.multasElectorales);
	//$("#spnFecNac").append(sospechoso.fechaDeNacimiento);
	//$("#spnGradoInstruccion").append(sospechoso.gradoDeInstruccion);
}

var flag = true;
var flag2 = true;
$(document).ready(function(){
	$('#sandbox-container .input-group.date').datepicker({
		format: "dd/mm/yyyy",
		language: "es",
	    autoclose: true,
	    todayHighlight: true
	});
	//$(".datepicker").datepicker({dateFormat: 'dd/mm/yy'});
	//esto es para que los checkbox del editar esten en blanco cuando se carga la pagina
	$("#checkFemenino").prop("checked", false);
	$("#checkMasculino").prop("checked", false);
	
	var idSospechoso = $("#hdnIdSospechoso").text();
	
		$.ajax({
	 		url: 'getSopechoso-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(sospechoso){
	 			initSospechoso(sospechoso);
	 			initDatosContacto(sospechoso);
	 		}
	 	});
		
		/* validacion para editar */
		$("#formEditarSospechoso").validate({
			rules:{
				txtFecNac: {peruDate: true},
				txtEstatura: {doubleNumber: true},
				txtInscripcion: {peruDate: true},
				txtEmision: {peruDate: true},
				txtCodUnico: {number: true, minlength: 8, maxlength: 8},
				txtMultasElectorales: {number: true, maxlength:4}
			},
			messages:{
				txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
				txtEstatura: "Solo Números",
				txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
				txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
				txtCodUnico: "Sólo Números, 8 digitos",
				txtMultasElectorales: "Sólo Números"
			},
			submitHandler: function(form){
				//Se usa 1000-12-12 para que pase de la vista al controlador
				//y en el implements se seteara como null.
				if($("#txtFecNac").val() == ''){
					$("#hdnFecNac").val('1000-12-12');
				}
				
				if($("#txtInscripcion").val() == ''){
					$("#hdnFecIns").val('1000-12-12');
				}
				
				$("#hdnEstatura").val($("#txtEstatura").val());
				$("#hdnMultasElectorales").val($("#txtMultasElectorales").val());
				$("#hdnCodUnico").val($("#txtCodUnico").val());
				
				if($("#txtEmision").val() == ''){
					$("#hdnFecEmi").val('1000-12-12');
				}
				//$("#hdnFecEmi").val($("#txtEmision").val());
				if(flag == true && flag2 == true){
					$.ajax({
				 		url: 'editarSopechoso',
				 		type: 'post',
				 		dataType: 'json',
				 		data: $("#formEditarSospechoso").serialize(),
				 		success: function(sospechoso){
				 			initSospechoso(sospechoso);
				 			$("#divMostrarSospechoso").show();
				 			$("#divEditarSospechoso").hide();
				 		}
				 	});
				}else{
					alert("Debe Corregir los datos");
				}
				}
			});
		});
$(document).on('change','#txtFecNac', function(e){
	if($("#txtFecNac").val() != null){
		var fec  = $("#txtFecNac").val();
		$("#hdnFecNac").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('change','#txtEmision', function(e){
	if($("#txtInscripcion").val() != null){
		var fec  = $("#txtInscripcion").val();
		$("#hdnFecIns").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('change','#txtEmision', function(e){
	if($("#txtEmision").val() != null){
		var fec  = $("#txtEmision").val();
		$("#hdnFecEmi").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('click','#btnEditarSopechoso', function(e){
	$("#txtCodUnico").val($("#spnCodigoUnicoDeIdentificacion").text());
	$("#txtPrimerApellido").val($("#spnPrimerApellido").text());
	$("#txtSegundoApellido").val($("#spnSegundoApellido").text());
	$("#txtPrenombres").val($("#spnPrenombres").text());
	$("#txtAlias").val($("#spnAlias").text());
	
	if($("#spnSexo").text() == 'Masculino'){
		$("#checkMasculino").prop("checked",true);
	}else if($("#spnSexo").text() == 'Femenino'){
		$("#checkFemenino").prop("checked",true);
	}
	
	$("#txtFecNac").val($("#spnFecNac").text());
	$("#txtDepartamentoDeNacimiento").val($("#spnDepartamentoNacimiento").text());
	$("#txtProvinciaDeNacimiento").val($("#spnProvinciaNacimiento").text());
	$("#txtDistritoDeNacimiento").val($("#spnDistritoNacimiento").text());
	$("#selectGradoInstruccion").val($("#spnGradoInstruccion").text());
	$("#sltcEstadoCivil").val($("#spnEstadoCivil").text());
	$("#txtEstatura").val($("#spnEstatura").text());
	$("#txtInscripcion").val($("#spnInscripcion").text());
	$("#txtNombrePadre").val($("#spnNombrePadre").text());
	$("#txtNombreMadre").val($("#spnNombreMadre").text());
	$("#txtEmision").val($("#spnEmision").text());
	$("#txtRestriccion").val($("#spnRestriccion").text());
	$("#txtDomicilio").val($("#spnDomicilio").text());
	$("#txtDepartamentoDeDomicilio").val($("#spnDepartamentoDeDomicilio").text());
	$("#txtProvinciaDeDomicilio").val($("#spnProvinciaDeDomicilio").text());
	$("#txtDistritoDeDomicilio").val($("#spnDistritoDeDomicilio").text());
	$("#txtMultasElectorales").val($("#spnMultasElectorales").text());
	/// ID SOSPECHOSO en ventana
	$("#hdnIdSospechosoEdit").val($("#hdnIdSospechoso").text());
	// LOS TABS
	$("#divMostrarSospechoso").hide();
	$("#divEditarSospechoso").show();
});

$(document).on('click','#btnCancelEditar', function(e){
	$("#divMostrarSospechoso").show();
	$("#divEditarSospechoso").hide();
});
$(document).on('change','#txtAlias', function(e){
	$.ajax({
		url: 'getAlias-'+$('#txtAlias').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechoso){
			if(sospechoso == true){
				$("#alertasSospechosoNuevo").show();
				$("#alertasSospechosoNuevo").empty();
				$("#alertasSospechosoNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">El Alias usado ya existe en otro sospechoso.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
$(document).on('change','#txtCodUnico', function(e){
	$.ajax({
		url: 'getCUI-'+$('#txtCodUnico').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechoso){
			if(sospechoso == true){
				$("#alertasSospechosoNuevo2").show();
				$("#alertasSospechosoNuevo2").empty();
				$("#alertasSospechosoNuevo2").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">El Código Único de Identificación usado ya existe en otro sospechoso.</strong>'+
	 			    '</div>');
				flag2 = false;
			}else{
				flag2 = true;
			}
		}
	});
});
</script>
<div id="divMostrarDatosSospechoso">
	<div id="divMostrarSospechoso">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Datos del Sospechoso:</span>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarSopechoso"><i class="fa fa-edit fa-fw"></i> Editar</button>
					</div>
				</div>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
				<div class="col-lg-6">
					<div class="form-group">
		          		<label title="código único de identificación">C.U.I: </label>
		          		<label class="radio-inline">
		          			<span id="spnCodigoUnicoDeIdentificacion">&nbsp;</span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Apellidos: </label>
		          		<label class="radio-inline">
		          			<span id="spnPrimerApellido">&nbsp;</span>&nbsp;&nbsp;<span id="spnSegundoApellido">&nbsp;</span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Prenombres: </label>
		          		<label class="radio-inline">
		          			<span id="spnPrenombres">&nbsp;</span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Alias: </label>
		          		<label class="radio-inline">
		          			<span id="spnAlias">&nbsp;</span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Sexo: </label>
		          		<label class="radio-inline">
		          			<span id="spnSexo">&nbsp;</span>
		          		</label>
		       		</div> 
		       		<div class="form-group">
		          		<label>Fecha de Nacimiento: </label>
		          		<label class="radio-inline">
		          			<span id="spnFecNac">&nbsp;</span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		       			<label>Departamento de Nacimiento: </label>
		       			<label class="radio-inline">
		       				<span  id="spnDepartamentoNacimiento"></span>
			          	</label>
			       	</div>
			       	<div class="form-group">
			       		<label>Provincia de Nacimiento: </label>
		       			<label class="radio-inline">
		       				<span  id="spnProvinciaNacimiento"></span>
		       			</label>
			       	</div>
			       	<div class="form-group">
			       		<label>Distrito de Nacimiento: </label>
		       			<label class="radio-inline">
		       				<span  id="spnDistritoNacimiento"></span>
		       			</label>
			       	</div>
			       	<div class="form-group">
			       		<label>Grado de Instrucción: </label>
		       			<label class="radio-inline">
		       				<span  id="spnGradoInstruccion"></span>
		          		</label>
			       	</div>
			       	<div class="form-group" id="divGrado">
		       			<label>Estado Civil: </label>
	          			<label class="radio-inline">
	          				<span  id="spnEstadoCivil"></span>
		          		</label>
			       	</div>
				</div>
				<div class="col-lg-6">
						<div class="form-group">
		          		<label>Estatura: </label>
		          		<label class="radio-inline">
		          			<span id="spnEstatura"></span>
		          		</label>
			       	</div>
		       		<div class="form-group">
		          		<label>Fecha de Inscripción: </label>
		          		<label class="radio-inline">
		          			<span id="spnInscripcion"></span>
		          		</label>
			       	</div>
			       	<div class="form-group">
		          		<label>Nombre del Padre: </label>
		          		<label class="radio-inline">
		          			<span id="spnNombrePadre"></span>
		          		</label>
			       	</div>
		       		<div class="form-group">
		          		<label>Nombre de la Madre: </label>
		          		<label class="radio-inline">
		          			<span id="spnNombreMadre"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Fecha de Emisión: </label>
		          		<label class="radio-inline">
		          			<span id="spnEmision"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Restricción: </label>
		          		<label class="radio-inline">
		          			<span id="spnRestriccion"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Domicilio: </label>
		          		<label class="radio-inline">
		          			<span id="spnDomicilio"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Departamento de Domicilio: </label>
		          		<label class="radio-inline">
		          			<span id="spnDepartamentoDeDomicilio"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Provincia de Domicilio: </label>
		          		<label class="radio-inline">
		          			<span id="spnProvinciaDeDomicilio"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Distrito de Domicilio: </label>
		          		<label class="radio-inline">
		          			<span id="spnDistritoDeDomicilio"></span>
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Multas Electorales: </label>
		          		<label class="radio-inline">
		          			<span id="spnMultasElectorales"></span>
		          		</label>
		       		</div>
				</div>
			</div>
		</div>
	</div>
		
	<!-- Formulario editar-->
	<div style="display: none;" id="divEditarSospechoso">
		<div id="alertasSospechosoNuevo" style="display: none;">
		</div>
		<div id="alertasSospechosoNuevo2" style="display: none;">
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Editar Datos Personales del Sospechoso:</span>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
			<form:form class="form-horizontal" id="formEditarSospechoso" action="editarSospechoso" commandName="sospechoso">
				<input type="hidden" name="idSospechoso" id="hdnIdSospechosoEdit">
				<div class="col-lg-5">
					<div class="form-group">
		          		<label title="Código Único de Identificación">C.U.I: </label>
	          			<input class="form-control" type="text" name="txtCodUnico" id="txtCodUnico">	          			
		       		</div>
		       		<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
		       		<div class="form-group">
		          		<label>Primer Apellido: </label>
		          		<input class="form-control" type="text" id="txtPrimerApellido" name="primerApellido">
		       		</div>
		       		<div class="form-group">
		          		<label>Segundo Apellido: </label>
		          		<input class="form-control" type="text" id="txtSegundoApellido" name="segundoApellido">
		       		</div>
		       		<div class="form-group">
		          		<label>Prenombres: </label>
		          		<input class="form-control" type="text" id="txtPrenombres" name="preNombres">
		       		</div>
		       		<div class="form-group">
		          		<label>Alias: </label>
		          		<input class="form-control" type="text" id="txtAlias" name="alias" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label>Sexo: </label>
		          		<label class="radio-inline">
		          			<input type="radio" name="sexo" id="checkMasculino" value="M">Masculino
		          		</label>
		          		<label class="radio-inline">
		          			<input type="radio" name="sexo" id="checkFemenino" value="F">Femenino
		          		</label>
		       		</div>
		       		<div class="form-group">
		          		<label>Fecha de Nacimiento: </label>
		          		<div id="sandbox-container">
				          	<div class="input-group date">
	          					<input class="form-control datepicker" type="text" name="txtFecNac" id="txtFecNac">
	          					<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
	          				</div>
	          			</div>
		       		</div>
		       		<input class="span2" type="hidden" name="fechaDeNacimiento" id="hdnFecNac">
		       		<div class="form-group">
		          		<label>Departamento de Nacimiento: </label>
		          		<input class="form-control" type="text" name="departamentoDeNacimiento" id="txtDepartamentoDeNacimiento">
		       		</div>
		       		<div class="form-group">
		          		<label>Provincia de Nacimiento: </label>
		          		<input class="form-control" type="text" name="provinciaDeNacimiento" id="txtProvinciaDeNacimiento">
		       		</div>
		       		<div class="form-group">
		          		<label>Distrito de Nacimiento: </label>
		          		<input class="form-control" type="text" name="distritoDeNacimiento" id="txtDistritoDeNacimiento">
		       		</div>
		       		<div class="form-group">
		          		<label>Grado de Instrucción: </label>
	          			<select class="form-control" name="gradoDeInstruccion" id="selectGradoInstruccion">
	          				<option value="">No Precisa</option>
	          				<option>Preescolar</option>
	          				<option>Primaria</option>
	          				<option>Secundaria</option>
	          				<option>Superior</option>
			            </select>
		       		</div>
		       		<div class="form-group" id="divGrado">
		          		<label>Estado Civil: </label>
	          			<select class="form-control" name="estadoCivil" id="sltcEstadoCivil">
	          				<option value="">No Precisa</option>
	          				<option>Casado</option>
	          				<option>Divorciado</option>
	          				<option>Soltero</option>
	          				<option>Viudo</option>
			            </select>
		       		</div>
				</div>
				<div class="col-lg-5 col-md-offset-1">
					<div class="form-group">
		          		<label>Estatura: </label>
	          			<input class="form-control" type="text" name="txtEstatura" id="txtEstatura">	          			
		       		</div>
		       		<input class="span2" type="hidden" name="estatura" id="hdnEstatura">
		       		<!-- <div class="form-group">
		          		<label>Fecha de Inscripción: </label>
		          		<div id="sandbox-container">
				          	<div class="input-group date">
				          		<input class="form-control datepicker" type="text" name="txtInscripcion" id="txtInscripcion">
				          		<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
				          	</div>
				        </div>	          			
		       		</div>
		       		<input class="span2" type="hidden" name="fechaDeInscripcion" id="hdnFecIns"> -->
		       		<div class="form-group">
		          		<label>Nombre del Padre: </label>
		          		<input class="form-control" type="text" name="nombrePadre" id="txtNombrePadre">
		       		</div>
		       		<div class="form-group">
		          		<label>Nombre de la Madre: </label>
		          		<input class="form-control" type="text" name="nombreMadre" id="txtNombreMadre">
		       		</div>
		       		<!-- <div class="form-group">
		          		<label>Fecha de Emisión: </label>
		          		<div id="sandbox-container">
				          	<div class="input-group date">
	          					<input class="form-control datepicker" type="text" name="txtEmision" id="txtEmision">
	          					<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
	          				</div>
	          			</div>
		       		</div>
		       		<input class="span2" type="hidden" name="fechaDeEmision" id="hdnFecEmi"> -->
		       		<div class="form-group">
		          		<label>Restricción: </label>
		          		<input class="form-control" type="text" name="restriccion" id="txtRestriccion">
		       		</div>
		       		<div class="form-group">
		          		<label>Domicilio: </label>
		          		<input class="form-control" type="text" name="domicilio" id="txtDomicilio">
		       		</div>
		       		<div class="form-group">
		          		<label>Departamento de Domicilio: </label>
		          		<input class="form-control" type="text" name="departamentoDeDomicilio" id="txtDepartamentoDeDomicilio">
		       		</div>
		       		<div class="form-group">
		          		<label>Provincia de Domicilio: </label>
		          		<input class="form-control" type="text" name="provinciaDeDomicilio" id="txtProvinciaDeDomicilio">
		       		</div>
		       		<div class="form-group">
		          		<label>Distrito de Domicilio: </label>
		          		<input class="form-control" type="text" name="distritoDeDomicilio" id="txtDistritoDeDomicilio">
		       		</div>
		       		<div class="form-group">
		          		<label>Multas Electorales: </label>
	          			<input class="form-control" type="text" name="txtMultasElectorales" id="txtMultasElectorales">
		       		</div>
		       		<input class="span2" type="hidden" name="multasElectorales" id="txtMultasElectorales">		       		
				</div>
				<hr class="col-lg-12">
	       		<div class="well col-lg-12">
		       		<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar Sospechoso</button>
		        	<button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
		        	<button class="btn btn-outline btn-warning" type="button" id="btnCancelEditar"><i class="fa fa-arrow-left"></i> Cancel</button>
	       		</div>
			</form:form>
			</div>
		</div>			
	</div>
	
</div>

