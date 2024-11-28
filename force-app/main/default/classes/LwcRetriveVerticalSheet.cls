public class LwcRetriveVerticalSheet {
    @AuraEnabled(cacheable=true)
    public static list<Vertical_Sheet__c> VerticalSheetmethodName(){
        list<Vertical_Sheet__c> ver=[select id,Name,check__c,Delta__c from Vertical_Sheet__c];
       return ver;
        
    }

}