public class pdfclass {

 public PageReference generatePdf()
      {
          PageReference pageref;
          pageref = new PageReference('/apex/pdfPAge2');
          return pageref.setRedirect(false);
      }
   }