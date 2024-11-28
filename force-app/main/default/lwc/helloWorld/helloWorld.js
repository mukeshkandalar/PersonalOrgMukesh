import { LightningElement,track } from 'lwc';

export default class HelloWorld extends LightningElement {
    @track firstpage;
    get(){
        this.firstpage='Manny';

    }

}