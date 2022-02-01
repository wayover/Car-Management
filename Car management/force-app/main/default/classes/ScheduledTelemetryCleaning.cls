public class ScheduledTelemetryCleaning implements Schedulable {

    public void execute(SchedulableContext ctx){
 
        LargeDataDelete largeDataDelete= new LargeDataDelete();
        Id largeDataDeleteId = Database.executeBatch(largeDataDelete);
    }

}
