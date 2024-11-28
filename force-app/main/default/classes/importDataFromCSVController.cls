public class importDataFromCSVController {
public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
public List<Vertical_sheet__c> Verticallist{get;set;}
  public importDataFromCSVController(){
    csvFileLines = new String[]{};
     Verticallist = New List<Vertical_sheet__c>();
    } 
  public void importCSVFile(){
       try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n');
            
           for(Integer i=1;i<csvFileLines.size();i++){
               Vertical_sheet__c vs = new Vertical_sheet__c();
               string[] csvRecordData = csvFileLines[i].split(',');
               vs.SPRINT__C = csvRecordData[0] ;            
               vs.PRODUCTION_COUNT__C = Decimal.ValueOf(csvRecordData[1]);
               vs.COUNT_W_O_GOVN__C = Decimal.ValueOf(csvRecordData[2]);  
               vs.GATING_VIOLATIONS__C=Decimal.ValueOf(csvRecordData[3]);  
               vs.RED__C=Decimal.ValueOf(csvRecordData[4]);
               vs.YELLOW__C = Decimal.ValueOf(csvRecordData[5]);               
               vs.COVERAGE_W__C=Decimal.ValueOf(csvRecordData[6]);
               vs.COVERAGE_W_O_GOVN__C = Decimal.ValueOf(csvRecordData[7]);
               vs.TOTAL_COMPONENTS__C = Decimal.ValueOf(csvRecordData[8]);               
               vs.Sf_Expected_Coverage__c=Decimal.ValueOf(csvRecordData[9]);
               vs.Sprint_Thresold_Coverage__c=Decimal.ValueOf(csvRecordData[10]);
               vs.Blocker_Issue__c=Decimal.ValueOf(csvRecordData[11]);
               vs.Critical_Issue__c=Decimal.ValueOf(csvRecordData[12]);
               vs.Major_Issue__c=Decimal.ValueOf(csvRecordData[13]);
               vs.Name= csvRecordData[14] ;
               
               Verticallist.add(vs);  
           }
        //insert Verticallist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importing data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
      } 
  }
   public void save() {
   
  try {
       upsert Verticallist;
        }   
  catch(Exception e) {
       ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'Duplicate Data is not allowed, please make sure the data is not Duplicate');
       ApexPages.addMessage(errorMessage);       
     }
  }
}