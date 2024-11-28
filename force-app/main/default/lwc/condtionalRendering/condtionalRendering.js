import { LightningElement, track } from 'lwc';

export default class CondtionalRendering extends LightningElement {

    @track displayDiv=false;
    @track cityList=['Hyderabad','Vizag','Delhi','Mumbai'];
    showDivHandler(event){
        this.displayDiv=event.target.checked;
    }
}