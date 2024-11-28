import { LightningElement, track } from 'lwc';
import searchImperativeContactList from '@salesforce/apex/Lwc_ContractNewImper.searchImperativeContactList';

const columns = [
    { label: 'FirstName', fieldName: 'firstName', type:'text' },
    { label: 'Email', fieldName: 'Email', type: 'Email' }
];
export default class LwcContractNewImper extends LightningElement {
    @track contacts=[];
    @track error;
    @track columns=columns;
    @track tableLoadingState = true;
 
    searchContact(event){        
        this.searchKey = event.target.value;        
    }
 
    doSearch() {
        searchImperativeContactList({ accountName: this.searchKey })
            .then(result => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
            this.tableLoadingState  = false;

    }
}