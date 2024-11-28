import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
     @track currResult;
     firstNum;
     secondNum;
     numberChangeHandler(event){
         const inputBoxName= event.target.name;
         if(inputBoxName==='firstNum'){
             this.firstNum=parseInt(event.target.value);
         }else if(inputBoxName==='secondNum'){
             this.secondNum=parseInt(event.target.value);
         }
         }
       addHandler(){
         //  const firstN = parseInt(this.firstNum);
         //  const secondN = parseInt(this.secondNum);
           this.currResult = this.firstNum+this.secondNum;
          // this.currResult = this.firstNum+this.secondNum;
       }
     subHandler(){
        const firstN = parseInt(this.firstNum);
        const secondN = parseInt(this.secondNum); 
        this.currResult = 'Result of firstN-secondN is:' +(firstN-secondN);
    }
    multiplyHandler(){
        const firstN = parseInt(this.firstNum);
        const secondN = parseInt(this.secondNum); 
        this.currResult = 'Result of ${firstN}*${secondN} is ${firstN*secondN}';
    }
    divisionHandler(){
        const firstN = parseInt(this.firstNum);
        const secondN = parseInt(this.secondNum); 
        this.currResult = 'Result of ${firstN}/${secondN} is ${firstN/secondN}';
    }
}