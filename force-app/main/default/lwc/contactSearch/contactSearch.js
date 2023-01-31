import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getContacts from '@salesforce/apex/ContactSearchController.getContacts';
import { refreshApex } from '@salesforce/apex';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';

const COLS = [
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'button',
        typeAttributes: {
            label: {fieldName: 'Name'},
            name: "detailClick"
        }
    },
    {
        label: 'Email',
        fieldName: 'Email',
        type: 'email'
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone'
    }
]

export default class ContactSearch extends NavigationMixin (LightningElement) {
    cols = COLS;
    @api recordId;
    @track contact = [];
    @track inputValue = '';
    contacts = [];

    @wire(getContacts, {accID: '$recordId', searchKey: '$inputValue'}) 
    contacts;

    handleRowAction(event){
        let row = event.detail.row;
        if(event.detail.action.name === "detailClick") {
            this.contact = row;
        }
    }
    
    handleCreate(){
        const defaultValues = encodeDefaultFieldValues({
            AccountId: this.recordId
        });
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName : 'contact',
                actionName: 'new'
            },
            state: {
                defaultFieldValues: defaultValues
            }
        });
    }

    handleChange(event) {
        let charCount = event.detail.value.length;
        if(charCount >= 3 || charCount === 0) {
            this.inputValue = event.detail.value;
            this.contact = [];
            refreshApex(this.contacts);
        }
    }
}