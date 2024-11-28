trigger updateemailOnContact on Contact(before insert,before update){
    
  set<Id> sAccId = new set<Id>();
    
    for(Contact con: trigger.new){
        sAccId.add(con.AccountId);
    }
 //   List<Account> AccToUpdated = new List<Account>();
   // List<Account> accList = [select id,Email_id__C from Account where Id IN:sAccId];
    // parent to child updation must be use by map
    Map<Id,Account> mapAccount = new Map<Id,Account>([select id, Email_id__c from account where id IN :sAccId]);
    for(Contact con: trigger.new){
        //for(account acc1 : lstAccount){
        if(con.AccountId!=null && String.isBlank(con.Email) && mapAccount!=null && mapAccount.containsKey(con.AccountId)){
            
            con.Email = mapAccount.get(con.AccountId).Email_id__c;
        }
    }
      
   /* for(Account acc:accList){
        if(acc.Email_Id__c != null){
            
            acc.EmailBox__c = true;
            AccToUpdated.add(acc);
            
        }
    }
    update AccToUpdated;*/
}