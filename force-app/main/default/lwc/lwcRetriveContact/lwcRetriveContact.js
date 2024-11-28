import { LightningElement,wire,track} from 'lwc';
import contactmethodname from '@salesforce/apex/RetrieveContact.contactmethodname';
import methodname from '@salesforce/apex/RetrieveContact.methodname';

const columns= [
    {
       label : 'ID',
       fieldName : 'id'
    },
    {
       label : 'ContactFirstName',
       fieldName : 'FirstName'
    },
    {
       label : 'ContactLastName',
       fieldName : 'LastName'
    },
    {
        label : 'Phone',
        fieldName : 'Phone',
        type:'Phone'

    }
    
    ];

export default class LwcRetriveContact extends LightningElement {
    @track columnsData =columns;
    @track contactlist;
    @track contactdata=[];
    @track slecteddata=[];
    @wire(contactmethodname)
        wirecontact(result){
        if(result.data){
            this.contactlist=result.data;
            this.contactdata=this.contactlist;
            console.log('contactlist---'+ this.contactlist);

        }else{
            this.error=result.error;
        }

    }
    handlecontactdata(){
        const selectedrow=this.template.querySelector('.contactclass');
        var selected=selectedrow.getSelectedRows();
        let id=new Set();
        for(let i=0;i<selected.length;i++){
        id.add(selected[i].Id);
        this.slecteddata=Array.from(id);
        console.log('selecteddata values---'+this.slecteddata);
        console.log('selectedlength values---'+selected[i].Id);
        
        methodname({contactid:this.slecteddata})
        .then(result=>{
            this.contactdata=result;

            console.log('contactlistvalues---'+this.contactdata);
        })
        .catch(error=>{
            this.error=error;
            console.log('error'+this.error);
        });
        }

        
    }
}