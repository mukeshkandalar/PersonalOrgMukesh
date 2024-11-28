({ 
	getNumbers: function(component) { 
	var listOfNum = []; 
		for (var i = 0; i < 10; i++) {
			 listOfNum.push({ value: i }); 
		} 
component.set("v.numbers", listOfNum);
 }})