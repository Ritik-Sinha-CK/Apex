public class AccountManager {

}

// @RestResource(urlMapping = '/Account/')
// global class AccountManager {
//     @httpGet
//     global static AccountWrapper getTopAccounts()
//     {
//         Map<String,String> pm = RestContext.request.params;
//         String accInd = 'medical';
//         List<Account> accList  = [select id,industry,rating from account where annualrevenue != null and Industry = :accInd order by annualrevenue desc limit 10];
//        Set<Id> accountIdSet = new Set<Id>();
//         for(Account acc : accList)
//         {
//             accountIdSet.add(acc.Id);
//         }

//         List<Contact> conList = [select id,firstname,lastname,email from Contact where accInd in :accountIdSet ];
//         List<Case> caseList = [select id,priority,subject from case where accInd in :accountIdSet ];
//         AccountWrapper accWrap = new AccountWrapper();
//         accWrap.accList = accList;
//         accWrap.conList = conList;
//         accWrap.caseList = caseList;
       
//         return accWrap;
//     }

//     @httpPost
//     // global static String createAccount(String accName , String accRating, String accIndustry)
//     // {
//     //     Account acc = new Account();
//     //     acc.name = accName;
//     //     acc.rating = accRating;
//     //     acc.Industry = accIndustry;
//     //     try {
//     //         insert acc;
//     //         return 'Account created Successfully';
//     //     }
//     //     catch(exception ex)
//     //     {
//     //        return ex.getMessage()
//     //     }
//     // }
//     global static void createAccountAndContact(AccountInfo information)
//     {
//         Account accRec = information.accountRecord;
//         Contact conRec = information.contactRecord;
//         try {
//             insert accRec;
//             accRec.acc
//         }
//         catch()
//         {

//         }
//     }

//     global class AccountWrapper {
//         global List<Account> accList;
//         global List<Contact> conList;
//         global List<Case> caseList;
//     }
//     global class AccountInfo {
//         global Account accountRecord {
//             get;
//             set;
//         }
//         global Contact ContactRecord {
//             get;
//             set;
//         }
//     }
// }