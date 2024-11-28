import { LightningElement,track } from 'lwc';
import Accountmethodname from '@salesforce/apex/LwcRetriveAccountImp.Accountmethodname';
const actions = [{
    label : 'Edit',
    name:'Edit'}];
    
const columns= [
    
        
        {
        label : 'Action',
        type : 'action',
        typeAttributes : {
        rowActions : actions,
        menuAlignment : 'Left'
        }
        },
    {
    
        label : 'ID',
       fieldName : 'id'
    },
    {
        label : 'Name',
        fieldName : 'Name'
    }
];
export default class LwcRetriveAccountImp extends LightningElement {
    @track columnsData =columns;
    @track Accountlist;
    @track Accountdata=[];
    handleAccountData(){
        Accountmethodname()
        .then(result=>{
            this.Accountlist=result;
            this.Accountdata=this.Accountlist;
            console.log('Accountlistvalues---'+this.Accountdata);
        })
        .catch(error=>{
            this.error=error;
        });
    }
    connectedCallback(){
        this.handleAccountData();
    }
}