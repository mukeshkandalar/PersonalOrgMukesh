public class AvoidHarcodedUrls {
 Public Static final String  URL = '/apex';
    Public Pagereference BestPractise(){
        List<Account> acc= new List<Account>();
        String Id= ApexPages.CurrentPAge().getParameters().get('Id');
        if(!String.isblank(Id)){
            	PageReference reference = new PageReference(URL+Id); //Good : use by Constant  to Avoid HardCoded URls
        
            return reference;
        }
        return null;
    }
}