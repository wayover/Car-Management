/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The trigger send insert offers to handler
 **/
trigger NewOffer on Oferta__c (after insert) {

    NewOfferHandler.sendId(trigger.new);

}