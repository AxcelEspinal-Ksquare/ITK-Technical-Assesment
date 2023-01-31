@isTest
public class AccountUpdateTriggerTest {
	@TestSetup
    static void setTestData(){
        Account acc = new Account (Name = 'Test Acc');
        insert acc;
        
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0; i<10; i++){
            Contact con = new Contact(LastName = 'Test Con' + i, AccountId = acc.Id);
            contactList.add(con);
        }
        insert contactList;
    }
    
    @isTest
    static void updateToYes(){
        Account acc = [SELECT Name, PushToVendor__c FROM Account WHERE Name = 'Test Acc'];
        acc.PushToVendor__c = 'Yes';
        update acc;
        
        List<Contact> cons = [SELECT Push_Date__c FROM Contact WHERE AccountId = :acc.Id];
        System.assertEquals(Date.today(), cons[0].Push_Date__c);
    }
    
    @isTest
    static void updateToNo(){
        Account acc = [SELECT Name, PushToVendor__c FROM Account WHERE Name = 'Test Acc'];
        acc.PushToVendor__c = 'No';
        update acc;
        
        List<Contact> cons = [SELECT Push_Date__c FROM Contact WHERE AccountId = :acc.Id];
        System.assertEquals(null, cons[0].Push_Date__c);     
    }
}