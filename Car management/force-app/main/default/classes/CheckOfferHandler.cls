/**
     * @author kamil.wisniewski@accenture.com
     * @date 31/01/2022
     * @description The class is the handler to the trigger before delete Pojazd__c
     **/


public with sharing class CheckOfferHandler {


    /**
     * @author kamil.wisniewski@accenture.com
     * @date 31/01/2022
     * @description The method checks if there is no other physical offer for the vehicle
     **/
    public static void check(List<Oferta__c> inOffer){
        

        List<Oferta__c> offerList= new List<Oferta__c>();
        List<Id> vehicleList= new List<Id>();

        for(Oferta__c o: inOffer){
            if(o.Stan__c == 'Fizyczna'){
                offerList.add(o);
                vehicleList.add(o.Pojazd__c);
            }
        }

        List<Oferta__c> phisicalCheck = [SELECT Pojazd__c FROM Oferta__c WHERE Pojazd__c IN :vehicleList AND Stan__c = 'Fizyczna'];


        Integer count;
        for(Oferta__C c:offerList){
            count=0;

            for(Oferta__c c2:phisicalCheck){

                if(c.Pojazd__c==c2.Pojazd__c){
                    c.addError('You can not set again this car as physical');
                    break;
                }else{
                    count++;
                }
            }

            if(count==phisicalCheck.size()){
                phisicalCheck.add(c);
            }

        }

    }

}
