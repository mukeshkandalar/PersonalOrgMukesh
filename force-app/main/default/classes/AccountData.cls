@RestResource(URLMapping='/AccountDetails/*')
global class AccountData{

@HttpGet
global static Account doGet () {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accid = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE AccountNumber = :accid];
        return result;
        
 }
 @HttpPost
 global static Account doPost(String name,String phone){
 
        Account acc = new Account();
        acc.name= name;
        acc.phone=phone;
        //acc.AccountNumber =AccountNumber;
        insert acc;
        return acc;
    }   
 }