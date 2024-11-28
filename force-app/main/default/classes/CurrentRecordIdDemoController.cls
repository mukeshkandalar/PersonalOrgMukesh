public class CurrentRecordIdDemoController {
public String currentRecordId {get;set;}
public String parameterValue {get;set;}
public Account acc{get;set;}
 
    public CurrentRecordIdDemoController(ApexPages.StandardController controller) {
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        acc = [select id ,type,industry,Accountnumber from Account where id =:currentRecordId and annualRevenue >1000];
        parameterValue = ApexPages.CurrentPage().getparameters().get('nameParam');
    }
}