public class ChartController1 {


  // Return a list of data points for a chart
 

  public static  List<Vertical_Sheet__c>  ChartController2 () { 

  list<Vertical_Sheet__c> data = new List<Vertical_Sheet__c>();
    

      for(Vertical_Sheet__c v:[Select   Vertical__c,Coverage_w_o_Govn__c,Coverage_w__c,Name from  Vertical_Sheet__c where  Vertical__c= 'Frictionless' order by Name asc limit 50 offset 5]){
      data.add(v);
      
       }
    return data;
  }
  }