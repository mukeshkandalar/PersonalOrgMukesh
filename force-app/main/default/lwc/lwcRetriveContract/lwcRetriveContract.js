import { LightningElement,wire,track } from 'lwc';
import contractmethodName from '@salesforce/apex/LwcRetriveContract.contractmethodName';
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
export default class LwcRetriveContract extends LightningElement {
    @track columnsData =columns;
    @track contractlist;
    @track contractdata=[];
    @wire(contractmethodName)
      wirecontract(result){
          if(result.data){
              this.contractlist=result.data;
              this.contractdata=this.contractlist;
              console.log('contractlist----'+this.contractlist);
          }else{
              this.error=result.error;
          }
      }
}