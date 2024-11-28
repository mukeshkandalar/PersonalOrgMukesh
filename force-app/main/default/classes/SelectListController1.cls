public class SelectListController1 {
    public static String  showRelease {get; set;}
    public static String  ParentValue {get; set;}
    public static String  none='Select Verticals';
    
   public List<SelectOption> VerticalOptions{get; set;}
    
    public SelectListController1() {
    }
    public List<SelectOption> getParentOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(none,none)); 
        for (Release1__c record : [select Id,name from Release1__c LIMIT 100])
        {
            options.add(new SelectOption(record.Id,record.Name));
        } 
        return options; 
    }   
     public void savedetails(){       
            System.debug('releasedata...................ppppp.'+showRelease);
            
       VerticalOptions= new List<SelectOption>();
        VerticalOptions.add(new SelectOption(none,none)); 
        for (Vertical1__c Ver:[select Id,verticals__c, Name from vertical1__c where verticals__c=:parentvalue])
        {
             VerticalOptions.add(new SelectOption(Ver.Name,Ver.Name));
        }  
        system.debug('listssss'+ParentValue); 
        }
        
    public  List<WrapData> getNovasuiteData() {
        system.debug('check hello');
        List<String> vs = new List<String>();
        for(Vertical1__c v : [Select Name from Vertical1__c order by Name DESC limit 5]){
            vs.add(v.Name);
            //system.debug('check+++'+i.ParentValue);
        }
        List<WrapData> dataNovasuite = new List<WrapData>();
        System.debug('showRelease++'+showRelease);
        if(showRelease!=null && showRelease!=none){      
            for(Vertical1__c v:[Select Name,Gating_Values__c,Prod_Count__c from Vertical1__c where Name =: showRelease limit 1]){
                dataNovasuite.add(new WrapData(v.Name,v.Gating_Values__c, v.Prod_Count__c));
            }
        }
        else if(ParentValue!=null && ParentValue!=none) {
             for(Vertical1__c v:[Select Name,Gating_Values__c,Prod_Count__c from Vertical1__c where Verticals__c=:ParentValue]){
                dataNovasuite.add(new WrapData(v.Name,v.Gating_Values__c, v.Prod_Count__c));
            }
        }
        else{
            System.debug('in if showRelease2***'+showRelease);
            for(Vertical1__c v: [select Name,Gating_Values__c,Prod_Count__c from Vertical1__c  where Name =:vs]) {
                dataNovasuite.add(new WrapData(v.Name, v.Gating_Values__c, v.Prod_Count__c));
            }
        }
        return dataNovasuite ;
    }

       // Wrapper class
    /**
    @ This is wrapper class which defines the data points in the verticals
    *
    */
    public with sharing class WrapData {
       Public  String name { get; set; }
       Public Decimal a { get; set; }
       Public Decimal b { get; set; }
        
        // Wrapper class
        /**
        @ This is wrapper Constructor  which defines the data points in the verticals

        *
        */  
        public WrapData(String name, Decimal a, Decimal b) {
            this.name = name;
            this.a = a;
            this.b = b;
        }
    }   
}