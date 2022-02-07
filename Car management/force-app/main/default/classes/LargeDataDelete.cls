/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The Class deletes the data selected from the query
**/
public  class LargeDataDelete implements Database.Batchable<sObject>{


    private String query;
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
    }

}
