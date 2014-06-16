<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Buscar Sospechoso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- validacion -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- mapas -->
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
</head>
<script type="text/javascript">
$.ajax({
		url: 'getSopechosos',
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechosos){
			$("#divSospechosos").empty();
			$.each(sospechosos, function(i, sospechoso) {
				var imagen = '';
				
				if(sospechoso.urlSospechoso == null){
					imagen = '<img src="img/skills.png" alt="logo" style="width: 90px; height: 120px;" />';
				}else{
					imagen = '<img src="'+sospechoso.urlSospechoso+'" alt="logo" style="width: 90px; height: 120px;" />';
				}
				var sexo = '';
				if(sospechoso.sexo == 'M'){
					sexo = 'Masculino';
				}else if(sospechoso.sexo == 'F'){
					sexo = 'Femenino';
				}
				
				$("#divSospechosos").append(
						'<table class="table table-bordered table-condensed">'+
		 					'<tbody>'+
							'<tr>'+
								'<td rowspan="5" align="center" style="width: 90px; height: 100px;" id="tdImagen">'+imagen+'</td>'+
								'<td>Código Único de Identificación:</td>'+
								'<td align="center"><span id="hdrCodigoUnicoDeIdentificacion">'+sospechoso.codigoUnicoDeIdentificacion+'</span></td>'+
								'<td>Acción:</td>'+
								'<td><button class="btn btn-danger btn-mini asignar" id="" type="button" onlcick="selectAndClose(&#39;'+sospechoso.codigo+'&#39;)"><i class="icon-plus icon-white"></i></button></td>'+
							'</tr>'+
							'<tr>'+
								'<td colspan="2">Apellidos y Nombres:</td>'+
								'<td colspan="2"><span id="hdrPrimerApellido">'+sospechoso.primerApellido+'</span>&nbsp;<span id="hdrSegundoApellido">'+sospechoso.segundoApellido+'</span>&nbsp;<span id="hdrPrenombres">'+sospechoso.preNombres+'</span></td>'+
							'</tr>'+
							'<tr>'+
								'<td colspan="2">Alias:</td>'+
								'<td colspan="2"><a href="toSospechosoPrincipal-'+sospechoso.idSospechoso+'"><span id="hdrAlias">'+sospechoso.alias+'</span></a></td>'+
							'</tr>'+
							'<tr>'+
								'<td colspan="2">Sexo:</td>'+
								'<td colspan="2"><span id="hdrSexo">'+sexo+'</span></td>'+
							'</tr>'+
						'</tbody>'+
					'</table>');
			});
		}
	});
	
function selectAndClose(codigo, cui, primerApellido, segundoApellido, prenombres, alias, sexo, fecNacimiento, depNacimiento, provNacimiento, distNacimiento, gradoInstruccion, estadoCivil, estatura, fecInscripcion, nomPadre, nomMadre, fecEmision, restriccion, domicilio, depDomicilio, provDomicilio, distDomicilio, multas){
	window.opener.$("#txtCodigo").val(codigo);
	window.opener.$("#hdnCodUnico").val(cui);
	window.opener.$("#txtCodUnico").val(cui);
	window.opener.$("#txtPrimerApellido").val(primerApellido);
	window.opener.$("#txtSegundoApellido").val(segundoApellido);
	window.opener.$("#txtPrenombres").val(prenombres);
	window.opener.$("#txtAlias").val(alias);
	
	if(sexo == 'F'){
		window.opener.$("#checkFemenino").prop("checked",true);
	}else if(sexo == 'M'){
		window.opener.$("#checkMasculino").prop("checked",true);
	}	
	
	window.opener.$("#txtFecNac").val(fecNacimiento);
	window.opener.$("#hdnFecNac").val(fecNacimiento);
	window.opener.$("#txtDepartamentoDeNacimiento").val(depNacimiento);
	window.opener.$("#txtProvinciaDeNacimiento").val(provNacimiento);
	window.opener.$("#txtDistritoDeNacimiento").val(distNacimiento);
	window.opener.$("#selectGradoInstruccion").val(gradoInstruccion);
	window.opener.$("#sltcEstadoCivil").val(estadoCivil);
	window.opener.$("#txtEstatura").val(estatura);
	window.opener.$("#hdnEstatura").val(estatura);
	window.opener.$("#txtInscripcion").val(fecInscripcion);
	window.opener.$("#hdnFecIns").val(fecInscripcion);
	window.opener.$("#txtNombrePadre").val(nomPadre);
	window.opener.$("#txtNombreMadre").val(nomMadre);
	window.opener.$("#txtEmision").val(fecEmision);
	window.opener.$("#hdnFecEmi").val(fecEmision);
	window.opener.$("#txtRestriccion").val(restriccion);
	window.opener.$("#txtDomicilio").val(domicilio);
	window.opener.$("#txtDepartamentoDeDomicilio").val(depDomicilio);
	window.opener.$("#txtProvinciaDeDomicilio").val(provDomicilio);
	window.opener.$("#txtDistritoDeDomicilio").val(distDomicilio);
	window.opener.$("#txtMultasElectorales").val(multas);
	window.opener.$("#hdnMultasElectorales").val(multas);
	
	window.close();
}
</script>
<body>
	<div id="divMostrarSospechosoAsignado">
		<form:form class="form-horizontal">
			<fieldset>
				<legend>
					<span class="colored">///</span> Sospechosos:
				</legend>
				<div id="divSospechosos">
				
				</div>
			</fieldset>
		</form:form>
	</div>
</body>
</html>