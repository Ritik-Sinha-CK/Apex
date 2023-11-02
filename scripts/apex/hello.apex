// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents
/****************************************************************************************************
Company: Cloudkaptan Consultancy Services Pvt. Ltd.
Author: Bijay Shaw
Description : This class will make Loan Payment Transaction for Credit Adjustment.
Development Date : 03/07/2023
Last Modified Date : 
Test Class : 
********************************************************************************/
global class CreditAdjustmentUpdateBatch implements DataBase.StateFul, DataBase.Batchable<sObject>, Schedulable{
    private static final String INTEREST_CREDIT_ADJUSTMENT = 'Interest Credit Adjustment';
    global Database.QueryLocator start(Database.BatchableContext bc) {       
        return Database.getQueryLocator([SELECT id,
                                                name,
                                                CRN__c,
                                                Credit_Check__c,
                                                Credit_Amount__c,
                                                loan__Loan_Status__c,
                                                loan__Loan_Balance__c,
                                                Loan_Account_Number__c,
                                                loan__Last_Accrual_Date__c
                                                FROM loan__Loan_Account__c
                                                WHERE Credit_Amount__c != null AND Credit_Check__c = true 
                                                AND loan__Loan_Account__c.name != 'LAI-00001366']);
    } 
    global void execute(Database.BatchableContext bc, List<loan__Loan_Account__c> listContracts) {
        loan.GlobalLoanUtilFacade systemDate = new loan.GlobalLoanUtilFacade();
        Date transactionDate = System.Today();
        if(!Test.isRunningTest()){
            transactionDate = systemDate.getCurrentSystemDate();
        }
        List<peer.BTransaction> retVal = new List<peer.BTransaction>();
        List<loan__Loan_Account__c> listOfLoanContract = new List<loan__Loan_Account__c>();
        for(loan__Loan_Account__c lacc : listContracts){
            peer.BTransaction bTxn = new peer.BTransaction(lacc.CRN__c,
            lacc.Credit_Amount__c,
            '',                                       //Bank Account Number
            peer.BTransaction.TransactionType.CREDIT, //Transaction Type
            transactionDate,                            //Current datetime value
            '',                                       //Target Bank Account Number
            transactionDate,                      //Actual payment date
            false,                                    // Is Dishonour
            String.valueOf(System.today()),           //Current date value
            '',                             //
            '',                             //
            false,                                    //Is invalid
            INTEREST_CREDIT_ADJUSTMENT);        
            
            retVal.add(bTxn);
        
            lacc.Credit_Check__c = false;
            lacc.Credit_Amount__c = null;
            listOfLoanContract.add(lacc);
        }
        peer.IBankStatementAPI bsAPI = peer.BankStatementAPIFactory.getBankStatementAPI(retVal, false);
        bsAPI.processBTransaction();
        if(listOfLoanContract.size() > 0){
            update listOfLoanContract;
        }
    }   
    global void finish(Database.BatchableContext batchableContext){  
      System.debug('FINISH METHOD');   
    } 
    global void execute(SchedulableContext sc){
        CreditAdjustmentUpdateBatch batchInstance = new CreditAdjustmentUpdateBatch();
        database.executebatch(batchInstance, Integer.valueOf(1));
    }
}