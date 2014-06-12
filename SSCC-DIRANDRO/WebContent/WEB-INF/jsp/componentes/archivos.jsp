<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).on('click','#btnOcultar', function(e){
	$("#formularioGuardar").hide();
	$("#btnOcultar").hide();
	$("#btnMostrar").show();
});
$(document).on('click','#btnMostrar', function(e){
	$("#formularioGuardar").show();
	$("#btnOcultar").show();
	$("#btnMostrar").hide();
});

$(document).ready(function(){
	$("#hdnTipoEntidad").val(tipoEntidad);
	$("#hdnIdEntidad").val(idEntidad);
	
	 var options = { 
	    beforeSend: function() 
	    {
	        $("#progress").show();
	        //clear everything
	        $("#bar").width('0%');
	        $("#message").html("");
	        $("#percent").html("0%");
	    },
	    uploadProgress: function(event, position, total, percentComplete) 
	    {
	        $("#bar").width(percentComplete+'%');
	        $("#percent").html(percentComplete+'%');
	 
	    },
	    success: function() 
	    {
	        $("#bar").width('100%');
	        $("#percent").html('100%');
	 
	    },
	    complete: function(response) 
	    {
	    	$("#alertasArchivos").show();
 			$("#alertasArchivos").append('<div class="alert alert-success" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">Asjuntado Correctamente</strong>'+
				 			    '</div>');
	        //$("#message").html("<font color='green'>"+response.responseText+"</font>");
	    },
	    error: function()
	    {
	        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
	 
	    }
	 
	}; 
	$("#formArchivos").ajaxForm(options);
	//$(document).on('click','#guardarArchivos', function(e){
		/*$("#myForm").ajaxForm(function() { 
	         alert("Form is submitted"); 
		});*/
	//});	
	
});
</script>
<div id="alertasArchivos" style="display: none;">
</div>
<div id="divArchivo">
	<div id="divGuardarArchivo">
		<form:form method="post" action="newArchivo" enctype="multipart/form-data" id="formArchivos">
			<legend>
				<span class="">Subir Archivos</span>
				<span class="offset3">
					<button class="btn btn-small" type="button" id="btnOcultar"><i class="icon-chevron-up"></i> Ocultar</button>
					<button class="btn btn-small" type="button" id="btnMostrar" style="display: none;"><i class="icon-chevron-down"></i> Mostrar</button>
				</span>
			</legend>
			<div id="formularioGuardar">
				<div class="controls">
		        	<input class="input-file" type="file" name="files" multiple="multiple"/>
		        	<div id="progress">
				        <div id="bar"></div>
				        <div id="percent">0%</div>
					</div>
					
		        	<input type="hidden" id="hdnTipoEntidad" name="tipoEntidad">
		        	<input type="hidden" id="hdnIdEntidad" name="idEntidad">
		        	
		        	<div id="message"></div>
		        </div>	    
			    <div class="form-actions">
		        	<button type="submit" class="btn btn-success" id="guardarArchivos"><i class="icon-tags icon-white"></i> Guardar Archivos</button>
		        </div>
			</div>
		    <!-- <input type="submit" name="new"/> -->
		    
		</form:form>
	</div>
	<div id="divMostrarArchivo">
		
	</div>
</div>
