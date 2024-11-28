public with sharing class AccountDataController {
  //constructor
  public AccountDataController() {
  }

  //list of accounts
  public List<Account> accounts {
    get {
      if(accounts != null) {
        return accounts;
      } else {
        accounts = [Select Id, name, Active__c, SLA__c, Description from Account limit 10];
        return accounts;
      }
    }
    set;
  }
  public Pagereference exportAll(){
    return new Pagereference('/apex/ExcelFilePage');
 }
}