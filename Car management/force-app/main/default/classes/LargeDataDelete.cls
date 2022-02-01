public  class LargeDataDelete implements Database.Batchable<sObject>{


    String query;
    LargeDataDelete(String query){
        this.query=query;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
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
