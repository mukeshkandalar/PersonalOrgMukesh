public class AccountUpdation {
    
public void methodname(){
           List<Account> acc = new List<Account>();
           List<Account> acclist = new List<Account>();

          acc = [select id, Name from Account];  ////Storing the Query records in list of Account
        for(Account acct : acc){
                if(acct.Name=='XYZ'){
                    acct.name = 'Mahesh'; 
                  acclist.add(acct);
                }
        }
       update acclist;
System.debug('Account Updattion'+acclist);
    }
}