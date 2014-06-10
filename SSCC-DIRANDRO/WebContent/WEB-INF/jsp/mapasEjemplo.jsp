<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>punto de acopio</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<script src="js/jquery.validate.min.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<style>
.error {
	color: rgb(255, 0, 0);
}
</style>
<script>
$(document).ready(function() {
	var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
	
  	var mapOptions = {
    	zoom: 4,
    	center: myLatlng
  	}
  	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  	var marker = new google.maps.Marker({
    	position: myLatlng,
      	map: map,
      	title: 'Hello World!',
      	draggable: true
  	});

	google.maps.event.addListener(marker, 'drag', function() {
   		$("#c").val(marker.getPosition());
  	});
});
	

</script>
</head>
<body>
	<div id="map-canvas" style="height: 1000px; width: 1000px;"></div>
	<input name="ce" type="text" id="c" class="span4">
</body>
</html>