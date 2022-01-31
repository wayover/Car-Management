/**
* @author kamil.wisniewski@accenture.com
* @date 31/01/2022
* @description The class is the handler to the trigger before insert Oferta__c
 **/

public with sharing class CarDeleteInfoHandler {



    /**
     * @author kamil.wisniewski@accenture.com
     * @date 31/01/2022
     * @description The method delete telemetry for the deleted car and adds an case to the database
     **/
    public static void check(List<Pojazd__c> inCar){
        

    if(inCar.size()>0){
        List<Telemetry__c> telemetries=[SELECT Id from Telemetry__c where Pojazd__c IN :inCar];
        delete telemetries;
    }

    

    List <Case> caseList= new List<Case>();
    

    for(Pojazd__c c:inCar){
        List <String> strList = new List < String > { c.Marka__c, c.Model__c };  
        String carDescription = String.join( strList, ', ' );  
        caseList.add(new Case(Description = carDescription,Reason='Other',Status='New',Origin='Web',Priority='High'));
    }

    insert caseList;

    }

}
