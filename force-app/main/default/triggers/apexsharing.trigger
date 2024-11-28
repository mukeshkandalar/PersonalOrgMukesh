Trigger apexsharing on case (after insert, after update) {

List<CaseShare> accShares = new List<CaseShare>();

for(Case cc : trigger.new)

{

//if it is private only share with sharing manager



CaseShare accShare = new  CaseShare();
accShare.Caseid = cc.Id;
accShare.UserOrGroupId = '0057F000000qseA';
accShare.CaseAccessLevel = 'Read';

accShares.add(accShare);



}

if(! accShares.isEmpty())

   { 
 

    Database.SaveResult[] tripShareInsertResult = Database.insert(accShares,false);

 

   }

}