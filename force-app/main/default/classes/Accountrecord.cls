public class Accountrecord {
    
    public Accountrecord() {
        objectId = ApexPages.currentPage().getParameters().get('id');
        showInActive = false;
        system.debug(ApexPages.currentPage().getParameters().get('showInactive'));
        if(ApexPages.currentPage().getParameters().get('showInactive') != null){
            if(ApexPages.currentPage().getParameters().get('showInactive') == '1') showInactive = true;
        }
    }

    public Id objectId {get;set;}
    public User theApprovalUser {get;set;}
    public Boolean showInActive {get;set;}

    public List<approvalProcess> applicableProcesses {
        get{
            if(applicableProcesses == null) applicableProcesses = new List<approvalProcess>();
            return applicableProcesses;
        }
        set;
    }

    public class ApprovalProcess{
        public Integer processNumber {get;set;}
        public String processName {get;set;}
        public String processDescription {get;set;}
        public List<approvalStep> approvalSteps {
            get{
                if(approvalSteps == null) approvalSteps = new List<ApprovalStep>();
                return approvalSteps;
            }
            set;
        }
    }
    public class ApprovalStep{
        public Integer stepNumber {get;set;}
        public String approver {get;set;}
    }

    public void runPreview(){
        system.savepoint sp1 = Database.setSavepoint();

        String theObjectType = objectId.getSObjectType().getDescribe().getName();
        theApprovalUser = [SELECT Id FROM User WHERE Alias='mkand'];

        Set<String> statesToShow = new Set<String>{'Active'};
        if(showInActive) {
            statesToShow.add('Inactive');
            statesToShow.add('Obsolete');
        }
        system.debug(statesToShow);

        // fetch all approval processes for this object
        List<ProcessDefinition> processesForThisObject = [Select Id, Name, Developername,Type, Description 
                                                          From ProcessDefinition 
                                                          Where 
                                                            Type = 'Approval'
                                                            AND State in :statesToShow
                                                            AND TableEnumOrId = :theObjectType ];

        for (ProcessDefinition pd : processesForThisObject){
            system.debug(pd.Name);
            try{
                ApprovalProcess ap = createApproval(pd.Id,pd.Developername);
                ap.processNumber = applicableProcesses.size() + 1;
                ap.processName = pd.Name;
                ap.processDescription = pd.Description;
                applicableProcesses.add(ap);
                system.debug(applicableProcesses);

            } catch (Exception e)
            {
                system.debug(pd.Name+' This process is not applicable.');
                // process not applicable to this record. No problemo.   
            }
        }
        Database.rollback(sp1);
    }

    public ApprovalProcess createApproval(Id processId, String procesName){

        // Create an approval request for the account
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(objectId);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(theApprovalUser.Id); 

        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId(procesName);
        // for testing, skip entry criteria to make sure at least 1 process is ran
        if(Test.isRunningTest()) req1.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);

        system.debug(procesName+ ' START');

        // create the data for viewing
        ApprovalProcess ap = new ApprovalProcess();

        // Verify the result
        System.debug(result.getInstanceStatus());

        goThroughSteps(result,ap.approvalSteps);

        system.debug(procesName+ ' END');

        return ap;
    }    


    public void goThroughSteps(Approval.ProcessResult result,List<ApprovalStep> approvalSteps){
        // First, get the ID of the newly created item
        List<Id> newWorkItemIds = result.getNewWorkitemIds();

        ProcessInstanceWorkitem piw = [Select Id, ActorId, Actor.Name,ProcessInstanceId From ProcessInstanceWorkitem Where Id = :newWorkItemIds[0] ];
        system.debug(piw.actorId + ' '+piw.actor.Name);

        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approve');

        // Use the ID from the newly created item to specify the item to be worked
        req2.setWorkitemId(newWorkItemIds.get(0));

        // Submit the request for approval
        Approval.ProcessResult result2 =  Approval.process(req2);

        // Verify the results
        System.debug(result2.getInstanceStatus());

        ApprovalStep ap = new ApprovalStep();
        ap.stepNumber = approvalSteps.size() + 1;
        ap.approver = piw.actor.Name;
        approvalSteps.add(ap);

        if(!result2.getNewWorkitemIds().isEmpty()){
            goThroughSteps(result2,approvalSteps);
        }

    }

}