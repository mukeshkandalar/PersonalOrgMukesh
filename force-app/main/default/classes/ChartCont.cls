/**
@description  
@date 21/02/2018 
@author  Mukesh
@see Chartcontroller
*/
public class ChartCont {
    
    public static String  showRelease {get; set;}
    public static String  showSelected {get; set;}
    public static boolean showReview {get; set;}
    public static boolean showNovasuite {get; set;}
    public Static Final String none = 'None';   
    List <String> releasedata= new List<String>();
    
    
            
       public List<SelectOption> getgraphAdvantage(){
              
            List<SelectOption> slistnew = new List<SelectOption>();
              slistnew.add(new SelectOption(none,none));      

            for(vertical_sheet__c v :[Select  Red__c,Yellow__c, Vertical__c,Coverage_w_o_Govn__c,Coverage_w__c,name,Total_Components__c from  Vertical_Sheet__c where name like '%R']){                                               
                If(String.isNotBlank(v.name)){
                    slistnew.add(new SelectOption(v.name,v.name));
                    
                }
            
            }
            return slistnew;                                            
    } 
              
   /**
   @ This Construct to add the selected vertical options
   *
   */
    public ChartCont(){ 
        //Default
       /*showReview = false;
        showNovasuite= false;
        showSelected ='';*/
    }     
    /**
    @ This method render the verticals in the graph
    *
    */
    public PageReference renderSec(){ 
   // String input = Apexpages.currentPage().getParameters().get('type'); 
     //System.debug('input++'+input);
        getNovasuiteData();
         getPorData();
         getReviewData();
          getFtData();
        return null;
    } 
       public PageReference renderSec1(){
        getPorData();
        return null; 
    }  
      public PageReference renderSec2(){
        getReviewData();
        return null; 
    } 
      public PageReference renderSec3(){
        getFtData();
        return null; 
    } 
       public PageReference renderSec4(){
        getFTReviewData();
        return null; 
    } 
     public PageReference renderSec5(){
        getNovasuiteData();
        getReviewData();
        getFtData();
        getPorData();

        return null; 
    } 
    public List<String> getreleasedata() {

         //If multiselect is false, countries must be of type String
         System.debug('releasedata'+releasedata);

         return releasedata;
         
    }
    public void setreleasedata(List<String> releasedata) {

         //If multiselect is false, countries must be of type String

         this.releasedata = releasedata;
    }
    public void savedetails(){
        //String showRelease = Apexpages.currentPage().getParameters().get('showrelease');
       
        System.debug('releasedata...................ppppp.'+showRelease);
    }    
    
    /**
    @ This method returns the frictionless codecoverage values
    *
    */
    public static List<Data> getFtData() {
        List<Data> dataFt = new List<Data>();
       if(showRelease!=null && showRelease!=none) {
        for(Vertical_Sheet__c v:[Select name,FT_Coverage_w_o_Govn__c,FT_Coverage_w__c,FT_Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c where name =:showRelease limit 1]) {
            dataFt.add(new Data(v.name, v.FT_Coverage_w_o_Govn__c, v.FT_Coverage_w__c,v.FT_Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c)); 
        }
        }
        else {   
        for(Vertical_Sheet__c v:[Select name,FT_Coverage_w_o_Govn__c,FT_Coverage_w__c,FT_Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c   order by name  desc  limit 6]){
            dataFt.add(new Data(v.name, v.FT_Coverage_w_o_Govn__c, v.FT_Coverage_w__c,v.FT_Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c)); 
        }
        }
        System.debug('dataFT '+dataFt);
        return dataFt ;
    } 
    /**
    @ This method returns the POR codecoverage values
    *
    */
    public List<Data> getPorData() {
        List<Data> dataPOR = new List<Data>();
          System.debug('showRelease++'+showRelease);
        if(showRelease!=null && showRelease!=none) {
      
          for(Vertical_Sheet__c v:[Select name,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c where name =:showRelease limit 1]){
              
            dataPOR.add(new Data(v.name, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c));
        
        }
        }
        else {
        for(Vertical_Sheet__c v:[Select name,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sprint_Thresold_Coverage__c,Sf_Expected_Coverage__c from Vertical_Sheet__c  order by name desc limit 6]){
            dataPOR.add(new Data(v.name, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c));
        }
        }
        return dataPOR ;
    }
    public  List<WrapperData> getReviewData() {
         List<WrapperData> dataReview = new List<WrapperData>();
         savedetails();
        if(showRelease!=null && showRelease!=none) {
        for(Vertical_Sheet__c v: [Select name,Red__c,Yellow__c from Vertical_Sheet__c where name =:showRelease limit 1]) {
            dataReview.add(new WrapperData(v.name, v.Red__c, v.Yellow__c));
        }
        }
        else {
        for(Vertical_Sheet__c v: [Select name,Red__c,Yellow__c from Vertical_Sheet__c  order by name desc limit 6]) {
            dataReview.add(new WrapperData(v.name, v.Red__c, v.Yellow__c));
        }
        }       
        return dataReview;
    }
    public  List<WrapperData> getFTReviewData() {
        List<WrapperData> dataFTReview = new List<WrapperData>();
         if(showRelease!=null && showRelease!=none) {
         for(Vertical_Sheet__c v:[Select name,FT_Red__c,FT_Yellow__c from Vertical_Sheet__c where name =:showRelease limit 1]){
         dataFTReview.add(new WrapperData(v.name, v.FT_Red__c, v.FT_Yellow__c));
         }
    }    
        else {
        for(Vertical_Sheet__c v: [Select name,FT_Red__c,FT_Yellow__c from Vertical_Sheet__c  order by name desc limit 6]) {
            dataFTReview.add(new WrapperData(v.name, v.FT_Red__c, v.FT_Yellow__c));
        }
    }   
        return dataFTReview;
  }
    public  List<WrapData> getNovasuiteData() {
        List<WrapData> dataNovasuite = new List<WrapData>();
        System.debug('showRelease++'+showRelease);
        savedetails();
        System.debug('showRelease+++'+showRelease);
        if(showRelease!=null && showRelease!=none) {
      System.debug('in if showRelease+++'+showRelease);
          for(Vertical_Sheet__c v:[Select name,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c from Vertical_Sheet__c where name =:showRelease limit 1]){
              
            dataNovasuite.add(new WrapData(v.name, v.Production_Count__c, v.Count_w_o_Govn__c,v.Gating_violations__c)); 
        }
    }
        
        else{
         System.debug('in if showRelease***'+showRelease);
        for(Vertical_Sheet__c v: [select name,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c  from   Vertical_Sheet__c where name like '%R' Order by name desc limit 6]) {
            dataNovasuite.add(new WrapData(v.name, v.Production_Count__c, v.Count_w_o_Govn__c,v.Gating_violations__c)); 
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
    public with sharing class WrapperData {
        Public  String name { get; set; }
        Public Decimal A { get; set; }
        Public Decimal B { get; set; }
        
    public WrapperData(String name, Decimal A, Decimal B) {
            this.name = name;
            this.A = A;
            this.B= B;
       }   
    }
    public with sharing class WrapData {
       Public  String name { get; set; }
       Public Decimal a { get; set; }
       Public Decimal b { get; set; }
       Public Decimal c { get; set; }
       
    public WrapData(String name, Decimal a, Decimal b, Decimal c) {
       this.name = name;
       this.a = a;
       this.b = b;
       this.c = c;
     }
    }   
}