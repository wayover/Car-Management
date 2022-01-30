public with sharing class CheckOfferHandler {

    public static void check(List<Oferta__c> offer){
        

        List<Oferta__c> offerList= new List<Oferta__c>();
        List<Id> carList= new List<Id>();

        for(Oferta__c o: offer){
            if(o.Stan__c == 'Fizyczna'){
                offerList.add(o);
                carList.add(o.Pojazd__c);
            }
        }

        List<Oferta__c> phisicalCheck = [SELECT Pojazd__c FROM Oferta__c WHERE Pojazd__c IN :carList AND Stan__c = 'Fizyczna'];


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
