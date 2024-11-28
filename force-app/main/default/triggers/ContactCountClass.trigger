trigger ContactCountClass on Contact (before update) {
    
    for(Contact con : trigger.new){
        
        if(Trigger.oldmap.get(con.Id) != con || Trigger.oldmap.get(con.Id).ContactModifiedCount__c != con.ContactModifiedCount__c){
            if(con.ContactModifiedCount__c>0 && con.ContactModifiedCount__c!=null ){
            con.ContactModifiedCount__c +=1;
        }
            else {
                con.ContactModifiedCount__c = 1;
            }
        }
    }
}