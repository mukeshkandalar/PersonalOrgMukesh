import { LightningElement, track } from 'lwc';

export default class PublicMethodParent extends LightningElement {
    @track value;

    checkboxHandler(){
        const childComp = this.template.querySelector('c-public-method-child');
        const childMessage = childComp.selectCheckbox(this.value);
        console.log('return child message',childMessage);
    }
    onInputEventHandler(event){
        this.value=event.target.value;
    }
}