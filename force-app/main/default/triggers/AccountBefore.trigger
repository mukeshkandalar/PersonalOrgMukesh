trigger AccountBefore on Account (before update) {
    
    
    If(Trigger.isBefore && Trigger.isUpdate){
        
        for(Account acc : trigger.new){
            If(acc.Name == 'XYZ'){
            acc.Name='Mahesh kumar';
                System.debug('Account name Details'+acc);
            }
        }
        
    }

}