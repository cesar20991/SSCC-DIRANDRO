<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Investigado</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/dataTables.bootstrap.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/bootstrap-datepicker.es.js"></script>
<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>

</head>
<script type="text/javascript">
var tipoEntidad = "sospechoso";
var idEntidad = '';
</script>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
		<c:forEach items="${sospechosoList}" var="sospechoso">
			<span id="hdnIdSospechoso" style="display: none;"><c:out value="${sospechoso.idSospechoso}" /></span>
		</c:forEach>
		<div class="col-lg-12" id="titulo">
			<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
		</div>
		<div class="col-lg-12">
			<table class="table table-striped table-bordered table-hover">
				<tbody>
					<tr>
						<td>Código Único de Identificación:</td>
						<td><span id="hdrCodigoUnicoDeIdentificacion">&nbsp;</span></td>
						<td rowspan="4" style="width: 10%; height: 50%;" id="tdImagen"></td>
					</tr>
					<tr>
						<td>Apellidos y Nombres:</td>
						<td><span id="hdrPrimerApellido">&nbsp;</span>&nbsp;&nbsp;<span id="hdrSegundoApellido">&nbsp;</span>&nbsp;<span id="hdrPrenombres">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Alias:</td>
						<td><span id="hdrAlias">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Sexo:</td>
						<td><span id="hdrSexo">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Homónimo:</td>
						<td><span id="hdrhomonimo">&nbsp;</span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-lg-12">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#liPrincipal" data-toggle="tab">Principal</a></li>
				<li class=""><a href="#liDatosContacto" data-toggle="tab">Datos de Contacto</a></li>
				<li class=""><a href="#liRasgosParticulares" data-toggle="tab">Rasgos Particulares</a></li>
				<li class=""><a href="#liBienes" data-toggle="tab">Bienes</a></li>
				<li class=""><a href="#liCasos" data-toggle="tab">Casos</a></li>
				<li class=""><a href="#liAntecedentes" data-toggle="tab">Antecedentes</a></li>
				<li class=""><a href="#liArchivosAdjuntos" data-toggle="tab">Archivos Adjuntos</a></li>
				<li class=""><a href="#liComentarios" data-toggle="tab">Comentarios</a></li>
				<li class=""><a href="#liAuditoria" data-toggle="tab">Auditoría</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane fade active in" id="liPrincipal">
					<jsp:include page="sospechoso/tabPrincipalSospechoso.jsp" />
				</div>
				<div class="tab-pane fade" id="liDatosContacto">
					<jsp:include page="sospechoso/tabDatosdeContacto.jsp" />
				</div>
				<div class="tab-pane fade" id="liRasgosParticulares">
					<jsp:include page="sospechoso/tabRasgosParticulares.jsp" />
				</div>
				<div class="tab-pane fade" id="liBienes">
					<jsp:include page="sospechoso/tabBienesPorSospechoso.jsp" />
				</div>
				<div class="tab-pane fade" id="liCasos">
					<jsp:include page="sospechoso/tabCasosDelSospechoso.jsp" />
				</div>
				<div class="tab-pane fade" id="liAntecedentes">
					<jsp:include page="sospechoso/tabAntecedentes.jsp" />
				</div>
				<div class="tab-pane fade" id="liArchivosAdjuntos">
					<jsp:include page="../componentes/archivos.jsp" />
				</div>
				<div class="tab-pane fade" id="liComentarios">
					<jsp:include page="../componentes/tabComentarios.jsp" />
				</div>
				<div class="tab-pane fade" id="liAuditoria">
					<p>Auditoria.</p>
				</div>
			</div>
		</div>		
		</div>
	</div>
</div>
</body>
</html>