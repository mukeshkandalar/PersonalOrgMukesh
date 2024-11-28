public with sharing class RetrieveContact {
    @AuraEnabled(cacheable=true)
    public static  list<contact> contactmethodname(){
      list<contact> con=[select id,FirstName,LastName,Phone from contact];
      return con;
  }
  @AuraEnabled
  public static list<contact> methodname(id[] contactid){
    list<contact> con=new list<contact>();
     list<contact> conlist=new list<contact>();
          con=[select id,name,Phone from contact where id in:contactid];
          for(contact cont:con){

                  cont.Phone='9000688925';
                  conlist.add(cont); 
              
          }
          update conlist;
          system.debug('contact update----'+conlist);
          return conlist;
      }

    
}