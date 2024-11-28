trigger updateEmailboxandemailOnContact on Account(before insert,before update){
    
   /*set<Id> sAccId = new set<Id>();   
    
 List<Account> AccToUpdated = new List<Account>();
    List<Account> accList = [select id,Email_id__C from Account where Id IN:sAccId];
      
    if(trigger.old != trigger.new){
    for(Account acc: accList){
        if(acc.Email_Id__c != null){
             acc.EmailBox__c = true;
           AccToUpdated.add(acc);
            
        }
    }
  update AccToUpdated;
} */
}