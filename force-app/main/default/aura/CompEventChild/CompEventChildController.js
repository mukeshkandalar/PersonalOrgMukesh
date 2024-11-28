({
	myOnclick : function(component, event, helper) {
        
        var event = component.getEvent("cmpEvent"); 

//set the response value inside eventResponse of componentEvent attribute   
 event.setParams({
 "eventResponse1" : "This is response from child "
 }); 
//fire the event    
    event.fire();     
   }
})