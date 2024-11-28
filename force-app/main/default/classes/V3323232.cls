public class V3323232 {
public static String Generate_PDF = 'English';

 public string labelGenerate_PDF { get{return Generate_PDF;}}
 public PageReference generatePdf()
      {
          PageReference pageref;
          pageref = new PageReference('/apex/pdfPAge1');
          return pageref.setRedirect(false);
      }
      public PageReference generatePdf1()
      {
          PageReference pageref;
          pageref = new PageReference('/apex/pdfPAge2');
          return pageref.setRedirect(true);
      }
      }