public class UpdateContactEmailClass {
    
    
    // Map<id,Account> mapacc = new Map<id,Account>();
    
    public static void UpdateContactEmailMethod() {
        set<Id> sAccId = new set<Id>();
        List<contact> lstConUpdate = new List<Contact>();
        
        /*  If(newValues!=Null && (Trigger.isInsert || Trigger.isUpdate)) {

for(Contact con : newValues.Values()) {
sAccId.add(con.AccountId);
} */
        Map<id,Account> lstAccount =new Map<id,Account>([select id, Email_id__c, (select id,Email from contacts) from account where id IN: sAccId]);
        //Map<id,contact> con1 =new Map<id,contact>();
        For(Account acc:lstAccount.values()){
           // if(con1!=null &&  con1.containskey(acc.contacts)){
            for(Contact con1:acc.contacts){
                
                con1.Email = acc.Email_id__c;
                lstConUpdate.add(con1);
            }
        }
        if(lstConUpdate!=Null && lstConUpdate.size()>0) {
            database.update(lstConUpdate,false);
            
        }
    }
}