public class ContactBatch implements Database.Batchable<sObject>{
    
    List<Contact> contactList;
    
    public ContactBatch(List<Contact> listCon) {
        contactList = listCon;
    }
    
    public Iterable<sObject> start(Database.BatchableContext bc) {
        return contactList;
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> scope){
        update contactList;
    }
    
    public void finish(Database.BatchableContext bc) {
        
    }

}