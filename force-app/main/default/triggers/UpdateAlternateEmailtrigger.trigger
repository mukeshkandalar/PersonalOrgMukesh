Trigger UpdateAlternateEmailtrigger on Contact(After insert,After update) {
	
	UpdateAlternateEmail.altEmailMethod(Trigger.newMAP,Trigger.oldMap);
	
}