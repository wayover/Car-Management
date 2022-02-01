public with sharing class NewOfferHandler {
    

    public static void sendId(List<Oferta__c> inOfferList){

        if(inOfferList==null ||inOfferList.size()==0){
            return;
        }


        List<Id> offerIdList = new  List<Id>();

        for(Oferta__C offerList:inOfferList){
            offerIdList.add(offerList.Id);
        }
        SendMailFuture.sendmail(offerIdList);
    }

}