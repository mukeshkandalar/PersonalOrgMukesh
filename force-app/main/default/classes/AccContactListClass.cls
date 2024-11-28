public class AccContactListClass {
    
    @AuraEnabled
    Public static List<Contact> getContactList(Id recordId){
        List<Contact> Conlist = new  List<Contact>();
        if(recordId!=null)
         Conlist = [Select id, name,firstName,lastName,Email,phone from Contact where AccountId=: recordId];
        
        return Conlist;  
        
    }
    @AuraEnabled
    public static void getupdatecontact(List<Contact> contls){
        if(contls.size()>0){
            update contls;
        }
    }
        

}