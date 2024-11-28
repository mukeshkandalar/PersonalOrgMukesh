public class AvoidDmlInTrigger {
    Public void BestPractise(List<Account> accList){
//List<Account> accList = Trigger.new; 
   List<user> userList = new List<User>();
   User u;
if(accList.size()>10) {
   for(Account acc:accList ) { 
  
          u = [SELECT Id FROM user WHERE name =:acc.Name];
          userList.add(u); 
		  } 
      update userList;
    } 
   }
}