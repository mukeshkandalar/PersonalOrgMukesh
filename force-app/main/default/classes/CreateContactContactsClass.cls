public class CreateContactContactsClass {
    @AuraEnabled
        public static void getContactlist(List<Contact> newContactlist,String accId){
        for(Contact con : newContactlist){
            con.accountId = accId;
        }
        insert newContactlist;
    }
}