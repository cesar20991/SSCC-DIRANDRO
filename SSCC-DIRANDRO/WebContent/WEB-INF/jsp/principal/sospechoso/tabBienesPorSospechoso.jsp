<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
.controls {
	margin-top: 3px;
}
</style>
<script type="text/javascript">
	function showPopup() {
		var idSospechoso = $("#hdnIdSospechoso").text();
		var w = window.innerWidth;
		var h = window.innerHeight;
		var width = 800;
		var height = 500;
		var top = (h - height) / 2;
		var left = (w - width) / 2;
		window.open("toBuscarBien-"+idSospechoso, "_blank",
				"directories=no, status=no, menubar=no,scrollbars=yes, resizable=no,width="
						+ width + ", height=" + height + ", top=" + top
						+ ", left=" + left);
	}
</script>
<body>
	<!-- MOSTRAR RASGOS PARTICULARES -->
	<div id="divMostrarBienes">

		<input type="button" onclick="showPopup()" value="Mostrar Popup" />


	</div>

</body>
</html>