trigger contactTotalCount on Contact (after insert,after update, after delete) {
    set<Id> accId = new set<Id>();
    Map<Id,List<contact>> AccToConMap = new Map<Id,List<contact>>();
    List<Account> AccToUpdated = new List<Account>();
    if(!trigger.isDelete)
    {
        for(contact con2:trigger.new){
        accId.add(con2.AccountId);
        }    
    }
    else
    {
        for(contact con2:trigger.old){
        accId.add(con2.AccountId);
        }
    }
    
    List<Account> accList = [select id,Total_Count__c from Account where Id IN:accId];
    List<contact> conList = new List<contact>();
    conList = [select id,ContactCount__c,AccountId from contact where AccountId IN: accId];
    for(contact con:conList){
        if(AccToConMap.containsKey(con.AccountId)){
            List<contact> contactsList = AccToConMap.get(con.AccountId);
            contactsList.add(con);
           AccToConMap.put(con.AccountId,contactsList);
        }
        else{
            AccToConMap.put(con.AccountId, new List<contact> {con});
        }
    }
    for(Account acc:accList){
        integer countfromContact=0;
        for(contact con1 : AccToConMap.get(acc.Id)){
            if(con1.ContactCount__c!=null){
             countfromContact = countfromContact + integer.valueof(con1.ContactCount__c);
            }
        
        acc.Total_Count__c = con1.ContactCount__c;
        }
        AccToUpdated.add(acc);
    }
    upsert AccToUpdated;
}