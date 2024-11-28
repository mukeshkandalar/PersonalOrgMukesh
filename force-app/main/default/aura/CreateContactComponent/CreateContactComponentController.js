({
	handleReview : function(component, event, helper) {
		var isValid = helper.ValidateFileds(component, event, helper);
        
        if(isValid){
            var componentEvent = component.getEvent('CreateContactEvent');
           // component.set('v.ContactRecord.AccountId',component.get('v.recordId'));
            componentEvent.setParams({
                'conRecord' : component.get("v.ContactRecord")
            });
            componentEvent.fire();
        }else{
            alert("Please fill the Required Fields");
        }
        
	},
    SelectedRecord : function(component, event, helper) {
        alert('Slected Record');
    }
})