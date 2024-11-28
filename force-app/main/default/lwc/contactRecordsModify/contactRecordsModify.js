import { LightningElement, track } from 'lwc';
import getContactList from '@salesforce/apex/AccContactListClass.getContactList';
import { getRecord } from 'lightning/uiRecordApi';

const columns = [
    { label: 'FirstName', fieldName: 'firstName' },
    { label: 'Email', fieldName: 'Email', type: 'Email' }
];
export default class ContactRecordsModify extends LightningElement {
    
    @track accounts=[];  
    @track error;  
    @track columns = columns;
    @track tableLoadingState = true;
    @track recId;

    handleSuccess(event) {
        this.recordId = event.detail.id;
    }
  
    handleKeyChange() {  
        getContactList({recordId : this.recordId})   
            .then(data => {  
  
                this.accounts = data;  
               console.log('Answer',this.accounts);
            })  
            .catch(error => {  
  
             //   this.error = error;  
              console.log('Error',error);
            });  
        }
    }