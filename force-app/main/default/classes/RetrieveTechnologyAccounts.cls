@RestResource(urlMapping='/retrieveTechnologyAccounts')

global with sharing class RetrieveTechnologyAccounts {

 

    @HttpGet

    global static List<Account> getTechnologyAccounts() {

        List<Account> techAccounts = [SELECT Id, Name, Industry FROM Account WHERE Industry = 'Technology'];
		System.debug(techAccounts);
        return techAccounts;

    }


}