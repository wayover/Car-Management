public class ScheduledTelemetryCleaning implements Schedulable {

    public void execute(SchedulableContext ctx){
 
        LargeDataDelete largeDataDelete= new LargeDataDelete('SELECT Id from Telemetry__C WHERE CreatedDate != LAST_N_DAYS:90');
        Id largeDataDeleteId = Database.executeBatch(largeDataDelete);
    }

}
