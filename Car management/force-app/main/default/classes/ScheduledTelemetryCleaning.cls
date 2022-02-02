/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The class once a month calls the method to remove telemetry
 **/
public class ScheduledTelemetryCleaning implements Schedulable {

    public void execute(SchedulableContext ctx){
 
        LargeDataDelete largeDataDelete= new LargeDataDelete('SELECT Id from Telemetry__C WHERE CreatedDate != LAST_N_DAYS:90');
        Id largeDataDeleteId = Database.executeBatch(largeDataDelete);
    }

}
