<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Buscar Caso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- tabs -->
<script src="js/bootstrap-tab.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<script>
var totalCasos = 0;
var indiceCaso = 0;
var llenarCombo = "";
var indicePol = 0;
function initAsignaCasos(casos){
	indiceCaso = 0;
	totalCasos = casos.length;
		$("#tblBody").empty();
		$.each(casos, function(i, caso) {
			$("#tblBody").append('<tr>');
				$("#tblBody").append('<td>'+caso.codigo+' ('+caso.referencia+')'+'<input type="hidden" name="idCaso" id="hdnCaso_'+indiceCaso+'" value="'+caso.idCasoCriminal+'"></td>');
				$("#tblBody").append('<td id="jefeDeUnidadCombo_'+indiceCaso+'"><select name="jefeDeUnidad" id="slctPol_'+indiceCaso+'"></select> <button class="btn btn-success btn-mini asignar" id="GuardarAsigna_'+indiceCaso+'" type="button"><i class="icon-plus icon-white"></i></button>'+
											'<div id="divAsignadorAgregar_'+indiceCaso+'">'+
								          	'</div></td>');
			$("#tblBody").append('</tr>');

			$("#slctPol_"+indiceCaso).empty();
			$("#slctPol_"+indiceCaso).append(llenarCombo);
			
			indiceCaso++;
		});
}

function traerCasos(){
	$.ajax({
 		url: 'getCasosPersonal',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(casos){
 			initAsignaCasos(casos);
	 		$.each(casos, function(i, caso) {
	 			$.ajax({
	 		 		url: 'getPersonalPolicialPorCaso-'+caso.idCasoCriminal,
	 		 		type: 'post',
	 		 		dataType: 'json',
	 		 		data: '',
	 		 		success: function(policias){
	 		 			$.each(policias, function(j, policia) {
	 		 				$("#divAsignadorAgregar_"+i).append(
									'<div class="control-group" id="divPolName_'+indicePol+'">'+
										'<div class="controls" >'+policia.nombreCompleto+
										' <button class="btn btn-danger btn-mini asignar" id="CancelarAsigna_'+i+'_'+indicePol+'" type="button"><i class="icon-minus icon-white"></i></button>'+
											'<input type="hidden" id="hdnIsUsuario_'+i+'_'+indicePol+'" name="" value="'+policia.idUsuario+'">'+
					          			'</div>'+
					          		'</div>');
					 			indicePol++;
	 		 			});
	 		 		}
	 		 	});
	 		});
 		}
 	});
}

$(document).ready(function(){	
	
	$.ajax({
 		url: 'getPersonalPolicial',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(jefes){
 				llenarCombo = llenarCombo + '<option value="">No precisa</option>';
 			$.each(jefes, function(i, jefe) {
 				llenarCombo = llenarCombo + '<option value="'+jefe.idUsuario+'">'+jefe.nombreCompleto+'</option>';
 			});
 			traerCasos();
 		}
 	});	
 	
	$(document).on('click','.asignar', function(e){
		var id = this.id;
		var idA = id.split("_")[0];
		var idN = id.split("_")[1];
		var idN2 = id.split("_")[2];
		
		switch(idA){
			case 'CancelarAsigna':
				var respuesta = confirm('¿Esta seguro que desea quitar a este agente?');
				if(respuesta){
					$.ajax({
				 		url: 'reAsignarPersonalPolicial-'+$("#hdnCaso_"+idN).val()+"-"+$("#hdnIsUsuario_"+idN+"_"+idN2).val(),
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(casos){
				 			$("#divPolName_"+idN2).remove();
				 		}
				 	});
				}				
			break;
			case 'GuardarAsigna':
				$.ajax({
			 		url: 'asignarPersonalPolicial-'+$("#hdnCaso_"+idN).val()+"-"+$("#slctPol_"+idN).val(),
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(caso){
			 			//initAsignaCasos(casos);
			 			if(caso){
			 				$("#divAsignadorAgregar_"+idN).append(
									'<div class="control-group" id="divPolName_'+indicePol+'">'+
										'<div class="controls" >'+$("#slctPol_"+idN+" option:selected").html()+
										' <button class="btn btn-danger btn-mini asignar" id="CancelarAsigna_'+idN+'_'+indicePol+'" type="button"><i class="icon-minus icon-white"></i></button>'+
											'<input type="hidden" id="hdnIsUsuario_'+idN+'_'+indicePol+'" name="" value="'+$("#slctPol_"+idN).val()+'">'+
					          			'</div>'+
					          		'</div>');
					 			$("#slctPol_"+idN).val("");
					 			indicePol++;
					 		alert("Asignado Correctamente.");
			 			}else{
			 				alert($("#slctPol_"+idN+" option:selected").html()+" ya esta asignado(a) al caso.");
			 			}			 			
			 		}
			 	});		
			break;
		}
	});
	
});
</script>
</head>
<body>

	<!--HEADER-->
	<jsp:include page="../componentes/header.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<!--MENU-->
	<jsp:include page="../componentes/menu.jsp" />
	<!--/MENU-->
	<div class="container inner_content">
		<section class="span9" style="margin-left: 80px;">
			<table class="table table-bordered" id="tblCasos">
				<thead>
					<tr>
						<th>Caso Criminal</th>
						<th>Asignar Personal Policial</th>
					</tr>
				</thead>
				<tbody id="tblBody">
				</tbody>
				
			</table>
		</section>
	</div>
	<!--/CENTRO-->
	<!-- sticky footer -->
	<jsp:include page="../componentes/footer.jsp" />
	<!-- /sticky footer -->
</body>
</html>