import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import fetchWrapperData from '@salesforce/apex/Modal_LWC_controller.fetchWrapperData';

const columns = [
  { label: 'FirstName', fieldName: 'FirstName', type: 'text' },
  { label: 'Email', fieldName: 'Email', type: 'email' },
  { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class Modal_LWC extends LightningElement {
  @track columns = columns;  
  @api nameFirst; 
  @api firstName; 
  @track contactList=[];
  @track rowOffset = 0;
  @track error;   
  @track btnLabel = '';   
  @track modalHeader = '';
  @track isContact = false;
  @track modalClass = 'slds-modal ';
  @track modalBackdropClass = 'slds-backdrop ';
  @api recordId;  //Stores recordId
  @api objectApiName;   //Stores the current object API Name

  connectedCallback() {   //doInit() function, Dynamically changing the modal header and button label as per sObject, and also assigning the isContact property as per sObject
      this.isContact = false;
      this.modalHeader = 'Related Contacts';
      this.btnLabel = 'See Related Contacts';
    
  }

  //Adds the classes that shows the Modal and does server calls to show the required data
  openModal() {
    this.modalClass = 'slds-modal slds-fade-in-open';
    this.modalBackdropClass = 'slds-backdrop slds-backdrop_open';
    fetchWrapperData({sfNameWr : this.firstName})
      .then(result => {    //Returns the wrapper 

          this.contactList = result.contactList;
         // this.isContact = false;
      })
      .catch(error => {
        const event = new ShowToastEvent({
          title: 'Error Occured',
          message: 'Error: '+error.body.message,
          variant: 'error'
         });
        this.dispatchEvent(event);    //To show an error Taost if error occurred while the APEX call
        });
  }

  //Removes the classes that hides the Modal
  closeModal() {
    this.modalClass = 'slds-modal ';
    this.modalBackdropClass = 'slds-backdrop ';
  }

  handleAccountName(event) {
    this.nameFirst = event.detail.value;
}
  doSearch() {
  
    fetchWrapperData({sfNameWr : this.nameFirst})
    .then(result => {    //Returns the wrapper 
        console.log('result+',this.nameFirst);
        this.contactList = result;
    })
    .catch(error => {
 
            this.error = error; 

        }); 
  }
}