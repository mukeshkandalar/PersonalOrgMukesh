import { LightningElement, track, wire } from 'lwc';
import { createRecord, getRecord } from "lightning/uiRecordApi";
const fieldArray =[Account.Name , Account.Phone];
export default class CreateRecordLDS extends LightningElement {
    @track accountName;
    @track accountPhone;
    @track AccountId;
    @wire(getRecord, {recordId:'AccountId', fields: fieldArray})
    accountRecord;
    accountNameChangeHandler(event){
        this.accountName= event.target.value;

    }
    accountPhoneChangeHandler(event){
       this.accountPhone = event.target.value;
    }
    createAccount(){
        const fields = {'Name' : this.accountName, 'Phone':this.accountPhone};
        const recordInput = {apiName : 'Account', fields};
        createRecord(recordInput).then(response =>{
            console.log('Successfull Account Creation', response.id);
         this.AccountId = resopnse.id;
        }).catch(error =>{
            console.log('Error in Account Creation', error);
        });
    }
    get returnAccountName(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Name.value;
        }
        return undefined;
    }
    get returnAccountPhone(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Phone.value;
        }
        return undefined;
    }
}