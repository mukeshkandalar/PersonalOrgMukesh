public with sharing class LwcRetriveAccountImp {
    @AuraEnabled(cacheable=true)
    public static list<Account> Accountmethodname(){
       list<Account> acc=[select id,name,Type,Industry from account];
       return acc;

    }
}