public class BatchApex implements Database.Batchable<sObject>,Database.Stateful{
   public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
   			'Select id, StageName from opportunity where amount>10000'
        );
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> records){
       // process each batch of records
        List<opportunity> list1=new List<opportunity>();
        for(opportunity op:records)
        {
            op.StageName='Closed Won';
            list1.add(op);
        }
        update list1;
    }

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        //executed last
    }
}