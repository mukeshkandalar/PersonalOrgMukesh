({
	add : function(component) {
        
        var total = component.get("v.Value1") + component.get("v.Value2");
        component.set("v.sum",total); 
		
	}
})