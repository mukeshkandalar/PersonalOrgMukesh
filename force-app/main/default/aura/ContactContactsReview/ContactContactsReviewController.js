({
	RemoveRecord : function(component, event, helper) {
		var index = event.currentTarget.id;
        var existingRecords = component.get('v.ContactRecords');
        existingRecords.splice(index,1);
        component.set('v.ContactRecords',existingRecords);
	},
    EditRecord : function(component, event, helper) {
		var index = event.currentTarget.id;
        var existingRecords = component.get('v.ContactRecords');
        var selectedRecords = existingRecords[index];
        console.log('selectedRecords',selectedRecords);
        var SeleRecordEvent = component.getEvent('SelectedEditEvent');
        SeleRecordEvent.setparams({
            Contact : selectedRecords
        });
        SeleRecordEvent.fire();
	},
})