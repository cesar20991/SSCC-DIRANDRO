<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function showPopup() {
		var idSospechoso = $("#hdnIdSospechoso").text();
		var w = window.innerWidth;
		var h = window.innerHeight;
		var width = 800;
		var height = 500;
		var top = (h - height) / 2;
		var left = (w - width) / 2;
		window.open("popUpAsignarBien-" + idSospechoso, "_blank",
				"directories=no, status=no, menubar=no,scrollbars=yes, resizable=no,width="
						+ width + ", height=" + height + ", top=" + top
						+ ", left=" + left);
		return false;
	}
	

	function initBienesAsignado(bienes){
		$("#divMostrarBienes").empty();
		$.each(bienes, function(i,bien){

			var imagen ='';
			imagen = '<img src="img/skills.png" alt="logo" style="width: 90px; height: 120px;" />';
			$("#divMostrarBienes").append(
					'<table class="table table-bordered table-condensed">'+
 					'<tbody>'+
					'<tr>'+
						'<td rowspan="5" align="center" style="width: 90px; height: 100px;" id="tdImagen">'+imagen+'</td>'+
						'<td>Código:</td>'+
						'<td><span id="hdrCodigo">'+bien.codigo+'</span></td>'+
						'<td>Acción:</td>'+
						'<td><button class="btn btn-danger btn-mini asignar" id="cancelarAsignaBien_'+bien.idBien+'" type="button"><i class="icon-minus icon-white"></i></button></td>'+
					'</tr>'+
					'<tr>'+
						'<td>Partida Registral:</td>'+
						'<td colspan="3"><span id="hdrPartidaRegistral">'+bien.partidaRegistral+'</span></td>'+
					'</tr>'+
					'<tr>'+
						'<td>Tipo Bien:</td>'+
						'<td colspan="3"><span id="hdrTipo">'+bien.tipo+'</span></a></td>'+
					'</tr>'+
					'<tr>'+
						'<td>Valor Monetario:</td>'+
						'<td colspan="3"><span id="hdrValor">S/.'+bien.valor+'</span></td>'+
					'</tr>'+
					'<tr>'+
						'<td>Descripcion:</td>'+
						'<td colspan="3"><span id="hdrDescripcion">'+bien.descripcion+'</span></td>'+
					'</tr>'+
				'</tbody>'+
			'</table>');
		});
	}
	
	$(document).on('click','.asignar', function(e){
		var id1 = (this.id).split("_")[0];
		var id2 = (this.id).split("_")[1];
		
		switch(id1){
			case 'cancelarAsignaBien':
				var respuesta = confirm('¿Esta seguro que desea quitar este bien?');
				if(respuesta){
					$.ajax({
				 		url: 'desAsignarBienToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id2,
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(bienes){
				 			initBienesAsignado(bienes);
				 		}
				 	});
				}			
			break;
		}
		
	});
	
	$(document).ready(function(){
		$.ajax({
	 		url: 'getBienesPorSospechoso-'+$("#hdnIdSospechoso").text(),
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(bienes){
	 			initBienesAsignado(bienes);
	 		}
	 	});
	});
	
	
</script>
	<!-- MOSTRAR RASGOS PARTICULARES -->
	<div id="divBienesAsignados">
		<div id="alertasMostrarBien" style="display: none;"></div>
		<div id="divMostrarBienesAsignados">
			<form:form class="form-horizontal">
				<fieldset>
					<legend>
						<span class=""><span class="colored">///</span> Bienes asignados al sospechoso:</span> 
						<span class="offset3"><button
								class="btn btn-primary btn-small asignar" type="button" onclick="showPopup()"
								id="btnAsignarBien">
								<i class="icon-edit icon-white"></i> Asignar Bien
							</button></span>
					</legend>
					<div id="divMostrarBienes">
					
					</div>
				</fieldset>
			</form:form>
		</div>
	</div>


