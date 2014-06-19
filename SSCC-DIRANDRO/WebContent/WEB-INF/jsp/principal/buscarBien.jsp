<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Buscar Bien</title>
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
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<script>
var totalBienes = 0;
var indiceBien = 0;
function initAsignaBienes(bienes){
	indiceBien = 0;
	totalBienes = bienes.length;
		$("#tblBody").empty();
		$.each(bienes, function(i, bien) {
			$("#tblBody").append('<tr>');
				$("#tblBody").append('<td>'+bien.codigo+'<input type="hidden" name="idBien" id="hdnBien_'+indiceBien+'" value="'+bien.idBien+'"></td>');
				$("#tblBody").append('<td><span id="spnPartidaRegistral_'+indiceBien+'">'+bien.partidaRegistral+'</span></td>'+
						'<td><span id="spnValor_'+indiceBien+'">'+bien.valor+'</span></td>');
				$("#tblBody").append('<td id="btnAsignar_'+indiceBien+'">'+
						'<button class="btn btn-primary asignar" id="asignar_'+indiceBien+'"><i class="icon-edit icon-white"></i> Asignar</button>'+
						'</td>'+
						'<td style="display:none;" id="btnAccion_'+indiceBien+'">'+
						'<button class="btn btn-success asignar" id="GuardarAsigna_'+indiceBien+'"><i class="icon-ok icon-white"></i> Guardar</button>'+
						'<button class="btn btn-danger asignar" id="CancelarAsigna_'+indiceBien+'"><i class="icon-remove icon-white"></i> Cancelar</button>'+
						'</td>');
			$("#tblBody").append('</tr>');
			indiceBien++;
		});
}

function getBienesInit(){
	$.ajax({
 		url: 'getBienes',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(bienes){
 			initAsignaBienes(bienes);
 		}
 	});	
}

$(document).ready(function(){
	getBienesInit();

	$(document).on('click','.asignar', function(e){
		var id = this.id;
		var idA = id.split("_")[0];
		var idN = id.split("_")[1];
		
		switch(idA){
			case 'asignar':
				$("#btnAsignar_"+idN).hide();
				$("#btnAccion_"+idN).show();
			break;
			case 'CancelarAsigna':				
				$("#btnAsignar_"+idN).show();
				$("#btnAccion_"+idN).hide();
			break;
			case 'GuardarAsigna':
				var idSospechoso = $("#hdnIdSospechoso").text();
					$.ajax({
				 		url: 'asignarBienToSospechoso-'+$("#hdnBien_"+idN).val()+"-"+idSospechoso,
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(resultado){
				 			if(resultado){
				 				alert("Bien asignado");
				 				getBienesInit();
				 			}else{
				 				alert("no se pudo asignar");
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

	<div class="container inner_content">
		<section class="span9" style="margin-left: 80px;">
		<div id="alertasAsignarCaso" style="display: none;">
		</div>
			<table class="table table-bordered" id="tblBienes">
				<thead>
					<tr>
						<th>Codigo</th>
						<th>Nro. Partida Registral</th>
						<th>Valor Monetario(S/.)</th>
						<th>Estado</th>
					</tr>
				</thead>
				<tbody id="tblBody">
				</tbody>
				
			</table>
		</section>
	</div>
</body>
</html>