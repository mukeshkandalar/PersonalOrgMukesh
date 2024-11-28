trigger myTest on Account(before update,before delete){
    for(Account sc : Trigger.old){
       System.debug('Hello'+sc.Total_Count__c); // will return 2000
    }
    for(Account sc : Trigger.new){
         System.debug('Hi'+sc.Total_Count__c); // will return 3000

    }

}