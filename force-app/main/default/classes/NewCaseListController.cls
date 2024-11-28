public class NewCaseListController {

private String sortOrder = 'CaseNumber';
public static List<case> getNewCases() {
List<case> results = new List<case>();

  Id PlanId = ApexPages.currentPage().getParameters().get('id');
    
    results = [SELECT Id, CaseNumber FROM Case WHERE Status ='New' ];

    return results;
    }
}