public class TT {

  public List<SelectOption> myList {get; set;} 

public boolean showPOR {get; set;} 

public boolean showFrictionless {get; set;} 

public String SelectedVal {get; set;} 


public TT() 
{ 

    myList = new List<SelectOption>() ; 

    myList.add(new SelectOption('POR' , 'POR')) ; 

   myList.add(new SelectOption('Frictionless' , 'Frictionless')) ; 

    showPOR = false ; 
   showFrictionless = false ; 
   SelectedVal = '' ; 
} 

public PageReference RenderSec() 


{ 
    if(SelectedVal == 'POR') 

    { 

       showPOR = true ; 

   showFrictionless = false ; 
   getPorData();
   

    } 

    if(SelectedVal == 'Frictionless') 

    { 

        showPOR = false ; 
        showFrictionless = true ;
                
       getFtData();
    } 

    return null ; 

} 
 public  List<Data> getFtData() {
  

    List<Data> dataFt = new List<Data>();
      for(Vertical_Sheet__c v:[Select   Vertical__c,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Name from  Vertical_Sheet__c where  Vertical__c= 'Frictionless' order by Name asc limit 50 offset 5]){
      dataFt.add(new Data(v.name, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c));
      
       }
      return dataFt ;
  }
  
   public  List<Data> getPorData() {
  

    List<Data> dataPOR = new List<Data>();
      for(Vertical_Sheet__c v:[Select   Vertical__c,Coverage_w_o_Govn__c,Coverage_w__c,Name,Total_Components__c from  Vertical_Sheet__c where  Vertical__c= 'POR' order by Name asc limit 50 offset 5]){
      dataPOR.add(new Data(v.name, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c));
      
       }
      return dataPOR ;
  }
  
  // Wrapper class

  public class Data {

      public String name { get; set; }

      public Decimal data1 { get; set; }

      public Decimal data2 { get; set; }
      
       public Decimal data3 { get; set; }

      public Data(String name, Decimal data1, Decimal data2,Decimal data3) {

          this.name = name;
          

          this.data1 = data1;

          this.data2 = data2;
          
          this.data3 = data3;
          
      }

  }
}