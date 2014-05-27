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
function init(rasgosParticulares){
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
				$.ajax({
					url: 'editarRasgos',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarRasgos").serialize(),
			 		success: function(rasgosParticulares){
			 			init(rasgosParticulares);
			 			$("#divMostrarRasgos").show();
			 			$("#divEditarRasgos").hide();
			 			}
				});
			}
		});
	});
	$(document).on('click','#btnEditarRasgos', function(e){
		//COMPONENTES DEL EDITAR
		if($("#spnTatuajes").text=='SÍ'){
			$("#radioTSi").prop("checked",true);
			$("#txtTatuajes").val($("#spnTatuajes").text());
		}else if($("#spnTatuajes").text=='NO'){
			$("#radioTNo").prop("checked",true);
			$("#txtTatuajes").val($("#spnTatuajes").text());
		}
		
		if($("#spnLunares").text=='SÍ'){
			$("#radioLSi").prop("checked",true);
			$("#txtLunares").val($("#spnLunares").text());
		}else if($("#spnLunares").text=='NO'){
			$("#radioLNo").prop("checked",true);
			$("#txtLunares").val($("#spnLunares").text());
		}
		
		if($("#spnCicatrices").text=='SÍ'){
			$("#radioCSi").prop("checked",true);
			$("#txtCicatrices").val($("#spnCicatrices").text());
		}else if($("#spnCicatrices").text=='NO'){
			$("#radioCNo").prop("checked",true);
			$("#txtCicatrices").val($("#spnCicatrices").text());
		}
		
		if($("#spnDeficiencias").text=='SÍ'){
			$("#radioDSi").prop("checked",true);
			$("#txtDeficiencias").val($("#spnDeficiencias").text());
		}else if($("#spnDeficiencias").text=='NO'){
			$("#radioDNo").prop("checked",true);
			$("#txtDeficiencias").val($("#spnDeficiencias").text());
		}
		
		if($("#spnOtros").text=='SÍ'){
			$("#radioOSi").prop("checked",true);
			$("#txtOtros").val($("#spnOtros").text());
		}else if($("#spnOtros").text=='NO'){
			$("#radioONo").prop("checked",true);
			$("#txtOtros").val($("#spnOtros").text());
		}
		//TABS A OCULTAR Y MOSTRAR
		$("#divMostrarRasgos").hide();
		$("#divEditarRasgos").show();
	});
	$(document).on('click','#btnCancelEditar', function(e){
		//TABS A MOSTRAR Y OCULTAR
		$("#divMostrarRasgos").show();
		$("#divEditarRasgos").hide();
	});
	
</script>
<body>
<!-- MOSTRAR RASGOS PARTICULARES -->
	<div id="divMostrarRasgosParticulares">
		<div id="divMostrarRasgos">
			<form:form class="form-horizontal">
				<legend>
		       		<span class=""><span class="colored">///</span> Rasgos Particulares del Sospechoso:</span>
		       		<span class="offset3"><button class="btn btn-primary" type="button" id="btnEditarRasgos"><i class="icon-edit"></i> Editar</button></span>
	       		</legend>
	       		<div class="control-group">
	          		<label class="control-label">Tatuajes: </label>
	          		<div class="controls">
	          			<span id="spnTatuajes">&nbsp;</span>
	          			<span id="spntextoTatuajes"></span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Lunares: </label>
	          		<div class="controls">
	          			<span id="spnLunares">&nbsp;</span>
	          			<span id="spntextoLunares"></span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Cicatrices: </label>
	          		<div class="controls">
	          			<span id="spnCicatrices">&nbsp;</span>
	          			<span id="spntextoCicatrices"></span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Deficiencias: </label>
	          		<div class="controls">
	          			<span id="spnDeficiencias">&nbsp;</span>
	          			<span id="spntextoDefiniciones"></span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Otros: </label>
	          		<div class="controls">
	          			<span id="spnOtros">&nbsp;</span>
	          			<span id="spntextoOtros"></span>
	          		</div>
	       		</div>
			</form:form>
		</div>
		<!-- EDITAR RASGOS PARTICULARES -->
		<fieldset class="well" style="display: none;" id="divEditarRasgos">
			<form:form class="form-horizontal" id="formEditarRasgos" action="editarRasgos" commandName="rasgosParticulares">
				<legend>
			       	<span class="colored">///</span> Editar Rasgos Particualres del Sospechoso:
		       	</legend>
		       	<div class="control-group">
					<label class="control-label">Tatuajes: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadTatuaje" id="radioTSi" value="SI">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadTatuaje" id="radioTNo" value="NO">NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" id="txtTatuajes"></textarea>
					</label>
				</div>
				<div class="control-group">
					<label class="control-label">Lunares: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadLunares" id="radioLSi" value="s">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadLunares" id="radioLNo" value="n">NO
					</label>
					<label class="checkbox inline"> 
						<textarea rows="10" cols="40" id="txtLunares"></textarea>
					</label>
				</div>
				<div class="control-group">
					<label class="control-label">Cicatrices: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadCicatrices" id="radioCSi" value="s">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadCicatrices" id="radioCNo" value="n">NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" id="txtCicatrices"></textarea>
					</label>
				</div>
				<div class="control-group">
					<label class="control-label">Deficiencias: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadDeficiencias" id="radioDSi" value="s">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadDeficiencias" id="radioNo" value="n">NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" id="txtDeficiencias"></textarea>
					</label>
				</div>
				<div class="control-group">
					<label class="control-label">Otros: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadOtros" id="radioSi" value="s">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="entidadOtros" id="radioNo" value="n">NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" id="txtOtros"></textarea>
					</label>
				</div>
				<!-- BOTONES -->
				<div class="form-actions">
					<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar</button>
			        <button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
			        <button class="btn btn-warning" type="button" id="btnCancelEditar"><i class="icon-arrow-left icon-white"></i> Cancel</button>
			    </div>
			</form:form>
		</fieldset>
	</div>
</body>
</html>