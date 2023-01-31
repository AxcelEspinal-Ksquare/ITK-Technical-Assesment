public class ContactQueueable implements Queueable{
    List<Contact> contactList;
    public ContactQueueable(List<Contact> listCon){
        contactList = listCon;
    }
    
    public void execute(QueueableContext context){
        for(Contact cont: contactList){
            if(cont.Account.PushToVendor__c == 'Yes'){
                cont.Push_Date__c = Date.today();
            }
            else if(cont.Account.PushToVendor__c == 'No'){
                cont.Push_Date__c = null;
            }
        }
        update contactList;
    }
}