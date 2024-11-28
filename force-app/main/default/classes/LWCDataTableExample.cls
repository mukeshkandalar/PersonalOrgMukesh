public with sharing class LWCDataTableExample {
    @AuraEnabled(Cacheable=true)
    public static List <Contact> getContacts(String strFirstName) {
        String strLastNameLike = '%'+strFirstName+'%';
        List<Contact> contList = [SELECT Id,FirstName,LastName,Account.Name
                                   FROM Contact
                                   Where FirstName like :strLastNameLike
                                   LIMIT 10];
        return contList;
    }   

}