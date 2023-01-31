public with sharing class ContactSearchController {
    @AuraEnabled(cacheable=true)
    public static List<ContactWrap> getContacts(String accID, String searchKey){
        List<ContactWrap> contactList = new List<ContactWrap>();
        String q  = 'SELECT Id, Name, Phone, Email, Title from Contact WHERE AccountId = :accID';
        if(String.isNotBlank(searchKey))
            q += ' AND Name LIKE \'%' + searchKey +'%\'';
        for(Contact forCon : Database.query(q)) {
            contactList.add(new ContactWrap(forCon));
        }
        return contactList;
    }

    public class ContactWrap {
        @AuraEnabled public String Id {get; set;}
        @AuraEnabled public String Name {get; set;}
        @AuraEnabled public String Phone {get; set;}
        @AuraEnabled public String Email {get; set;} 
        @AuraEnabled public String Title {get; set;} 

        public ContactWrap(Contact parContact){
            Id = parContact.Id;
            Name = parContact.Name;
            Phone = parContact.Phone;
            Email = parContact.Email;
            Title = parContact.Title;
        }
    }
}