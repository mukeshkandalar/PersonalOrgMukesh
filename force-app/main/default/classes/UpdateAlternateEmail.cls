public class UpdateAlternateEmail {
    
    public static void altEmailMethod(Map<id,Contact> newValues,Map<id,Contact> oldValues) {
        Set<Id> newId = new Set<Id>();
		Map<id,Contact> conMap =new Map<id,Contact>();
        
        List<Account> OldMap = new List<Account>();
        if(newValues!=null && (trigger.isInsert||trigger.isUpdate) && trigger.isAfter) {
            For(contact con:newValues.values()) {
            newId.add(con.accountid);
			conMap.put(con.accountid,con);
            }
        }     

    /*    if(oldValues!=null && oldValues!=newValues && (trigger.isDelete || trigger.isupdate)) {
            For(contact con1:oldValues.values())
            newId.add(con1.accountid);
            OldMap.put(con1.accountid,con1);
        } */
        
        //Map<id,Account> accMap = new Map<id,Account>([select id,Alternate_email__c,(select id,Alternate_email__c from contacts) from Account where id =:newId]);
        
        For(Account Acc1 :[select id,Alternate_email__c from Account where id =:newId] ) {
            
            If(conMap!=null && conMap.Containskey(Acc1.id) && conMap.get(acc1.id).Alternate_email__c!=Null) {
                
                Acc1.Alternate_email__c = conMap.get(acc1.id).Alternate_email__c;
                OldMap.add(Acc1);
                
            }
        }
        
        If(OldMap!=null || OldMap.size()>0)
        {
        Database.upsert(OldMap,false);
        }
    }

}