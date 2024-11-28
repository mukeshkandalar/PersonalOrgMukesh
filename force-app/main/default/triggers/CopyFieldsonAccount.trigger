trigger CopyFieldsonAccount on Account (before insert,before update) {
    for(Account account : trigger.new) {
    
    If(trigger.isInsert && account.type=='Prospect') {
     //Field that you want to be copied by other field keep those on left side
      account.CsrAcc__c = account.Csr__c;    
      }
     
      else {
      
      if(account.CsrAcc__c == Trigger.oldMap.get(account.Id).CsrAcc__c && account.type=='Other'){
          account.Csr__c = Trigger.oldMap.get(account.Id).CsrAcc__c;
        }
        }
    }
    
}