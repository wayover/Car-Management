trigger NewOffer on Oferta__c (after insert) {

    NewOfferHandler.sendId(trigger.new);

}