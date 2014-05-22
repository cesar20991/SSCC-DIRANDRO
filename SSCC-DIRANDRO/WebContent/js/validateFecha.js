
//custom validation method to make sure the date is in mm/dd/yyyy format 
jQuery.validator.addMethod(
    "peruDate",
    function(value, element) {
        // put your own logic here, this is just a (crappy) example
        return value.match(/^\d\d?\/\d\d?\/\d\d\d\d$/);
    },
    "Please enter a date in the format dd/mm/yyyy."
);
