# Internal Assessment
Developed by Axcel Espinal (axcel.espinal@itk-square.edu.do)

## Back-end Practice Assessment
A technical requirement for a client is to update all related contacts once its parent account is updated.
However, if the total count of contacts to update in a transaction is greater than 200 records the update
should happen asynchronously in the following manner:
* If 1000 <= total contact count > 200, use a one-time process to update the records.
* If total contact count > 1000, the records must be updated in smaller chunks of ideally 150
records per chunk
* In the case of total contact count <= 200, update contacts synchronously.
The field to consider on the parent Account is a new custom field called PushToVendor__c, this is picklist
field containing the values “Yes” and “No”.
* Any time this field is set to “Yes”, all related contacts for the account should be updated to have
Push_Date__c = Today’s Date
 ** Push_Date__c is a date/time field on the Contact Object.
* Any time this fied is set to “No”, all related contacts for the account should be updated to have
Push_Date__c = null 

## Front-end Practice Assessment
The client has requested a new Lightning Web Component that can be launched for an Account record.
The Component must display a list of all Contact directly or indirectly related to the account and allow the
user to search using a type-ahead functionality among the Account’s contacts sorting by Name. Consider
using “Lazy loading” for better performance.
If the user clicks on one of the names in the list, a section with the contact details must appear at the
right. This section must display a contact photo, the name, role, phone, and email. When the user clicks
on the photo it is redirected to the Contact details page.
Additionally, the client wants the ability to create and associate a new contact for the account. 

Also, the client provided the following user story or Acceptance test:
* I Go to an account detail page
* I’m able to view and click the “Contact Search” button
* The new Component is displayed
* I can search by Name
* As I type, when the character count is equal to 3 or more the system performs a search and
display any contact that begins with the string I typed.
* I continue to type the full name of the contact, I can either press the “Search” button or hit
Enter to execute the search
* The results are displayed in a table showing the following data points:
** Name
** Email [Hyperlink to launch email app]
** Phone Number
