public class SelectListController {

    public static String  showRelease {get; set;}
    //public static String  ParentValue{get; set;}
    public Static Final String none = 'None'; 
    public static List<ID> s{get;set;} 
    //public static parentdata{get;set;}
    public Release1__c record {get;set;}
    public List<SelectOption> VerticalOptions {get;set;}
    //public List<ItemWrapper> i{get;set;}
    ItemWrapper[] items;
    
    //Release select options for the opportunities
    @RemoteAction
    public static List<WrapData> parentdata(String a)
    {
        List<WrapData> dataNovasuite = new List<WrapData>();
        for(Vertical1__c v : [Select Name,Gating_Values__c,Prod_Count__c from Vertical1__c where verticals__c =: a])
        dataNovasuite.add(new WrapData(v.Name,v.Gating_Values__c, v.Prod_Count__c));
        return dataNovasuite;

    }
    
    public List<SelectOption> getParentOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(none,none));   
        for (Release1__c record : [select Id, Name from Release1__c LIMIT 100])
        {
            options.add(new SelectOption(record.Id,record.Name));
        }
        return options;
    }

    // returns list of ItemWrappers, each holding an Release record as well

    // as a list of Verticals selectOptions
    public ItemWrapper[] getItems(){ 
        if (items == null)
        {
            items = new ITemWrapper[]{};
            Release1__c[] records = [select Id, Name  from Release1__c  where ID != null LIMIT 1];
            Id[] ReleaseIds = new Id[]{};
            //query Releases with Verticals to bulk setup select options
            Map<Id,Release1__c> releaseMap = new Map<Id,Release1__c>([select Id, ( select Id , Name from verticals__r) from Release1__c 
                                                                     where Id IN: ReleaseIds]);

            //setup one ItemWrapper  and generate the selectOptions using the Release Map
            for (Release1__c record: records)
            {
                ItemWrapper item = new ItemWrapper(record);
                items.add(item);
            }                
        }           
        return items;
    }

    public void savedetails(){       
        System.debug('releasedata...................ppppp.'+showRelease);
    } 
    
    public PageReference renderSec(){ 
        //getNovasuiteData();
        return null;
    }   
    
    public  List<WrapData> getNovasuiteData() {
        system.debug('List of Str'+s);
        system.debug('check hello');
        List<String> vs = new List<String>();

        for(Vertical1__c v : [Select Name from Vertical1__c order by Name DESC limit 5]){
            vs.add(v.Name);
            //system.debug('check+++'+i.ParentValue);
        }

        List<WrapData> dataNovasuite = new List<WrapData>();
        System.debug('showRelease++'+showRelease);
        if(showRelease!=null && showRelease!=none){      
            //System.debug('in if showRelease+++'+showRelease+'parentvalue'+s);
            for(Vertical1__c v:[Select Name,Gating_Values__c,Prod_Count__c from Vertical1__c where Name =: showRelease limit 1]){
                dataNovasuite.add(new WrapData(v.Name,v.Gating_Values__c, v.Prod_Count__c));
            }
        }else if(showRelease== 'None'&& s != null) {
            System.debug('in if showRelease1***'+showRelease);
            for(Vertical1__c v: [select Name,Gating_Values__c,Prod_Count__c from Vertical1__c where Verticals__c IN: s order by Name ASC]) {
                dataNovasuite.add(new WrapData(v.Name, v.Gating_Values__c, v.Prod_Count__c));
            }
        }else{
            System.debug('in if showRelease2***'+showRelease);
            for(Vertical1__c v: [select Name,Gating_Values__c,Prod_Count__c from Vertical1__c  where Name =:vs]) {
                dataNovasuite.add(new WrapData(v.Name, v.Gating_Values__c, v.Prod_Count__c));
            }
        }
        system.debug('++++nova'+dataNovasuite);
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
    
    //Wrapper with Opportunity and Contact SelectOptions for the Opp's AccountId
    public  with sharing class ItemWrapper {

        public Release1__c record {get;set;}

        public String contactValue {get;set;}
        
        public List<SelectOption> VerticalOptions {get;set;}

        public ItemWrapper(Release1__c record){
            this.record = record;
            this.VerticalOptions = new List<SelectOption>();
        }

        public Id getParentValue(){
            system.debug(record.name+'hiiiiiii111'+record.Id);
            return record.Id;
        }  
     
        // changing the parent value, will replace the current Vertical options with
        // Verticals from the for the new Release
        public void setParentValue(Id value){           
            system.debug(record.name+'hiiiiiii'+record.Id+'hiiijj'+value);
            if (value != record.Id)
            {
                system.debug(record.name+'hiiiiiii222'+record.Id);
                VerticalOptions = new List<SelectOption>();
                 VerticalOptions.add(new SelectOption(none,none));
                for (Vertical1__c Ver:[select Id,Verticals__c, Name,Verticals__r.name from Vertical1__c where Verticals__c=: value ORDER BY NAME])
                {
                   If(String.isNotBlank(ver.Name)){
                   VerticalOptions.add(new SelectOption(Ver.Name,Ver.Name));
                   }
                    system.debug('Ver.Verticals__c>>>'+Ver.Verticals__c);
                   s.add(Ver.Verticals__c);
                }
            }
            record.Id = value;
            system.debug('sssss'+s);
        }   
    }      
}