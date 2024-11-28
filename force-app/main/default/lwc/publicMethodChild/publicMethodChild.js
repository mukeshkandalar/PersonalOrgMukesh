import { LightningElement, track, api } from 'lwc';

export default class PublicMethodChild extends LightningElement {
    @track value = ['red'];


        options = [
            { label: 'Red', value: 'red' },
            { label: 'Green', value: 'green' },
            { label: 'Blue', value: 'blue' },
        ];

    @api
    selectCheckbox(checkboxValue){
       const selectedCheckbox = this.options.find(  checkbox =>{
           return checkboxValue === checkbox.value;
       })
       if(selectedCheckbox){
           this.value = selectedCheckbox.value;
           return "Succesfully checked";
       }
       return "No checkbox found";
    }
}