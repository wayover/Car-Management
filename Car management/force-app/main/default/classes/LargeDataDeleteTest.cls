/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The class is the test LargeData Method
 **/
@isTest
public class LargeDataDeleteTest {
    
    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method checks if the telemetry taken from the query has been removed
    **/
    @isTest
     private static void testDeleteTelemetry(){

        List<Telemetry__C> telemetryList = new List<Telemetry__C>();

        for(Integer i=0;i<200;i++){
            telemetryList.add(new Telemetry__c(Name = 'Tlemetry '));
        }
        insert telemetryList;

    String query = 'Select Id FROM Telemetry__c';
    Test.startTest();
    LargeDataDelete largeData = new LargeDataDelete(query);
    Database.executeBatch(largeData);
    Test.stopTest();

    List<Telemetry__C> checkTelemetryList= [SELECT Id from Telemetry__c];
    System.assertEquals(0, checkTelemetryList.size());

    }

}
