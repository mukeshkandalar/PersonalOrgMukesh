trigger UpdateContactEmail on Account(after insert,after update) {
    
    UpdateContactEmailClass.UpdateContactEmailMethod();
   
    }