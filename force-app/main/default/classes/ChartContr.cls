/**
@description  
@date 21/02/2018 
@author  Mukesh
@see Chartcontroller
*/
public class ChartContr {
    
    public static String  showRelease {get; set;}
    public Static Final String none = 'None'; 
    public Static Final String URL= '/apex/ImportGovernanceDataPage';  
    List <String> releasedata= new List<String>();
    
        /**
        @ method Shows Every Sprint graphs by selecting the Particular sprint 
        *
        */
        public List<SelectOption> getgraphAdvantage(){
              
            List<SelectOption> slistnew = new List<SelectOption>();
              slistnew.add(new SelectOption(none,none));      

            for(vertical_sheet__c v :[Select  Red__c,Yellow__c, Vertical__c,Coverage_w_o_Govn__c,Coverage_w__c,Sprint__c,Total_Components__c from  Vertical_Sheet__c]){                                               
                If(String.isNotBlank(v.Sprint__c)){
                    slistnew.add(new SelectOption(v.Sprint__c,v.Sprint__c));
                    
                }
            
            }
            return slistnew;                                            
    } 
              
   /**
   @ This Construct to add the selected vertical options
   *
   */
    public ChartContr(){ 
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
     getNovasuiteData();
        return null;
    } 
       /**
    @ This method renders the POR data points in the graph
    *
    */
       public PageReference renderSec1(){
        getPorData();
        return null; 
    }  
      
       /**
    @ This method renders the Code review data points in the graph
    *
    */
      public PageReference renderSec2(){
        getReviewData();
        return null; 
    } 
      
       /**
    @ This method renders the Frictionless Code Coverage data points in the graph
    *
    */
      public PageReference renderSec3(){
        getFtData();
        return null; 
    } 
      
       /**
    @ This method renders the Frictionless Code Review data points in the graph
    *
    */  
       public PageReference renderSec4(){
        getFTReviewData();
        return null; 
    } 
        /**
    @ This method renders the All verticals data points in the graph
    *
    */  
     public PageReference renderSec5(){
        getNovasuiteData();
        getReviewData();
        getFtData();
        getPorData();

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
   @ This method returns the Every Release from showRelease string method
   *
   */
    public void savedetails(){
       
        //System.debug('releasedata...................ppppp.'+showRelease);
    }   
    
    /**
    @ This method returns the frictionless codecoverage values
    *
    */
    public static List<Data> getFtData() {

            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 5]){
            vs.add(v.Sprint__c);
            }

        List<Data> dataFt = new List<Data>();
       if(showRelease!=null && showRelease!=none) {
        for(Vertical_Sheet__c v:[Select Sprint__c,FT_Coverage_w_o_Govn__c,FT_Coverage_w__c,FT_Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]) {
            dataFt.add(new Data(v.Sprint__c, v.FT_Coverage_w_o_Govn__c, v.FT_Coverage_w__c,v.FT_Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c)); 
        }
        }
        else {   
        for(Vertical_Sheet__c v:[Select Sprint__c,FT_Coverage_w_o_Govn__c,FT_Coverage_w__c,FT_Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c  where Sprint__c IN : vs order by Sprint__c ASC]){
            dataFt.add(new Data(v.Sprint__c, v.FT_Coverage_w_o_Govn__c, v.FT_Coverage_w__c,v.FT_Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c)); 
        }
        }
        //System.debug('dataFT '+dataFt);
        return dataFt ;
    } 
    /**
    @ This method returns the POR codecoverage values
    *
    */
    public List<Data> getPorData() {
    
            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 5]){
            vs.add(v.Sprint__c);
            }

        List<Data> dataPOR = new List<Data>();
         // System.debug('showRelease++'+showRelease);
        if(showRelease!=null && showRelease!=none) {
      
          for(Vertical_Sheet__c v:[Select Sprint__c,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sf_Expected_Coverage__c,Sprint_Thresold_Coverage__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]){
              
            dataPOR.add(new Data(v.Sprint__c, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c));
        
        }
        }
        else {
        for(Vertical_Sheet__c v:[Select Sprint__c,Coverage_w_o_Govn__c,Coverage_w__c,Total_Components__c,Sprint_Thresold_Coverage__c,Sf_Expected_Coverage__c from Vertical_Sheet__c  where Sprint__c IN : vs order by Sprint__c ASC]){
            dataPOR.add(new Data(v.Sprint__c, v.Coverage_w_o_Govn__c, v.Coverage_w__c,v.Total_Components__c,v.Sf_Expected_Coverage__c,v.Sprint_Thresold_Coverage__c));
        }
        }
        return dataPOR ;
    }
     /**
    @ This method returns the Code Review values
    *
    */
    public  List<WrapperData> getReviewData() {
    
            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 5]){
            vs.add(v.Sprint__c);
            }
         List<WrapperData> dataReview = new List<WrapperData>();
         savedetails();
        if(showRelease!=null && showRelease!=none) {
        for(Vertical_Sheet__c v: [Select Sprint__c,Red__c,Yellow__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]) {
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
    @ This method returns the Frictionless Code Review data points
    *
    */
    public  List<WrapperData> getFTReviewData() {
             List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 5]){
            vs.add(v.Sprint__c);
            }
        List<WrapperData> dataFTReview = new List<WrapperData>();
         if(showRelease!=null && showRelease!=none) {
         for(Vertical_Sheet__c v:[Select Sprint__c,FT_Red__c,FT_Yellow__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]){
         dataFTReview.add(new WrapperData(v.Sprint__c, v.FT_Red__c, v.FT_Yellow__c));
         }
    }    
        else {
        for(Vertical_Sheet__c v: [Select Sprint__c,FT_Red__c,FT_Yellow__c from Vertical_Sheet__c  where Sprint__c IN : vs order by Sprint__c ASC]) {
            dataFTReview.add(new WrapperData(v.Sprint__c, v.FT_Red__c, v.FT_Yellow__c));
        }
    }   
        return dataFTReview;
  }
     /**
    @ This method returns the Novasuite Data points
    *
    */
   public  List<WrapData> getNovasuiteData() {

            List<String> vs = new List<String>();
            for(Vertical_sheet__c v : [Select Sprint__c from Vertical_sheet__c order by Sprint__c DESC limit 5]){
            vs.add(v.Sprint__c);
            }
        List<WrapData> dataNovasuite = new List<WrapData>();
       // System.debug('showRelease++'+showRelease);
        savedetails();
        if(showRelease!=null && showRelease!=none) {
      //System.debug('in if showRelease+++'+showRelease);
          for(Vertical_Sheet__c v:[Select Sprint__c,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c from Vertical_Sheet__c where Sprint__c =:showRelease limit 1]){
              
            dataNovasuite.add(new WrapData(v.Sprint__c, v.Production_Count__c, v.Count_w_o_Govn__c,v.Gating_violations__c)); 
        }
    }
        
        else{
         //System.debug('in if showRelease***'+showRelease);
        for(Vertical_Sheet__c v: [select Sprint__c,Production_Count__c,Count_w_o_Govn__c,Gating_violations__c  from   Vertical_Sheet__c where Sprint__c IN : vs order by Sprint__c ASC]) {
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
}