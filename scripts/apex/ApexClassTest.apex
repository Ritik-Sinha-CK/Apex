@isTest 
private class BatchApexTestExampleTest {
static testMethod void testMe()
{
   lead l = new Lead();
   l.firstName = 'salesforce';
   l.lastName = 'Codes';
   l.company = 'salesforcecodes';
   l.leadsource = 'Web';
   insert l;
   Test.startTest();
   BatchApexTestExample ba = new BatchApexTestExample();
   Id jobid = Database.executeBatch(ba,5);
   Test.stopTest();
   Lead leads = [select rating from lead where if =:l.id];
   System.assertEquals('Warm',leads.Rating);
   
   }

}
//Apex class
global class AccountUpdate implements Database.Batchable {
      
     global Database.QueryLocator start(Database.BatchableContext BC){
          return Database.getQueryLocator('Select Id, Name From Account');
     }
     global void execute(Database.BatchableContext BC, List  scope){
          for(Account a: scope){
               a.Name += ' Updated';
          }
          upsert scope;
     }
     global void finish(Database.BatchableContext BC){}


@isTest 
private class accListountUpdate {
   static testMethod void test()
   {
      Account []accList = new List();
      for(Integer i = 0;i<200;i++)
      {
         Account m = new Account(Name = 'Account'+i);
         accList.add(m);
      }
      insert accList;

      Test.startTest();
      AccountUpdate c = new AccountUpdate();
      DataBase.executeBatch(c);
      Test.stopTest();

      Acount[] accUpdatedList = [select id, name from Account];
      System.assert(accUpdatedList[0].Name.Contains('Updated'));
   }
}



public class UpdateContactAddresses implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
            'Where BillingCountry = \'USA\''
        );
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        EmailUtils.sendMessage(job, recordsProcessed);
    }
}


// The start method provides the collection of all records that the execute method will process in individual batches. It returns the list of records to be processed by calling Database.getQueryLocator with a SOQL query. In this case we are simply querying for all Account records with a Billing Country of ‘USA’.
// Each batch of 200 records is passed in the second parameter of the execute method. The execute method sets each contact’s mailing address to the accounts’ billing address and increments recordsProcessed to track the number of records processed.
// When the job is complete, the finish method performs a query on the AsyncApexJob object (a table that lists information about batch jobs) to get the status of the job, the submitter’s email address, and some other information. It then sends a notification email to the job submitter that includes the job info and number of contacts updated.

@isTest
private class UpdateContactAddressesTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        // insert 10 accounts
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(name='Account '+i,
                billingcity='New York', billingcountry='USA'));
        }
        insert accounts;
        // find the account just inserted. add contact for each
        for (Account account : [select id from account]) {
            contacts.add(new Contact(firstname='first',
                lastname='last', accountId=account.id));
        }
        insert contacts;
    }
    @isTest static void test() {
        Test.startTest();
        UpdateContactAddresses uca = new UpdateContactAddresses();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
    }
}
