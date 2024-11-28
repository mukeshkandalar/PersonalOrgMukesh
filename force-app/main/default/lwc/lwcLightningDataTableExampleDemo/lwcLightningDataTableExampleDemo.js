import { LightningElement, track } from 'lwc';
import getContacts from '@salesforce/apex/LWCDataTableExample.getContacts';

const columns = [ 
    { label: 'Id', fieldName: 'Id' }, 
    { label: 'First Name', fieldName: 'FirstName' }, 
    { label: 'Last Name', fieldName: 'LastName' }
];

export default class LwcLightningDataTableExampleDemo extends LightningElement {
    @track contacts;
    @track error; 
    @track columns = columns;
   
    handleKeyChange( event ) { 
        const strFirstName = event.target.value; 
        if ( strFirstName ) { 
            getContacts( { strFirstName } )   
            .then(result => { 
                this.contacts = result; 
                console.log('I am here',this.contacts);
               // console.log(JSON.stringify(result, null, '\t'));
   
            }) 
            .catch(error => { 
                this.error = error; 
            }); 
        } else 
        this.contacts = undefined; 
    }
}