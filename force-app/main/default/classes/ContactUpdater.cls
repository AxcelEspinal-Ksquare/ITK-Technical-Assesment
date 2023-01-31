public class ContactUpdater {
    public static void updateContacts(List<Account> accList) {

        List<Contact> contacts = new List<Contact>();
        contacts = [SELECT Push_Date__c, Account.PushToVendor__c FROM Contact WHERE AccountID in :accList];
        
        for(Contact cont: contacts) {
            if(cont.Account.PushToVendor__c == 'Yes') {
                cont.Push_Date__c = Date.today();
            } else if(cont.Account.PushToVendor__c == 'No') {
                cont.Push_Date__c = null;
            }
        }
        
        if(contacts.size()>0) {
            if(contacts.size()<=200) {
                update contacts;
            }
            else if (contacts.size()<=1000) {
                ID job = System.enqueueJob(new ContactQueueable(contacts));
            } else if(contacts.size()>1000) {
                if(Test.isRunningTest()){
                    List<Contact> contactList = new List<Contact>();
                    for(Integer i=0; i<150; i++) {
                        contactList.add(contacts[i]);
                    }
                    ID batch = Database.executeBatch(new ContactBatch(contactList), 150);
                } else {
                    ID batch = Database.executeBatch(new ContactBatch(contacts), 150);
                }
            }
        }
    }
}