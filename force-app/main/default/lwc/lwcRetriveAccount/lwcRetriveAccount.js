import { LightningElement,wire,track} from 'lwc';
import Accountmethodname from '@salesforce/apex/LwcRetriveAccount.Accountmethodname';
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
        label : 'AccountName',
       fieldName : 'Name'
    },
    {
        label : 'AccountType',
        fieldName : 'Type'
    },
    {

    label : 'Industry',
    fieldName : 'Industry'
    }
];

export default class LwcRetriveAccount extends LightningElement {
    @track columnsData =columns;
    @track accountlist;
    @track Accountdata=[];
    @wire(Accountmethodname)
      wireaccount(result){
          if(result.data){
              this.accountlist=result.data;
              this.Accountdata=this.accountlist;
              console.log('accountlist----'+this.accountlist);
          }else{
              this.error=result.error;
          }
      }
}