public with sharing class ApproveRejectAllRecs 
{
    public List<ProcessInstance> prosIns{get;set;}
    public boolean rendPgeBlock  {get;set;}
    public String pgMsg{get;set;}
    public string comments{get;set;}
    public List<ProcessInstance> selProsInss{get;set;}
    
    private List<Id> prosInsIds = new List<Id>();    
    private List<ProcessInstanceWorkitem>  prosInsWrkItms = new List<ProcessInstanceWorkitem>();    
    private List<PendingAppRecs>  selVals = new List<PendingAppRecs>();        
    
    public ApproveRejectAllRecs()
    {
        prosIns = new List<ProcessInstance>();
        selProsInss = new List<ProcessInstance>();
        prosIns = [SELECT Id, Status, TargetObject.Id, TargetObject.Name, TargetObject.Type, CreatedDate FROM ProcessInstance where TargetObject.Id='0017F00001qaC1q'];
        for(ProcessInstance prIns: prosIns)
        {
            prosInsIds.add(prIns.Id);
        }
        prosInsWrkItms =  [SELECT Id, ProcessInstance.Id, ProcessInstance.Status, Actor.Id, Actor.Name, Actor.Type FROM ProcessInstanceWorkitem where ProcessInstance.Id in : prosInsIds];
    }
    public pagereference appPendingRecs()
    {
        if(!(prosIns.size()>0))
        {
            pgMsg = 'There are no records submitted for approval.';
            rendPgeBlock  = false;
        }
        else
            rendPgeBlock  = true;
        return null;
    }
    
    public void appRej(String appRej)
    {
        for(PendingAppRecs pendApp: getProsInsts()) 
        {
            if(pendApp.selected == true) 
            {
                selProsInss.add(pendApp.proInstce);
            }
        }
        
        for(ProcessInstance pi : selProsInss)
        {
            for(ProcessInstanceWorkitem  pwi  : prosInsWrkItms)
            {
                if(pi.Id == pwi.ProcessInstance.Id)
                {
                    Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                    req.setComments(Comments);
                    req.setAction(appRej);
                    if(appRej == 'Approve')
                        req.setNextApproverIds(new Id[] {pwi.Actor.id});        
                    List<ProcessInstanceWorkitem> procWrkItms = new List<ProcessInstanceWorkitem>();
                    procWrkItms  = [Select Id from ProcessInstanceWorkitem where ProcessInstance.Id =: pi.Id];                    

                    if((!(procWrkItms.isEmpty()) && procWrkItms[0].Id!=null))
                    {
                        req.setWorkitemId(procWrkItms[0].Id);        
                                            
                        // Submit the request for approval    
                        Approval.ProcessResult result2 =  Approval.process(req);
                    }
                }
            }
        }
    }
    public pagereference approveAll()
    {
        appRej('Approve');
        Pagereference pg = new pagereference('/apex/ApproveRejectAllRecs');
        pg.setredirect(true);
        return pg;
    }

    public pagereference rejectAll()
    {
        appRej('Reject');
        Pagereference pg = new pagereference('/apex/ApproveRejectAllRecs');
        pg.setredirect(true);
        return pg;
    }

    public pagereference cancel()
    {
        return null;
    }
    public pagereference selRecs()
    {
        for(PendingAppRecs pendApp: getProsInsts()) 
        {
            if(pendApp.selected == true) 
            {
                selProsInss.add(pendApp.proInstce);
            }
        }        
        return null;
    }
    public List<PendingAppRecs> proInstsLst{get; set;}
    public List<PendingAppRecs> getProsInsts() 
    {
        if(proInstsLst== null) 
        {
            proInstsLst = new List<PendingAppRecs>();
            for(ProcessInstance p : [SELECT Id, Status, TargetObject.Id, TargetObject.Name, TargetObject.Type, CreatedDate FROM ProcessInstance where Status='Pending']) 
            {
                proInstsLst.add(new PendingAppRecs(p));
            }
        }
        return proInstsLst;
    }
    public class PendingAppRecs
    {
        public ProcessInstance  proInstce{get; set;}
        public Boolean selected {get; set;}
        public PendingAppRecs(ProcessInstance  p) 
        {
        proInstce = p;
        selected = false;
        }
    }
}