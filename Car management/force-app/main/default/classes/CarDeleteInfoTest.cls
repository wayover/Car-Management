@isTest
private class CarDeleteInfoTest {

    @isTest static void testDeleteWithTelemetry(){
        List<Pojazd__c> car=new List<Pojazd__c>();
        List<Telemetry__c> tele=new List<Telemetry__c>();

        for(Integer i=0;i<200;i++){
           car.add( new Pojazd__c(Name=i+'',Numer_seryjny__c=i+''));
        }

        if(car.size()>0){
            insert car;
        }

        for(Pojazd__c c:car){
            tele.add( new Telemetry__c(Pojazd__c=c.id,name='teleName1'));
        }



        if(car.size()>0){
            insert tele;
        }

        Test.startTest();
        List<Database.DeleteResult> result = Database.delete(car);
        Test.stopTest();

        for(Database.DeleteResult r:result){
            System.assert(r.isSuccess(),true);
        }

        List<Telemetry__c> telemetryList = [Select Id from Telemetry__c];
        System.assert(telemetryList.size()==0);
    }
    
}