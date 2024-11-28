global class UpdateAccountBatch implements  Database.Batchable<sObject>, Database.Stateful{
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator('SELECT ID, Name FROM Account ');
    }
     global void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Account> acclist = new List<Account>();
        for (Account acc : scope) {
            If(acc.Name == 'test1'){
                acc.Phone = '90324353442';
                acclist.add(acc);
            }
              
              
            }
         update acclist;    

}
    
     global void finish(Database.BatchableContext bc){
     }
    
}