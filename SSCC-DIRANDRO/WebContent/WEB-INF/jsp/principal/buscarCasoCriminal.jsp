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

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
<script src="js/sb-admin-2.js"></script>

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/dataTables.bootstrap.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<script>

$(document).ready(function(e){
	
	$.ajax({
  		url: 'getCasosCriminales',
  		type: 'post',
  		dataType: 'json',
  		data: '',
  		success: function(casos){
  			// var a = '';
			 var resultado = '';
			 
	  			$.each(casos, function(i, caso){
	  				resultado += '<tr>'+
				                    '<td><a href="toCasoCriminal-'+caso.idCasoCriminal+'">'+caso.codigo+'</a></td>'+
				                    '<td>'+caso.asunto+'</td>'+
				                    '<td>'+caso.referencia+'</td>'+
				                    '<td>'+caso.descripcion+'</td>'+
				                    '<td>'+caso.importancia+'</td>'+
				                    '<td>'+caso.estado+'</td>'+
				                    '<td>'+caso.fecCreacion+'</td>'+
				                '</tr>';		            	
	  			});
	  		$("#dataTablesPersonal").append(resultado);
	  		$('#dataTablesPersonal').dataTable();
  		}
  	});  	
	
	
});

</script>
</head>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
	    	<div class="col-lg-12" id="titulo">
	        	<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
	       	</div>
	       	<div class="table-responsive">
	       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
	       			<table class="table table-striped table-bordered table-hover dataTable" id="dataTablesPersonal">
		  					<thead>
			  					<tr>
			  						<th>Código</th>
			  						<th>Asunto</th>
			  						<th>Referencia</th>
			  						<th>Descripción</th>
			  						<th>Importancia</th>
			  						<th>Estado</th>
			  						<th>Fecha de Creación</th>
			  					</tr>
		  					</thead>
	  					<!-- <tbody id="tbodyResultado">
	  					</tbody> -->
	           		</table>
	       		</div>
	       	</div>
	    </div>
	</div>
	<!--/CENTRO-->
</div>
</body>
</html>