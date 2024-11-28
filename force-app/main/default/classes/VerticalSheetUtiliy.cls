public class VerticalSheetUtiliy {
    
    public static List<Vertical_sheet__c>  getVerticalSheet(String P1) {
        
        List<Vertical_sheet__c> data = new List<Vertical_sheet__c>();
         
         data = [Select   Vertical__c,Coverage_w_o_Govn__c,Coverage_w__c,Name,Total_Components__c from  Vertical_Sheet__c where  Vertical__c=:P1 order by CreatedDate desc limit 6] ;
        
         return data ;
    } 
    public static List<Vertical_sheet__c>  getVerticalSheet1(String P2) {
        
        List<Vertical_sheet__c> data = new List<Vertical_sheet__c>();
         
         data = [Select   Vertical__c,name,Red__c,Yellow__c from  Vertical_Sheet__c where  Vertical__c=:P2 order by CreatedDate desc limit 6] ;
         
         return data ;
    }
}