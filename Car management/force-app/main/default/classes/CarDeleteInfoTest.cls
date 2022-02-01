/**
* @author kamil.wisniewski@accenture.com
* @date 31/01/2022
* @description The class is the test CarDeleteInfo trigger
 **/

@isTest
private class CarDeleteInfoTest {

    /**
    * @author kamil.wisniewski@accenture.com
    * @date 31/01/2022
    * @description The method tests the delete of the vehicle
    **/
    @isTest static void testDeleteWithTelemetry(){
        List<Pojazd__c> vehicleList=new List<Pojazd__c>();
        List<Telemetry__c> telemetryList=new List<Telemetry__c>();

        for(Integer i=0;i<200;i++){
            vehicleList.add( new Pojazd__c(Name=i+'',Numer_seryjny__c=i+''));
        }

        if(vehicleList.size()>0){
            insert vehicleList;
        }

        for(Pojazd__c c:vehicleList){
            telemetryList.add( new Telemetry__c(Pojazd__c=c.id,name='teleName1'));
        }



        if(vehicleList.size()>0){
            insert telemetryList;
        }

        Test.startTest();
        List<Database.DeleteResult> result = Database.delete(vehicleList);
        Test.stopTest();

        for(Database.DeleteResult r:result){
            System.assert(r.isSuccess(),true);
        }

        List<Telemetry__c> telemList = [Select Id from Telemetry__c];
        System.assert(telemList.size()==0);
    }



    /**
    * @author kamil.wisniewski@accenture.com
    * @date 01/02/2022
    * @description The method tests null delete 
    **/
    @isTest static void testNullVehicle(){

        Test.startTest();
        CheckOfferHandler.checkOffer(null);
        Test.stopTest();
    }
    
}