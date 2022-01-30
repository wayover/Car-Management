public with sharing class CarDeleteInfoHandler {

    public static void check(List<Pojazd__c> car){
        

    if(car.size()>0){
        List<Telemetry__c> telemetries=[SELECT Id from Telemetry__c where Pojazd__c IN :car];
        delete telemetries;
    }

    

    List <Case> caseList= new List<Case>();
    

    for(Pojazd__c c:car){
        List <String> strList = new List < String > { c.Marka__c, c.Model__c };  
        String carDescription = String.join( strList, ', ' );  
        caseList.add(new Case(Description = carDescription,Reason='Other',Status='New',Origin='Web',Priority='High'));
    }

    insert caseList;

    }

}
