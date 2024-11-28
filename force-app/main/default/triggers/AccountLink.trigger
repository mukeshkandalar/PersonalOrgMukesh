trigger AccountLink on Account (before insert, before update) {
if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)){
for(Account a : trigger.new){
    a.Link_pro__c= '<a href=/'+'apex/TwilioPage '+'>rec</a>';
//a.link__c ='https://kandala9-dev-ed--c.ap5.visual.force.com/apex/TwilioPage' ;
}
}
}