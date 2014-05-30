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
function initAsignaCasos(casos){
	indiceCaso = 0;
	totalCasos = casos.length;
		$("#tblBody").empty();
		$.each(casos, function(i, caso) {
			$("#tblBody").append('<tr>');
				$("#tblBody").append('<td>'+caso.codigo+' ('+caso.referencia+')'+'<input type="hidden" name="idCaso" id="hdnCaso_'+indiceCaso+'" value="'+caso.idCasoCriminal+'"></td>');
				$("#tblBody").append('<td id="jefeDeUnidad_'+indiceCaso+'"><span id="spnJefeDeUnidad_'+indiceCaso+'">'+caso.nombreCompleto+'</span></td>'+
						'<td style="display:none;" id="jefeDeUnidadCombo_'+indiceCaso+'"><select name="jefeDeUnidad" id="slctJefe_'+indiceCaso+'"></select></td>');
				$("#tblBody").append('<td id="btnAsignar_'+indiceCaso+'">'+
						'<button class="btn btn-primary asignar" id="asignar_'+indiceCaso+'"><i class="icon-edit icon-white"></i> Asignar</button>'+
						'</td>'+
						'<td style="display:none;" id="btnAccion_'+indiceCaso+'">'+
						'<button class="btn btn-success asignar" id="GuardarAsigna_'+indiceCaso+'"><i class="icon-ok icon-white"></i> Guardar</button>'+
						'<button class="btn btn-danger asignar" id="CancelarAsigna_'+indiceCaso+'"><i class="icon-remove icon-white"></i> Cancelar</button>'+
						'</td>');
			$("#tblBody").append('</tr>');
			indiceCaso++;
		});
}
$(document).ready(function(){
	
	var llenarCombo = "";
	$.ajax({
 		url: 'getJefesDeUnidad',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(jefes){
 			$.each(jefes, function(i, jefe) {
 				llenarCombo = llenarCombo + '<option value="'+jefe.idUsuario+'">'+jefe.nombreCompleto+'</option>';
 			});
 		}
 	});
	
	$.ajax({
 		url: 'getCasos',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(casos){
 			initAsignaCasos(casos);
 		}
 	});
 	
	$(document).on('click','.asignar', function(e){
		var id = this.id;
		var idA = id.split("_")[0];
		var idN = id.split("_")[1];
		
		switch(idA){
			case 'asignar':
				$("#jefeDeUnidad_"+idN).hide();
				$("#jefeDeUnidadCombo_"+idN).show();
				$("#slctJefe_"+idN).empty();
				$("#slctJefe_"+idN).append(llenarCombo);
				
				$("#btnAsignar_"+idN).hide();
				$("#btnAccion_"+idN).show();
			break;
			case 'CancelarAsigna':
				$("#jefeDeUnidad_"+idN).show();
				$("#jefeDeUnidadCombo_"+idN).hide();
				
				$("#btnAsignar_"+idN).show();
				$("#btnAccion_"+idN).hide();
			break;
			case 'GuardarAsigna':
				$.ajax({
			 		url: 'asignarCaso-'+$("#hdnCaso_"+idN).val()+"-"+$("#slctJefe_"+idN).val(),
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(casos){
			 			initAsignaCasos(casos);
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
						<th>Jefe De Unidad</th>
						<th>Asignar</th>
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