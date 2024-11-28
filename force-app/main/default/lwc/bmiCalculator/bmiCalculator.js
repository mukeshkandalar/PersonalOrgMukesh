import { LightningElement, track } from 'lwc';

export default class BmiCalculator extends LightningElement {
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
        try{
        this.bmi = this.weight/(this.height*this.height);
        console.log('wieghtandheight',this.bmi);
        }
        catch(error){
            this.bmi=undefined; 
            console.log('wieghtandheight1',this.bmi);
        }

    }
    get bmiValue(){
        if(this.bmi===undefined){
            return "";
        }
        return  'You BMI :' +this.bmi;
    }
}