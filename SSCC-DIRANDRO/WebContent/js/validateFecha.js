
//custom validation method to make sure the date is in mm/dd/yyyy format 
jQuery.validator.addMethod(
    "peruDate",
    function(value, element) {
        // put your own logic here, this is just a (crappy) example
        return this.optional(element) || value.match(/^\d\d?\/\d\d?\/\d\d\d\d$/);
    },
    "El formato correcto de fecha es dd/mm/yyyy."
);

//validacion para numeros double, ahora solo tiene 2 decimales y cuando quieres aumentar aumentas el 1,2 a 1,3 por ejemplo.
jQuery.validator.addMethod(
		"doubleNumber", 
		function (value, element) {
			return this.optional(element) || /^(\d+|\d+,\d{1,2})$/.test(value) || /^(\d+|\d+.\d{1,2})$/.test(value);
		}, 
		"Please specify the correct number format."
);


