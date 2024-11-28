@isTest
Public class VerticalSheetUtilityTest {
   
    
    public List<SelectOption> myList = new List<SelectOption>() ; 
    
    static testMethod void Test1(){
        
        Test.startTest();
        // ChartController.getFtData();
        Vertical_Sheet__c vs = new Vertical_Sheet__c(Vertical__c = 'Frictionless',Coverage_w_o_Govn__c = 88.72,Coverage_w__c = 88.82,Name = '17.08.02' ,Total_Components__c = 18);
        
        insert vs;
        
        Test.stopTest();
    }   
    public static testMethod void Test2(){
        
        Test.startTest();
        
        Vertical_Sheet__c vs = new Vertical_Sheet__c(Vertical__c = 'Frictionless',Coverage_w_o_Govn__c = 88.72,Coverage_w__c = 88.82,Name = '17.08.02' ,Total_Components__c = 18);
        
        insert vs;
        
        ChartController.Data dataWrapper = new ChartController.Data('17.08.02',88.72,88.82,18.00);
        ChartController ch = new  ChartController();
        ch.SelectedVal=GlobalConstant.POR;
        ch.RenderSec();
        ChartController ch1 = new  ChartController();
        ch1.SelectedVal= GlobalConstant.FTL;
        
        ch1.RenderSec();
        
        
        
        
        Test.stopTest();  
    } 
    
}