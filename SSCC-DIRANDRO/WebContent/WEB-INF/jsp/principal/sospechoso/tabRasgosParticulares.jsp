<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script type="text/javascript">
function initRasgosParticulares(rasgosParticulares){
	//TAB RASGOS PARTICULARES
	$("#spnTatuajes").empty();
	$("#spnLunares").empty();
	$("#spnCicatrices").empty();
	$("#spnDeficiencias").empty();
	$("#spnOtros").empty();
	
	$("#spntextoTatuajes").empty();
	$("#spntextoLunares").empty();
	$("#spntextoCicatrices").empty();
	$("#spntextoDeficiencias").empty();
	$("#spntextoOtros").empty();
	
	
	$("#spnTatuajes").append(rasgosParticulares.tatuaje);
	$("#spnLunares").append(rasgosParticulares.lunares);
	$("#spnCicatrices").append(rasgosParticulares.cicatrices);
	$("#spnDeficiencias").append(rasgosParticulares.deficiencias);
	$("#spnOtros").append(rasgosParticulares.otros);
	
	$("#spntextoTatuajes").append(rasgosParticulares.textoTatuaje);
	$("#spntextoLunares").append(rasgosParticulares.textoLunares);
	$("#spntextoCicatrices").append(rasgosParticulares.textoCicatrices);
	$("#spntextoDeficiencias").append(rasgosParticulares.textoDeficiencias);
	$("#spntextoOtros").append(rasgosParticulares.textoOtros);
}
	$(document).ready(function(){
		var idSospechoso = $("#hdnIdSospechoso").text();
		$.ajax({
	 		url: 'getRasgosParticulares-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(rasgos){
	 			initRasgosParticulares(rasgos);
	 		}
	 	});
		//VALIDACIONES
		$("#formEditarRasgos").validate({
			rules:
			{
				txtTatuajes:{maxlength: 1500},
				txtLunares:{maxlength: 1500},
				txtCicatrices:{maxlength: 1500},
				txtDeficiencias:{maxlength: 1500},
				txtOtros:{maxlength: 1500}
			},
			messages:
			{
				txtTatuajes:"Supero el límite (1500).",
				txtLunares:"Supero el límite (1500).",
				txtCicatrices:"Supero el límite (1500).",
				txtDeficiencias:"Supero el límite (1500).",
				txtOtros:"Supero el límite (1500)."
			},
			submitHandler: function(form){
				$("#hdnIdSospechosoRasgos").val($("#hdnIdSospechoso").text());
				$.ajax({
					url: 'editarRasgos',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarRasgos").serialize(),
			 		success: function(rasgosParticulares){
			 			initRasgosParticulares(rasgosParticulares);
			 			$("#divMostrarRasgos").show();
			 			$("#divEditarRasgos").hide();
			 		}
				});
			}
		});
	});
	$(document).on('click','#btnEditarRasgos', function(e){
		$("#txtTatuajes").hide();
		$("#txtLunares").hide();
		$("#txtCicatrices").hide();
		$("#txtDeficiencias").hide();
		$("#txtOtros").hide();
		//COMPONENTES DEL EDITAR
		if($("#spnTatuajes").text() =='SI'){
			$("#radioTSi").prop("checked",true);
			$("#txtTatuajes").show();
			$("#txtTatuajes").val($("#spntextoTatuajes").text());
		}else if($("#spnTatuajes").text() =='NO'){
			$("#radioTNo").prop("checked",true);
		}
		
		if($("#spnLunares").text() =='SI'){
			$("#radioLSi").prop("checked",true);
			$("#txtLunares").show();
			$("#txtLunares").val($("#spntextoLunares").text());
		}else if($("#spnLunares").text() =='NO'){
			$("#radioLNo").prop("checked",true);
		}
		
		if($("#spnCicatrices").text() =='SI'){
			$("#radioCSi").prop("checked",true);
			$("#txtCicatrices").show();
			$("#txtCicatrices").val($("#spntextoCicatrices").text());
		}else if($("#spnCicatrices").text()=='NO'){
			$("#radioCNo").prop("checked",true);
		}
		
		if($("#spnDeficiencias").text() =='SI'){
			$("#radioDSi").prop("checked",true);
			$("#txtDeficiencias").show();
			$("#txtDeficiencias").val($("#spntextoDeficiencias").text());
		}else if($("#spnDeficiencias").text()=='NO'){
			$("#radioDNo").prop("checked",true);
		}
		
		if($("#spnOtros").text() =='SI'){
			$("#radioOSi").prop("checked",true);
			$("#txtOtros").show();
			$("#txtOtros").val($("#spntextoOtros").text());
		}else if($("#spnOtros").text()=='NO'){
			$("#radioONo").prop("checked",true);
		}
		
		//TABS A OCULTAR Y MOSTRAR
		$("#divMostrarRasgos").hide();
		$("#divEditarRasgos").show();
	});
	//Limpieza de los textArea al dar NO
	$(document).on('click','#radioTNo', function(e){
		$("#txtTatuajes").val("");
	});
	$(document).on('click','#radioLNo', function(e){
		$("#txtLunares").val("");
	});
	$(document).on('click','#radioCNo', function(e){
		$("#txtCicatrices").val("");
	});
	$(document).on('click','#radioDNo', function(e){
		$("#txtDeficiencias").val("");
	});
	$(document).on('click','#radioONo', function(e){
		$("#txtOtros").val("");
	});
	$(document).on('click','#btnCancelEditar', function(e){
		//TABS A MOSTRAR Y OCULTAR
		$("#divMostrarRasgos").show();
		$("#divEditarRasgos").hide();
	});
	//RADIO BUTTONS PARA LA APARICION DE LOS TEXT AREA
	$(document).on('click','#radioTSi', function(e){
		$("#txtTatuajes").show();
		//$("#lblTatuajes").css("margin-top","87px");
	});
	$(document).on('click','#radioTNo', function(e){
		$("#txtTatuajes").hide();
		$("#txtTatuajes").val("");
		//$("#lblTatuajes").css("margin-top","0px");
	});
	
	$(document).on('click','#radioLSi', function(e){
		$("#txtLunares").show();
		//$("#lblLunares").css("margin-top","87px");
	});
	$(document).on('click','#radioLNo', function(e){
		$("#txtLunares").hide();
		//$("#lblLunares").css("margin-top","0px");
	});
	
	$(document).on('click','#radioCSi', function(e){
		$("#txtCicatrices").show();
		//$("#lblCicatrices").css("margin-top","87px");
	});
	$(document).on('click','#radioCNo', function(e){
		$("#txtCicatrices").hide();
		//$("#lblCicatrices").css("margin-top","0px");
	});
	
	$(document).on('click','#radioDSi', function(e){
		$("#txtDeficiencias").show();
		//$("#lblDeficiencias").css("margin-top","87px");
	});
	$(document).on('click','#radioDNo', function(e){
		$("#txtDeficiencias").hide();
		//$("#lblDeficiencias").css("margin-top","0px");
	});
	
	$(document).on('click','#radioOSi', function(e){
		$("#txtOtros").show();
		//$("#lblOtros").css("margin-top","87px");
	});
	$(document).on('click','#radioONo', function(e){
		$("#txtOtros").hide();
		//$("#lblOtros").css("margin-top","0px");
	});
</script>
<body>
<!-- MOSTRAR RASGOS PARTICULARES -->
	<div id="divMostrarRasgosParticulares">
		<div id="divMostrarRasgos">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span>/// Rasgos Particulares del Sospechoso:</span>
					<div class="pull-right">
						<div class="btn-group">
							<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarRasgos"><i class="fa fa-edit fa-fw"></i> Editar</button>
						</div>
					</div>
				</div>
				<div class="panel-body" id="divPerfilMostrar">
					<div class="form-group">
		          		<label>Tatuajes: </label>
		          		<span id="spnTatuajes">&nbsp;</span>
		          		<br/>
		          		<span id="spntextoTatuajes"></span>
		       		</div>
		       		<hr/>
		       		<div class="form-group">
		          		<label>Lunares: </label>
		          		<span id="spnLunares">&nbsp;</span>
		          		<br/>
		          		<span id="spntextoLunares"></span>
		       		</div>
		       		<hr/>
		       		<div class="form-group">
		          		<label>Cicatrices: </label>
		          		<span id="spnCicatrices">&nbsp;</span>
		          		<br/>
		          		<span id="spntextoCicatrices"></span>
		       		</div>
		       		<hr/>
		       		<div class="form-group">
		          		<label>Deficiencias: </label>
		          		<span id="spnDeficiencias">&nbsp;</span>
		          		<br/>
		          		<span id="spntextoDeficiencias"></span>
		       		</div>
		       		<hr/>
		       		<div class="form-group">
		          		<label>Otros: </label>
		          		<span id="spnOtros">&nbsp;</span>
		          		<br/>
		          		<span id="spntextoOtros"></span>
		       		</div>
				</div>
			</div>
		</div>
		
		<!-- EDITAR RASGOS PARTICULARES -->
		<div style="display: none;" id="divEditarRasgos">
			<div class="panel panel-default">
				<div class="panel-heading">
					/// Editar Rasgos Particulares del Sospechoso:
				</div>
				<div class="panel-body" id="divPerfilMostrar">
					<form:form class="form-horizontal" id="formEditarRasgos" action="editarRasgos" commandName="rasgosParticulares">
					<input type="hidden" name="idSospechosoAux" id="hdnIdSospechosoRasgos">
						<div class="form-group">
							<label id="lblTatuajes">Tatuajes: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="tatuaje" id="radioTSi" value="SI">SÍ
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="tatuaje" id="radioTNo" value="NO" checked>NO
							</label>
							<label class="radio-inline">
								<textarea class="form-control" name="textoTatuaje" id="txtTatuajes"></textarea>
							</label>
						</div>
						<hr/>
						<div class="form-group">
							<label id="lblLunares">Lunares: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="lunares" id="radioLSi" value="SI">SÍ
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="lunares" id="radioLNo" value="NO" checked>NO
							</label>
							<label class="radio-inline"> 
								<textarea class="form-control" name="textoLunares" id="txtLunares"></textarea>
							</label>
						</div>
						<hr/>
						<div class="form-group">
							<label id="lblCicatrices">Cicatrices: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="cicatrices" id="radioCSi" value="SI">SÍ
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="cicatrices" id="radioCNo" value="NO" checked>NO
							</label>
							<label class="radio-inline">
								<textarea class="form-control" name="textoCicatrices" id="txtCicatrices"></textarea>
							</label>
						</div>
						<hr/>
						<div class="form-group">
							<label id="lblDeficiencias">Deficiencias: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="deficiencias" id="radioDSi" value="SI">SÍ
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="deficiencias" id="radioDNo" value="NO" checked>NO
							</label>
							<label class="radio-inline">
								<textarea class="form-control" name="textoDeficiencias" id="txtDeficiencias"></textarea>
							</label>
						</div>
						<hr/>
						<div class="form-group">
							<label id="lblOtros">Otros: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="otros" id="radioOSi" value="SI">SÍ
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="otros" id="radioONo" value="NO" checked>NO
							</label>
							<label class="radio-inline">
								<textarea class="form-control" name="textoOtros" id="txtOtros"></textarea>
							</label>
						</div>
						<!-- BOTONES -->
						<div class="well">
							<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar</button>
					        <button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
					        <button class="btn btn-outline btn-warning" type="button" id="btnCancelEditar"><i class="fa fa-arrow-left"></i> Cancel</button>
					    </div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>