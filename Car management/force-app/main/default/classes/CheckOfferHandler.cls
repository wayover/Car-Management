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
    public static void checkOffer(List<Oferta__c> inOfferList){
        

        List<Oferta__c> offerList= new List<Oferta__c>();
        List<Id> vehicleIdList= new List<Id>();


        if(inOfferList==null){
            return;
        }
        

        for(Oferta__c offer: inOfferList){
            if(offer.Stan__c == Constant.PHYSICAL){
                offerList.add(offer);
                vehicleIdList.add(offer.Pojazd__c);
            }
        }

        List<Oferta__c> phisicalCheck = [SELECT Pojazd__c FROM Oferta__c WHERE Pojazd__c IN :vehicleIdList AND Stan__c =:Constant.PHYSICAL];


        Integer count;
        for(Oferta__C offer:offerList){
            count=0;

            for(Oferta__c phisicalOffer:phisicalCheck){

                if(offer.Pojazd__c==phisicalOffer.Pojazd__c){
                    offer.addError('You can not set again this car as physical');
                    break;
                }else{
                    count++;
                }
            }

            if(count==phisicalCheck.size()){
                phisicalCheck.add(offer);
            }

        }

    }

}
