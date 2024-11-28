public class AvoidDescribeCallsInsideForLoop {
            
    //Bad Practice
    private void badPractice() {
        for(Integer i=0 ; i<10 ; i++){
Schema.DescribeFieldResult F = Account.Industry.getDescribe();
Schema.sObjectField T = F.getSObjectField();
        }
    }
   
    //Best Practice
    private void bestPractice(){      
        Schema.DescribeFieldResult F = Account.Industry.getDescribe();
      Schema.sObjectField T = F.getSObjectField();
       
    }
}