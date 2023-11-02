global class BatchApexTestExample implements Database.Batchable<Sobject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select leadsource,rating from lead');
    }
    global void execute(Database.BatchableContext bc,List<Lead> scope){
        for(Lead l : scope){
            if(l.leadsource=='web'){
                l.rating='warm';
            }
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
         
    }
}