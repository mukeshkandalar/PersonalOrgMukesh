({
 myAction : function(component, event, helper) 
     {

 component.set('v.columns', [
            {label: 'First Name', fieldName: 'FirstName', type: 'text',editable: true },
            {label: 'Last Name', fieldName: 'LastName', type: 'text',editable: true }
         ]);

         var ConList = component.get("c.getContactList");
         ConList.setParams
         ({
             recordId: component.get("v.recordId")
         });
        
         ConList.setCallback(this, function(data) 
                           {
                               component.set("v.ContactList", data.getReturnValue());
                           });
         $A.enqueueAction(ConList);
 },
    myActionUpdate : function(component, event, helper) 
     {
         var Updatelist = event.getParam('draftValues');
         var getupdatecontlist = component.get("c.getupdatecontact");
         getupdatecontlist.setParams({
             contls:Updatelist
         });
         getupdatecontlist.setCallback(this,function(response){
            var state = response.getState();    
         if(state==='SUCCESS'){    
             $A.enqueueAction(component.get('c.myAction')); 
            $A.get('e.force:refreshView').fire();
         }
          else{
                   //error handling
              }
         });   
             $A.enqueueAction(getupdatecontlist);                   
         }
})