@RestResource(urlMapping = '/Account/*');
global class AccountMgmt {
    @httpGet
    global static List<Account> getTopAccounts()
    {
        Map<String,String> pm = RestContext.request.params;
        String accInd = params.get('industry');
        List<Account> accList  = [select id,industry,rating from account where annualrevenue != null and Industry = :accInd order by annualrevenue desc limit 10];
        return accList;
    }
}