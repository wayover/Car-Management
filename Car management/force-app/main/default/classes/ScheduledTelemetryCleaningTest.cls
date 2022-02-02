/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The class is the test Schedulable method 
 **/
@isTest
public class ScheduledTelemetryCleaningTest {

    private static String CRON_EXP ='0 1 0 ? * * *';

    @isTest
     private static void testShedulableClass(){

        Test.startTest();
        String jobId = System.schedule('MonthlyTelemetr', CRON_EXP, new ScheduledTelemetryCleaning());
        Test.stopTest();

        
        System.assert(jobId!=null);
        
    }

}
