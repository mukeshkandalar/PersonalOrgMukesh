({
	add : function(component, event, helper) {
        var total = component.get("v.Value1") + component.get("v.value2");
        component.set("v.sum",total);
	}
})