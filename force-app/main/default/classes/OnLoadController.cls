public class OnLoadController {

 public String Page {get; set;}

  public String OpenPageURL {get; set;}  

  public void OnLoadController()

  {
   Page ='';
   OpenPageURL = '' ;

  }

   
public PageReference redirect()

  {

      if(Page == 'ChartButton')

      {

           OpenPageURL = '<a href="https://c.ap5.visual.force.com/apex/chart">www.salesforce.com</a>';

}
     return null;
}
  }