public class LwcRetriveContract {
    @AuraEnabled(cacheable=true)
    public static list<Coach__c> contractmethodName(){
        list<Coach__c> con=[select id,Name from Coach__c];
        return con;
        
    }
    
}