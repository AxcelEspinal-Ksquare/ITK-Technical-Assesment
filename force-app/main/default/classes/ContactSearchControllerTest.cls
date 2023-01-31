@isTest
public class ContactSearchControllerTest {
	@TestSetup
    static void setTestData(){
        
        List<sObject> objList = new List<sObject>();

        Account acc = new Account(Name='Test Acc');
        insert acc;
        
        
        Contact con = new Contact(FirstName = 'Test', LastName = 'Con', AccountId = acc.Id);
        insert con;
    }
    
    @isTest
    static void getContacts(){
        Account acc = [SELECT Name from Account WHERE Name = 'Test Acc'];
        List<ContactSearchController.ContactWrap> contactList = ContactSearchController.getContacts(acc.Id, 'Test');
        System.assertEquals(1, contactList.size());
    }
    
    
}