trigger AvoidSoqlDmlInsideTrigger on Account (before insert) {
    if(trigger.isInsert && trigger.isBefore){
    AvoidDmlInTrigger goodPrac = new AvoidDmlInTrigger(); 
         goodPrac.BestPractise(Trigger.new);
   }

}