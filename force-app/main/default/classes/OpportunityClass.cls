public with sharing class OpportunityClass {
    @AuraEnabled  
    public static List<Opportunity> getOpportunities(){
    
        List<Opportunity> opp =[select id, name,CloseDate from opportunity];
        return opp;
        
    }
}