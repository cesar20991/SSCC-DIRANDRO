<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
function initPerfil(perfil){
	$("#spnPrimerNombe").empty();
		$("#spnSegundoNombe").empty();
		$("#hdrPrimerNombe").empty();
		$("#hdrSegundoNombe").empty();
		$("#hdrApePaterno").empty();
		$("#hdrApeMaterno").empty();
		$("#hdrCodigo").empty();
		$("#hdrGrado").empty();
		$("#hdrNCarnet").empty();
		$("#hdrEntidad").empty();
		
		$("#spnApePaterno").empty();
		$("#spnApeMaterno").empty();
		$("#spnDni").empty();
		$("#hrdDni").empty();
		$("#spnTelefono").empty();
		$("#hdrTelefono").empty();
		$("#spnCorreo").empty();
		$("#hdrCorreo").empty();
		$("#spnFecNac").empty();
		$("#spnSexo").empty();
		$("#spnEntidad").empty();
		$("#spnCargo").empty();
		$("#hdrCargo").empty();
		$("#spnNCarnet").empty();
		$("#spnGrado").empty();
		$("#spnRango").empty();
		$("#tdImagen").empty();
			
		$("#spnPrimerNombe").text(perfil.primerNombre);
		$("#spnSegundoNombe").text(perfil.segundoNombre);
		$("#hdrPrimerNombe").text(perfil.primerNombre);
		$("#hdrSegundoNombe").text(perfil.segundoNombre);
		$("#hdrApePaterno").text(perfil.apePaterno);
		$("#hdrApeMaterno").text(perfil.apeMaterno);
		$("#spnApePaterno").text(perfil.apePaterno);
		$("#spnApeMaterno").text(perfil.apeMaterno);
		$("#spnDni").text(perfil.dni);
		$("#hdrDni").text(perfil.dni);
		$("#spnTelefono").text(perfil.telefono);
		$("#spnCorreo").text(perfil.correoElectronico);
		$("#hdrCorreo").text(perfil.correoElectronico);
		$("#spnFecNac").text(perfil.fecNacimiento);
		$("#hdrCodigo").text(perfil.codigoPerfil);
		if(perfil.urlPerfil == null){
			$("#tdImagen").append('<img src="img/skills.png" alt="logo" style="width: 90px; height: 120px;" />');
		}else{
			$("#tdImagen").append('<img src="'+perfil.urlPerfil+'" alt="logo" style="width: 90px; height: 120px;" />');
		}
		
		if(perfil.sexo == 'M'){
			$("#spnSexo").text('Masculino');
		}else{
			$("#spnSexo").text('Femenino');
		}
		if(perfil.entidadPerteneciente == 'D'){
			$("#spnEntidad").text("DIRANDRO");
			$("#hdrEntidad").text("DIRANDRO");
			$("#spnCargo").text(perfil.cargo);
			$("#hdrCargo").text(perfil.cargo);
			$("#spnGrado").text(perfil.grado);
			$("#hdrGrado").text(perfil.grado);
			$("#hdrNCarnet").text(perfil.numeroDeCarnet);
			$("#spnNCarnet").text(perfil.numeroDeCarnet);
			$("#spnRango").text(perfil.rango);
		}else if(perfil.entidadPerteneciente == 'M'){
			$("#spnEntidad").text("Ministerio Público");
			$("#hdrEntidad").text("Ministerio Público");
			$("#divCargo").hide();
			$("#divGrado").hide();
			$("#divCarnet").hide();
			$("#divRango").hide();
			
			$("#tdGrado").empty();
			$("#tdGradoResult").empty();
			$("#tdNCarnet").empty();
			$("#tdNCarnetResult").empty();
			
			$("#tdCargo").empty();
			$("#tdCargo").append("Tipo Fiscal");
			
			$("#divFiscal").show();
			$("#hdrCargo").text(perfil.tipoFiscal);
			$("#spnTipoFiscal").text(perfil.tipoFiscal);
		}
}
$(document).ready(function(){

	var idPerfil;
	if($("#hdnIdPerfil").text() != ""){
		idPerfil = $("#hdnIdPerfil").text();
	}else{
		idPerfil = '${pageContext.session.getAttribute("idPerfil")}';
	}
	
		$.ajax({
	 		url: 'getPerfil-'+idPerfil,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(perfil){
	 			initPerfil(perfil);		 				 
	 		}
	 	});
		
		$("#formEditarUsuario").validate({
			rules:{
				txtNumeroDeCarnet:  {required: true, number: true, minlength: 6, maxlength: 8},
				txtCorreo: {required: true, email:true},
				txtDni: {required: true, number: true, minlength: 8, maxlength: 8}
			},
			messages:{
				txtNumeroDeCarnet : "Solo Números, con 8 digitos",
				txtCorreo : "Debe ser un Correo Electronico",
				txtDni : "Solo Números de 8 digitos"
			},
			submitHandler: function(form){
				
				$("#hdnNumeroDeCarnet").val($("#txtNumeroDeCarnet").val());
				$("#hdnCorreo").val($("#txtCorreo").val());
				$("#hdnDni").val($("#txtDni").val());
				
				$.ajax({
			 		url: 'editarUsuario-'+$("#hdnIdPerfil").text(),
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarUsuario").serialize(),
			 		success: function(perfil){
			 			initPerfil(perfil);
			 			$("#divPerfilMostrar").show();
			 			$("#btnEditarPerfil").show();
			 			$("#divPerfilEditar").hide();
			 		}
			 	});
				//if(flag == true && flag2 == true && flag3 == true){
					//form.submit();
				/*}else if($("#txtDni").val() == '' || $("#txtNumeroDeCarnet").val() == '' || $("#txtCorreo").val() == ''){
					form.submit();
				}else{
					alert("Debe Corregir los datos");
				}*/
			}
		});
		
});//# carnet -> sub 8 -> oficiales 6

$(document).on('click','#btnEditarPerfil', function(e){
	$("#divPerfilMostrar").hide();
	$("#btnEditarPerfil").hide();
	$("#divPerfilEditar").show();
	$("#rangoOficial").prop("checked", false);
	$("#rangoSubOficial").prop("checked", false);
	$("#sexoM").prop("checked", false);
	$("#sexoF").prop("checked", false);
	$("#chkFiscal").prop("checked", true);
	$("#chkFiscalSup").prop("checked", true);
	//
	$("#txtPrimerNombre").val($("#spnPrimerNombe").text());
	$("#txtSegundoNombre").val($("#spnSegundoNombe").text());
	$("#txtApePaterno").val($("#spnApePaterno").text());
	$("#txtApeMaterno").val($("#spnApeMaterno").text());
	$("#txtDni").val($("#spnDni").text());
	
	if('${pageContext.session.getAttribute("entidad")}' == 'D'){
		$("#lblEntidad").text('DIRANDRO');
		
		$("#txtCargo").val($("#spnCargo").text());
		if($("#spnRango").text() == 'Oficial'){
			$("#rangoOficial").prop("checked", true);
			$("#sltcGrado").empty();
			$("#sltcGrado").append('<option>Alfz. PNP</option><option>Tnte. PNP</option><option>Cap. PNP</option>'+
					'<option>May. PNP</option><option>Cmdte PNP</option><option>Crnel PNP</option><option>Gral. PNP</option>');
		}else if($("#spnRango").text() == 'Sub Oficial'){
			$("#rangoSubOficial").prop("checked", true);
			$("#sltcGrado").empty();
			$("#sltcGrado").append('<option>SO3 PNP</option><option>SO2 PNP</option><option>SO1 PNP</option>'+
			'<option>SOT3 PNP</option><option>SOT2 PNP</option><option>SOT1 PNP</option><option>SOB PNP</option><option>SOS PNP</option>');
		}
		
		$("#sltcGrado").val($("#spnGrado").text());
		$("#txtNumeroDeCarnet").val($("#spnNCarnet").text());
		
	}else if('${pageContext.session.getAttribute("entidad")}' == 'M'){
		$("#lblEntidad").text('Ministerio Público');
		
		$("#divCargo").hide();
		$("#divRango").hide();
		$("#divFiscalEdit").show();
		$("#divGrado").hide();
		$("#divNCarnet").hide();
		
		if($("#spnTipoFiscal").text() == 'Fiscal'){
			$("#chkFiscal").prop("checked", true);
		}else if($("#spnTipoFiscal").text() == 'Fiscal Superior'){
			$("#chkFiscalSup").prop("checked", true);
		}
	}

	
	$("#txtTelefono").val($("#spnTelefono").text());
	$("#txtCorreo").val($("#spnCorreo").text());
	
	if($("#spnSexo").text() == 'Masculino'){
		$("#sexoM").prop("checked", true);
	}else if($("#spnSexo").text() == 'Femenino'){
		$("#sexoF").prop("checked", true);
	}
});

$(document).on('click','#rangoOficial', function(e){
	$("#sltcGrado").empty();
	$("#sltcGrado").append('<option>Alfz. PNP</option><option>Tnte. PNP</option><option>Cap. PNP</option>'+
			'<option>May. PNP</option><option>Cmdte PNP</option><option>Crnel PNP</option><option>Gral. PNP</option>');
});

$(document).on('click','#rangoSubOficial', function(e){
	$("#sltcGrado").empty();
	$("#sltcGrado").append('<option>SO3 PNP</option><option>SO2 PNP</option><option>SO1 PNP</option>'+
	'<option>SOT3 PNP</option><option>SOT2 PNP</option><option>SOT1 PNP</option><option>SOB PNP</option><option>SOS PNP</option>');
});

$(document).on('click','#btnCancelEditarUsuario', function(e){
	$("#divPerfilMostrar").show();
	$("#btnEditarPerfil").show();
	$("#divPerfilEditar").hide();
});
</script>
<div id="divMostrarDatos" class="">
<div class="panel panel-default">
	<div class="panel-heading">
		<span>/// Datos Personales:</span>
		<div class="pull-right">
			<div class="btn-group">
				<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarPerfil"><i class="fa fa-edit fa-fw"></i> Editar</button>
			</div>
		</div>
	</div>
	<div class="panel-body" id="divPerfilMostrar">
		<div class="col-lg-6">
			<div class="form-group">
				<label>Nombres: </label>
				<label class="radio-inline"><span id="spnPrimerNombe">&nbsp;</span>&nbsp;<span id="spnSegundoNombe">&nbsp;</span></label>
			</div>
			<div class="form-group">
				<label>Apellidos: </label>
				<label class="radio-inline"><span id="spnApePaterno">&nbsp;</span>&nbsp;<span id="spnApeMaterno">&nbsp;</span></label>
			</div>
			<div class="form-group" id="divCarnet">
				<label>Numero de CIP: </label>
				<label class="radio-inline"><span id="spnNCarnet">&nbsp;</span></label>
			</div>
			<div class="form-group">
				<label>DNI: </label>
				<label class="radio-inline"><span id="spnDni">&nbsp;</span></label>
			</div>
			<div class="form-group">
				<label>Entidad: </label>
				<label class="radio-inline"><span id="spnEntidad">&nbsp;</span></label>
			</div>
			<div class="form-group" id="divRango">
				<label>Jerarquía: </label>
				<label class="radio-inline"><span id="spnRango">&nbsp;</span></label>
			</div>
		</div>
		<div class="col-lg-6">
			<div class="form-group" id="divGrado">
				<label>Grado: </label>
				<label class="radio-inline"><span id="spnGrado">&nbsp;</span></label>
			</div>
			<div class="form-group" id="divCargo">
				<label>Cargo: </label>
				<label class="radio-inline"><span id="spnCargo">&nbsp;</span></label>
			</div>
			<div class="form-group" id="divFiscal" style="display: none;">
				<label>Tipo Fiscal: </label> 
				<label class="radio-inline"><span id="spnTipoFiscal">&nbsp;</span></label>
			</div>
			<div class="form-group">
				<label>Telefono: </label>
				<label class="radio-inline"><span id="spnTelefono">&nbsp;</span></label>
			</div>
			<div class="form-group">
				<label>Corre Electrónico: </label>
				<label class="radio-inline"><span id="spnCorreo">&nbsp;</span></label>
			</div>
			<div class="form-group">
				<label>Sexo: </label>
				<label class="radio-inline"><span id="spnSexo">&nbsp;</span></label>
			</div>
		</div>			
	</div>
	<div class="panel-body" id="divPerfilEditar" style="display: none;">
		<form:form class="form-horizontal" id="formEditarUsuario" action="editarUsuario" commandName="perfil">
			<div class="col-lg-6 col-md-offset-1">
				<div class="form-group">
					<label>Primer Nombre: </label>
					<div class="form-group">
						<input type="text" name="primerNombre" id="txtPrimerNombre" data-rule-required="true" data-msg-required="*" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label>Segundo Nombre: </label>
					<div class="form-group">
						<input type="text" name="segundoNombre" id="txtSegundoNombre" class="form-control">
					</div>
				</div>
				<div class="form-group" id="divCarnet">
					<label>Apellido Paterno: </label>
					<div class="form-group">
						<input type="text" name="apePaterno" id="txtApePaterno" data-rule-required="true" data-msg-required="*" class="form-control"/>
					</div>
				</div>
				<div class="form-group">
					<label>Apellidos Materno: </label>
					<div class="form-group">
						<input type="text" name="apeMaterno" id="txtApeMaterno" data-rule-required="true" data-msg-required="*" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label>DNI: </label>
					<div class="form-group">
						<input type="text" name="txtDni" id="txtDni"  class="form-control">
						<input class="span2" type="hidden" name="dni" id="hdnDni">
					</div>
				</div>
				<div class="form-group" id="divRango">
					<label>Entidad: </label>
					<label class="radio-inline" id="lblEntidad">DIRANDRO</label>
				</div>
				<div class="form-group" id="divCargo">
					<label>Cargo: </label>
					<div class="form-group">
						<select name="cargo" id="txtCargo" data-rule-required="true" data-msg-required="*" class="form-control">
							<option>Jefe de Unidad</option>
							<option>Superior</option>
							<option>Investigador</option>
						</select>
					</div>
				</div>
				<div class="form-group" id="divRango">
					<label>Jerarquía: </label>
					<label class="radio-inline">  
						<input type="radio" name="rango" id="rangoOficial" value="Oficial" checked>Oficial
					</label> 
					<label class="radio-inline">  
						<input type="radio" name="rango" id="rangoSubOficial" value="Sub Oficial">Sub Oficial
					</label>
				</div>
				<div class="form-group" id="divFiscalEdit" style="display: none;">
					<label>Tipo Fiscal: </label> 
					<label class="radio-inline"> 
						<input type="radio" name="tipoFiscal" id="chkFiscal" value="Fiscal" checked>Fiscal
					</label> 
					<label class="radio-inline"> 
						<input type="radio" name="tipoFiscal" id="chkFiscalSup" value="Fiscal Superior">Fiscal Superior
					</label>
				</div>
				<div class="form-group" id="divGrado">
					<label>Grado: </label>
					<div class="form-group">
						<select name="grado" id="sltcGrado" data-rule-required="true" data-msg-required="*" class="form-control">
							<option>Alfz. PNP</option>
							<option>Tnte. PNP</option>
							<option>Cap. PNP</option>
							<option>May. PNP</option>
							<option>Cmdte PNP</option>
							<option>Crnel PNP</option>
							<option>Gral. PNP</option>
						</select>
					</div>
				</div>
				<div class="form-group" id="divNCarnet">
					<label>Numero de Carnet: </label>
					<div class="form-group input-group">
						<span class="input-group-addon">CIP N°</span>
						<input class="form-control" type="text" id="txtNumeroDeCarnet" name="txtNumeroDeCarnet">
					</div>
					<input type="hidden" name="numeroDeCarnet" id="hdnNumeroDeCarnet">
				</div>
				<div class="form-group">
					<label>Telefono: </label>
					<div class="form-group">
						<input type="text" id="txtTelefono" name="telefono" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label>Corre Electrónico: </label>
					<div class="form-group input-group">
						<span class="input-group-addon">@</span>
						<input class="form-control" type="text" id="txtCorreo" name="txtCorreo"> 
					</div>
					<input class="form-control" type="hidden" id="hdnCorreo" name="correo">
				</div>
				<div class="form-group">
					<label>Sexo: </label> 
					<label class="radio-inline"> 
						<input type="radio" name="sexo" id="sexoM" value="M" checked>Masculino
					</label> 
					<label class="radio-inline"> 
						<input type="radio" name="sexo" id="sexoF" value="F">Femenino
					</label>
				</div>
				<hr>
				<div class="well">
					<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar Usuario </button>
					<button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
					<button class="btn btn-outline btn-warning" type="button" id="btnCancelEditarUsuario"><i class="fa fa-arrow-left"></i> Cancel</button>
				</div>
			</div>
		</form:form>			
	</div>
</div>
	
	
	
</div>
