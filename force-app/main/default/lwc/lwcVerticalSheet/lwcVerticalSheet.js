import { LightningElement,wire,track } from 'lwc';
import VerticalSheetmethodName from '@salesforce/apex/LwcRetriveVerticalSheet.VerticalSheetmethodName';
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
        },
        {
    
               label : 'ID',
               fieldName : 'id'
            },
            {
                label : 'check__c',
                fieldName : 'check__c'
            },
            {
                label : 'Delta__c',
                fieldName : 'Delta__c' 
            }
        ];
export default class LwcVerticalSheet extends LightningElement {
    @track columnsData =columns;
    @track Vertical_Sheet__c;
    @track Vertical_Sheet__cdata=[];
    @wire(VerticalSheetmethodName)
      wireVertical_Sheet__c(result){
          if(result.data){
              this.Vertical_Sheet__clist=result.data;
              this.Vertical_Sheet__cdata=this.Vertical_Sheet__clist;
              console.log('Vertical_Sheet__clist----'+this.Vertical_Sheet__clist);
          }else{
              this.error=result.error;
          }
      }
}