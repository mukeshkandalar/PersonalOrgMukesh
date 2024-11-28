public with sharing class Modal_LWC_controller {
    @AuraEnabled(cacheable=true)
    public static WrapperClass fetchWrapperData(String sfNameWr){
        WrapperClass wrapperClassVar = new WrapperClass();
            wrapperClassVar.contactList = Modal_LWC_controller.getRelatedContacts(sfNameWr);
		/*else if(sfNameWr.getSobjectType() == Schema.Contact.SObjectType){
            wrapperClassVar.accId = Modal_LWC_controller.getAccId(sfNameWr);
        }*/
        System.debug('wrapperClassVar-->>'+wrapperClassVar);
        return wrapperClassVar;
    }
    
    public static List<Contact> getRelatedContacts(String sfName){
        return [SELECT Id, Name,firstName, Phone, Email FROM Contact where FirstName=:sfName];
    }
        
 /*   public static String getAccId(String contactId) {
        return [SELECT Id, AccountId FROM Contact WHERE Id=:contactId].AccountId; 
    } */
    
    public class WrapperClass {
        @AuraEnabled
        public List<Contact> contactList {get; set;}
        @AuraEnabled
        public String sfName1{get; set;} 

        
        public wrapperClass() {
            this.contactList = new List<Contact>();
        }
    }
}