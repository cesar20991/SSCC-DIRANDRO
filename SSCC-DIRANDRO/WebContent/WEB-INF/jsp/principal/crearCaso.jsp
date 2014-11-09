<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Crear Caso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>

<script>
$(document).ready(function() {
	
	$("#formCrearCaso").validate({
		submitHandler: function(form){			
			form.submit();
		}
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp"/>
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>
			<div class="panel panel-default col-md-6 col-md-offset-1">
				<div class="panel-heading">
					/// Caso Criminal:
				</div>
				<div class="panel-body">
					<form:form class="form-horizontal" id="formCrearCaso" action="crearCaso" commandName="caso">
						<div class="form-group">
			          		<label>Asunto: </label>
			          		<input class="form-control" type="text" name="asunto" id="txtAsunto" data-rule-required="true" data-msg-required="*">
			       		</div>
			       		<div class="form-group">
			          		<label title="Nombre Clave">Referencia: </label>
			          		<input class="form-control" type="text" name="referencia" id="txtReferencia" data-rule-required="true" data-msg-required="*">
			       		</div>
			       		<div class="form-group">
			          		<label>Descripción: </label>
			          		<textarea class="form-control" name="descripcion" id="txtDescription" rows="5" data-rule-required="true" data-msg-required="*"></textarea>
			       		</div>
			       		<div class="form-group">
			          		<label>Prioridad: </label>
		          			<select class="form-control" name="importancia">
		          				<option value="">No Precisa</option>
		          				<option>Alta</option>
		          				<option>Media</option>
		          				<option>Baja</option>
				            </select>
			       		</div>
			       		<hr>
						<div class="well">
							<button class="btn btn-outline btn-success" id="btnCrear" type="submit"><i class="fa fa-check"></i> Crear Caso Criminal</button>
			        		<button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>