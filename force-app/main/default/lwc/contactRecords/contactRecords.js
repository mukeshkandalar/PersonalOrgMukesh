import { LightningElement, track, wire, api } from 'lwc';
import getContacts from '@salesforce/apex/MyContactListController.getContacts';
import { getRecord } from 'lightning/uiRecordApi';

const columns = [
    { label: 'FirstName', fieldName: 'firstName', type:'text' },
    { label: 'Email', fieldName: 'Email', type: 'Email' }
];

export default class ContactRecords extends LightningElement {
    @api recordId;
    @track data = [];
    @track columns = columns;
    @track tableLoadingState = true;
    @wire(getContacts , { recordId: '$recordId' })
  
    wiredRecordsMethod({ error, data }) {
        if (data) {
            this.data  = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data  = undefined;
        }
        this.tableLoadingState  = false;
    }
    
}