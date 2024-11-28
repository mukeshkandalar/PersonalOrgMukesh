import { LightningElement, track } from 'lwc';
import {getBMI} from 'c/bmiEcMac7Use';

export default class BmiEcMac7 extends LightningElement {
 
    cardTitle = 'BMI Calculator';
    weight;
    height;
     @track bmi;
    WeighthChange(event){
        this.weight=parseFloat(event.target.value);
        

    }
    heightChange(event){
        this.height=parseFloat(event.target.value);
    }
    
    calculateBmi(){
         this.bmi = getBMI(this.weight,this.height);
    }
    get bmiValue(){
        if(this.bmi===undefined){
            return "";
        }
        return  'You BMI :' +this.bmi;
    }
}