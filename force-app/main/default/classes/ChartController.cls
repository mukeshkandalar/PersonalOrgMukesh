/**
@description  
@date 21/02/2018 
@author  Mukesh
@see Chartcontroller
*/
public class ChartController {
    
    public Static Final String URL= '/apex/ImportGovernanceDataPage';  
    public static String showRelease {get; set;}
    public static String ParentValue {get; set;}
    public static String none='Select All Verticals';
    public static String none1='Select All Releases';
    public List<SelectOption> VerticalOptions{get; set;}
    public static final boolean check;
    
    /**
   @ This Construct to add the selected vertical options
   *
   */
    public ChartController(){ 
        //Default
    }  
    public List<SelectOption> getParentOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(none1,none1)); 
        for (Release__c record : [select Id,name from Release__c])
        {
            options.add(new SelectOption(record.Id,record.Name));
        } 
        return options; 
    }   
    public void savedetails(){       
            System.debug('releasedata...................ppppp.'+showRelease);
            
       VerticalOptions= new List<SelectOption>();
        VerticalOptions.add(new SelectOption(none,none)); 
        for (Vertical_sheet__c Ver:[select Sprint__c ,Id,verticals__c from Vertical_sheet__c where verticals__c =:parentvalue])
        {
             VerticalOptions.add(new SelectOption(Ver.Sprint__c,Ver.Sprint__c));
        }  
        system.debug('listssss'+ParentValue); 
     }    
              
      
    /**
    @ This method render the verticals in the graph
    *
    */
    public PageReference renderSec(){ 
        getNovasuiteData();
        return null;
    } 
       /**
    @ This method renders the POR data points in the graph
    *
    */
    public PageReference renderSec1(){
        getReviewData();
        return null; 
    }  
      
       /**
    @ This method renders the Code review data points in the graph
    *
    */
    public PageReference renderSec2(){
        getCoverageData();
        return null; 
    } 
      
       /**
    @ This method renders the Frictionless Code Coverage data points in the graph
    *
    */
    public PageReference renderSec3(){
        getCodeScanData();
        return null; 
    } 
    /**  
    @ This method renders the All verticals data points in the graph
    *
    */  
    public PageReference renderSec4(){
        getNovasuiteData();
        getReviewData();
        getCoverageData();
        getCodeScanData();
        return null; 
    } 
       /**
    @ This method redirects to the another page to import the Governance data
    *
    */  
    public PageReference Move()
    {
        PageReference Page = new PageReference(URL);
        Page.setRedirect(true);
        return Page;
    }
    /**
    @ This method returns the frictionless codecoverage values
    *
    */
    public static List<Wrapper> getCodeScanData() {
        List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 8]){
            vs.add(v.Sprint__c);
        }
        List<Wrapper> dataFt = new List<Wrapper>();
        if(showRelease!=null && showRelease!=none) {
            for(Vertical_Sheet__c v:[Select Sprint__c,Blocker_Issue__c,Critical_Issue__c,Major_Issue__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]) {
            dataFt.add(new Wrapper(v.Sprint__c, v.Blocker_Issue__c, v.Critical_Issue__c,v.Major_Issue__c)); 
            }
        }
        else if(ParentValue!=null && ParentValue!=none1 && ParentValue!=none) {
             for(Vertical_Sheet__c v:[Select Sprint__c,Blocker_Issue__c,Critical_Issue__c,Major_Issue__c from Vertical_Sheet__c where Verticals__c=:ParentValue]){
                dataFt.add(new Wrapper(v.Sprint__c, v.Blocker_Issue__c, v.Critical_Issue__c,v.Major_Issue__c));
             }
        }
        else {   
            for(Vertical_Sheet__c v:[Select Sprint__c,Blocker_Issue__c,Critical_Issue__c,Major_Issue__c from Vertical_Sheet__c  where Sprint__c IN : vs order by Sprint__c ASC]){
                dataFt.add(new Wrapper(v.Sprint__c,v.Blocker_Issue__c, v.Critical_Issue__c,v.Major_Issue__c)); 
            }
        }
        return dataFt ;
    }
 /**
    @ This method returns the frictionless codecoverage values
    *
    */
   public static List<Data> getCoverageData() {

            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 6]){
            vs.add(v.Sprint__c);
            }

            List<Data> dataFt = new List<Data>();
        if(showRelease!=null && showRelease!=none) {
            for(Vertical_Sheet__c v:[Select Sprint__c,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]) {
                dataFt.add(new Data(v.Sprint__c, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c)); 
            }
        }
        else if(ParentValue!=null && ParentValue!=none1 && ParentValue!=none) {
             for(Vertical_Sheet__c v:[Select Sprint__c,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c where Verticals__c=:ParentValue]){
                dataFt.add(new Data(v.Sprint__c, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c));
            }
        }
        else {   
            for(Vertical_Sheet__c v:[Select Sprint__c,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c  where Sprint__c IN : vs order by Sprint__c ASC]){
                dataFt.add(new Data(v.Sprint__c, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c)); 
            }
        }
        //System.debug('dataFT '+dataFt);
        return dataFt ;
    } 
     /**
    @ This method returns the Code Review values
    *
    */
    public  List<WrapperData> getReviewData() {
    
            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 6]){
            vs.add(v.Sprint__c);
            }
            List<WrapperData> dataReview = new List<WrapperData>();
        if(showRelease!=null && showRelease!=none) {
            for(Vertical_Sheet__c v: [Select Sprint__c,Red__c,Yellow__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]) {
                dataReview.add(new WrapperData(v.Sprint__c, v.Red__c, v.Yellow__c));
            }
        }
        else if(ParentValue!=null && ParentValue!=none1 && ParentValue!=none) {
             for(Vertical_Sheet__c v:[Select Sprint__c,Red__c,Yellow__c  from Vertical_Sheet__c where Verticals__c=:ParentValue]){
                dataReview.add(new WrapperData(v.Sprint__c, v.Red__c, v.Yellow__c));
            }
        }
        else {
            for(Vertical_Sheet__c v: [Select Sprint__c,Red__c,Yellow__c from Vertical_Sheet__c  where Sprint__c IN : vs order by Sprint__c ASC]) {
                dataReview.add(new WrapperData(v.Sprint__c, v.Red__c, v.Yellow__c));
            }
        }       
        return dataReview;
    }

     /**
    @ This method returns the Novasuite Data points
    *
    */
   public  List<WrapData> getNovasuiteData() {

            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c,Verticals__c from Vertical_sheet__c order by Sprint__c DESC limit 6]){
            vs.add(v.Sprint__c);
            }
        List<WrapData> dataNovasuite = new List<WrapData>();
        if(showRelease!=null && showRelease!=none) {
           for(Vertical_Sheet__c v:[Select Sprint__c,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c from Vertical_Sheet__c where Sprint__c =:showRelease]){
             dataNovasuite.add(new WrapData(v.Sprint__c, v.Production_Count__c, v.Count_w_o_Govn__c,v.Gating_violations__c)); 
           }
       } 
        else if(ParentValue!=null && ParentValue!=none1 && ParentValue!=none) {
             for(Vertical_Sheet__c v:[Select Sprint__c,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c from Vertical_Sheet__c where Verticals__c=:ParentValue]){
                dataNovasuite.add(new WrapData(v.Sprint__c, v.Production_Count__c, v.Count_w_o_Govn__c,v.Gating_violations__c));
            }
        }
        else{
         //System.debug('in if showRelease***'+showRelease);
            for(Vertical_Sheet__c v: [select Verticals__c, Sprint__c,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c  from   Vertical_Sheet__c where (Sprint__c IN : vs OR Verticals__c =: ParentValue) order by Sprint__c ASC]) {
                dataNovasuite.add(new WrapData(v.Sprint__c, v.Production_Count__c, v.Count_w_o_Govn__c,v.Gating_violations__c)); 
            }
       }
        return dataNovasuite ;
   }
    // Wrapper class
    /**
    @ This is wrapper class which defines the data points in the verticals
    *
    */
   public with sharing class Data {
        public String name { get; set; }
        public Decimal data1 { get; set; }
        public Decimal data2 { get; set; }
        public Decimal data3 { get; set; }
        public Decimal data4 { get; set; }
        public Decimal data5 { get; set; }
        
        // Wrapper class
        /**
        @ This is wrapper Constructor  which defines the data points in the verticals
        * 
        */
        public Data(String name, Decimal data1, Decimal data2,Decimal data3,Decimal data4,Decimal data5) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;  
            this.data4 = data4;
            this.data5 = data5;
        }
    }
    // Wrapper class
    /**
    @ This is wrapper class which defines the data points in the verticals
    *
    */
    public with sharing class WrapperData {
        Public  String name { get; set; }
        Public Decimal A { get; set; }
        Public Decimal B { get; set; }
     // Wrapper class
        /**
        @ This is wrapper Constructor  which defines the data points in the verticals
        * 
        */    
    public WrapperData(String name, Decimal A, Decimal B) {
        this.name = name;
        this.A = A;
        this.B= B;
       }   
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
       Public Decimal c { get; set; }
    // Wrapper class
        /**
        @ This is wrapper Constructor  which defines the data points in the verticals
        * 
        */   
    public WrapData(String name, Decimal a, Decimal b, Decimal c) {
       this.name = name;
       this.a = a;
       this.b = b;
       this.c = c;
       }
   } 
   public with sharing class Wrapper {
       Public  String name { get; set; }
       Public Decimal a { get; set; }
       Public Decimal b { get; set; }
       Public Decimal c { get; set; }
    // Wrapper class
        /**
        @ This is wrapper Constructor  which defines the data points in the verticals
        * 
        */   
    public Wrapper(String name, Decimal a, Decimal b, Decimal c) {
       this.name = name;
       this.a = a;
       this.b = b;
       this.c = c;
       }
   } 
    
}