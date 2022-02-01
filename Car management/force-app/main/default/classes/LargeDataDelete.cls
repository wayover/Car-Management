public  class LargeDataDelete implements Database.Batchable<sObject>{


    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id from Telemetry__C WHERE CreatedDate != LAST_N_DAYS:90]);
    }
    public void execute(Database.BatchableContext bc, List<Telemetry__C> telemetryList){
        if(telemetryList!=null){
            delete telemetryList;
        }

    }
    public void finish(Database.BatchableContext bc){
        System.debug('telemeries more than three months old have been removed');
    }

}
