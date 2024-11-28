({
	add : function(component, event, helper) {
        
        var total = component.get("Value1") + component.get("Value2");
        component.set("v.sum",total); 
		
	}
})