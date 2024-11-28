public class ApprAccount {

public static String str{get;set;}

 public string IdToSubmitForApproval{get;set;}


 
    public ApprAccount(ApexPages.StandardController controller) {

    }
    public PageReference sumbitForApproval(){
   
    str=apexpages.currentpage().getparameters().get('id');
    
    System.debug('Hello'+str);
    try{
   
   Account acc1 = [Select id,name,annualRevenue from Account where id=:str and annualRevenue>1000];
  // parameterValue = ApexPages.CurrentPage().getparameters().get('nameParam');
    
 acc1.EmailBox__c=true;
 
  Update acc1;

// Create an approval request for the account

Approval.ProcessSubmitRequest req1 = 
      new Approval.ProcessSubmitRequest();
req1.setObjectId(acc1.id);
req1.setSubmitterId('0057F000000qnR1');
Approval.ProcessResult result = 
                   Approval.process(req1);
    } 
     
    catch (Exception ex){
        System.debug('Exception caught');
    }
    return null;
}
}