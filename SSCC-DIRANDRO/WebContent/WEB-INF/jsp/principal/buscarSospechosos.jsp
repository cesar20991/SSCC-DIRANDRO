<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SSCC - DIRANDRO - Buscar Sospechosos</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">


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
  		url: 'getSospechososBuscar',
  		type: 'post',
  		dataType: 'json',
  		data: '',
  		success: function(sospechosos){
  			// var a = '';
			 var resultado = '';
			 
	  			$.each(sospechosos, function(i, sospechoso){
	  				resultado += '<tr>'+
					  				'<td><img src="'+sospechoso.urlSospechoso+'" style="width: 100%; height: 100%;"/></td>'+
					                '<td><a href="toSospechosoPrincipal-'+sospechoso.idSospechoso+'">'+sospechoso.nombreCompleto+'</a></td>'+
					                '<td>'+sospechoso.codigoUnicoDeIdentificacion+'</td>'+
					                '<td>'+sospechoso.alias+'</td>'+
					                '<td>'+sospechoso.codigo+'</td>'+
					                '<td>'+sospechoso.sexo+'</td>'+
					                '<td>'+sospechoso.fechaDeNacimiento+'</td>'+
					                '<td>'+sospechoso.departamentoDeNacimiento+'</td>'+
					                '<td>'+sospechoso.provinciaDeNacimiento+'</td>'+
					                '<td>'+sospechoso.distritoDeNacimiento+'</td>'+
					                '<td>'+sospechoso.gradoDeInstruccion+'</td>'+
					                '<td>'+sospechoso.estadoCivil+'</td>'+					                
					                '<td>'+sospechoso.estatura+'</td>'+
					                '<td>'+sospechoso.nombrePadre+'</td>'+
					                '<td>'+sospechoso.nombreMadre+'</td>'+					                
					                '<td>'+sospechoso.departamentoDeDomicilio+', '+sospechoso.provinciaDeDomicilio+', '+sospechoso.distritoDeDomicilio+', '+sospechoso.domicilio+'</td>'+				                
					                '<td>'+sospechoso.celulares+'</td>'+
					                '<td>'+sospechoso.correos+'</td>'+
					                '<td>'+sospechoso.direcciones+'</td>'+
					                '<td>'+sospechoso.telefonos+'</td>'+
					                '<td>'+sospechoso.tatuaje+'</td>'+
					                '<td>'+sospechoso.lunares+'</td>'+
					                '<td>'+sospechoso.cicatrices+'</td>'+
					                '<td>'+sospechoso.deficiencias+'</td>'+
					                '<td>'+sospechoso.otros+'</td>'+
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
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
	    	<div class="col-lg-12" id="titulo">
	        	<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
	       	</div>
	       	<div id="divScroll" style="overflow-x: scroll; width: 98%;">
	       		<div class="table-responsive">
		       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
		       			<table class="table table-striped table-bordered table-hover dataTable" id="dataTablesPersonal">
			  					<thead>
				  					<tr>
				  						<th>foto</th>
				  						<th>Nombre</th>
				  						<th>DNI</th>
				  						<th>Alias</th>
				  						<th>Código</th>
				  						<th>Sexo</th>
				  						<th>Fecha de Nacimiento</th>
				  						<th>Departamente de Nacimiento</th>
				  						<th>Provincia de Nacimiento</th>
				  						<th>Distrito de Nacimiento</th>
				  						<th>Grado de Instrucción</th>
				  						<th>Estado Civil</th>
				  						<th>Estatura</th>
				  						<th>Nombre de Padre</th>
				  						<th>Nombre de Madre</th>
				  						<th>domicilio</th>
				  						<th>celulares</th>
						                <th>correos</th>
						                <th>direcciones</th>
						                <th>telefonos</th>
						                <th>tatuaje</th>
						                <th>lunares</th>
						                <th>cicatrices</th>
						                <th>deficiencias</th>
						                <th>otros</th>
				  					</tr>
			  					</thead>
		  					<!-- <tbody id="tbodyResultado">
		  					</tbody> -->
		           		</table>
		       		</div>
		       	</div>
	       	</div>	       	
	     </div>
	        <!-- /.row -->
	</div>
</div>
	
</body>
</html>