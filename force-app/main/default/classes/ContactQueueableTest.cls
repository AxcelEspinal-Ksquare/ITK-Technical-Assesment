@isTest
public class ContactQueueableTest {
	@TestSetup
    static void setTestData(){
        List<Account> accList = new List<Account>();
        
        Account accYes = new Account(Name = 'Test Acc', PushToVendor__c = 'Yes');
        Account accNo = new Account(Name = 'Test Acc2', PushToVendor__c = 'No');
        
        accList.add(accYes);
        accList.add(accNo);
        
        insert accList;
        
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0; i<350; i++){
            Contact con = new Contact(
            LastName = 'Con Test' +i,
            AccountId = accList[0].Id);
            contactList.add(con);
        }
        for(Integer i=0; i<350; i++){
            Contact con = new Contact(
            LastName = 'Con Test' +i,
            AccountId = accList[1].Id);
            contactList.add(con);
        }
        insert contactList;     
    }
    
    @isTest 
    static void whenYes() {
        List<Account> accs =  [SELECT Name, PushToVendor__c FROM Account WHERE Name = 'Test Acc'];
        Test.startTest();
        ContactUpdater.updateContacts(accs);
        Test.stopTest();

        List<Contact> cons = [SELECT Push_Date__c FROM Contact WHERE AccountId In :accs];

        System.assertEquals(Date.today() , cons[0].Push_Date__c);
    }
    
    @isTest 
    static void whenNo() {
        List<Account> accs =  [SELECT Name, PushToVendor__c FROM Account WHERE Name = 'Test Acc2'];
        Test.startTest();
        ContactUpdater.updateContacts(accs);
        Test.stopTest();

        List<Contact> cons = [SELECT Push_Date__c FROM Contact WHERE AccountId In :accs];

        System.assertEquals(null , cons[0].Push_Date__c);
    }
}