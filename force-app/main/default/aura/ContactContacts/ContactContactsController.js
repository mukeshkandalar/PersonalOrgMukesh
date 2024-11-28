({
	dohandler : function(component, event, helper) {
       // alert('Event handle');
		var conRecord = event.getParam('conRecord');
        var conList = component.get('v.ContactList');
        if(conList){
            conList.push(conRecord);
            component.set('v.ContactList',conList);
        }else{
            conList =[];
            conList.push(conRecord);
            component.set('v.ContactList',conList);
          //  alert('Test');
        }
	},
    
    dohandleSave : function(component, event, helper) {
        var contactApexMethod = component.get('c.getContactlist');
        contactApexMethod.setParams({
            newContactlist : component.get('v.ContactList'),
            accId : component.get('v.recordId')
        });
        contactApexMethod.setCallback(this, function(response){
               var state = response.getState();
        if(state==='SUCCESS' || state==='DRAFT'){
            $A.get('e.force:refreshView').fire();
        }  else if(state==='INCOMPLETE'){
            
        } else if(state==='ERROR'){
            var errors = response.getError();
            console.log('error',errors);
        }else{
            
        }                  
                                      
       },'ALL');
        $A.enqueueAction(contactApexMethod);
    },
    SelectedEditEventHandler : function(component, event, helper) {
    alert('Event Selected Handler');
    var SelectedRecordEdit = event.getParam('Contact');
    console.log('SelectedRecordEdit',SelectedRecordEdit.FirstName);
        var createContact = component.find('');
        createContact.SelectedRecordEdit(SelectedRecordEdit);
}
    
})