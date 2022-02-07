/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The Class is closesalon trigger handler
**/
public with sharing class NewOfferHandler {
    
    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method send offer id list to SendMailFuture class
    **/
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