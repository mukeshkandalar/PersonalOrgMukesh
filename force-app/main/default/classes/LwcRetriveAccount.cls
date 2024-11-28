public class LwcRetriveAccount {
     @AuraEnabled(cacheable=true)
     public static list<Account> Accountmethodname(){
        list<Account> acc=[select id,name,Type,Industry from account];
        return acc;
     }
     
         
}