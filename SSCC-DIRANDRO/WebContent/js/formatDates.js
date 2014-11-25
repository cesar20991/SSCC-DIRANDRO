/*DATES FORMATTED*/
//Timestamp
function timeStampFormatted(myDate){
	//alert("myDate TS ORIG: " + myDate);
	//alert("myDate TS No 1000: " + new Date(myDate));
	var tempDate = "" + myDate;
	
	if(tempDate != "null"){
		var myDateF = new Date(myDate);
		var hours = myDateF.getHours();
		var minutes = myDateF.getMinutes();
		var ampm = hours >= 12 ? 'PM' : 'AM';
		hours = hours % 12;
		hours = hours ? hours : 12; // the hour '0' should be '12'
		minutes = minutes < 10 ? '0'+minutes : minutes;
		var myMonth = myDateF.getMonth();
		var myDay = myDateF.getDate();
		myMonth++;
		//myDay++;
		var dateTime = "";
			if(myMonth <= 9){
				dateTime = myDay + "/" + "0" + myMonth + "/" + myDateF.getFullYear() + " " + hours + ":" + minutes + " " + ampm;
			}
			if(myDay <= 9){
				dateTime = "0" + myDay + "/" + myMonth + "/" + myDateF.getFullYear() + " " + hours + ":" + minutes + " " + ampm;
			}
			if(myDay <= 9 && myMonth <= 9){
				dateTime = "0" + myDay + "/" + "0" + myMonth + "/" + myDateF.getFullYear() + " " + hours + ":" + minutes + " " + ampm;
			}
			if(myDay >= 9 || myMonth >= 9){
				dateTime =  myDay + "/" + myMonth + "/" + myDateF.getFullYear() + " " + hours + ":" + minutes + " " + ampm;
			}
		return dateTime;
	}else{
		return "";
	}
}
//Date         		
function dateFormatted(myDate){
	//Inverse to converter
	//alert("myDate: " + myDate);
	var tempDate = "" + myDate;
	
	if(tempDate != "null"){
		var vec = tempDate.split('-');
		return vec[1] + '/' + vec[2] + '/' + vec[0];
	}else{
		return "";
	}
	
}