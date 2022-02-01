trigger CheckOffer on Oferta__c  (before insert) {
   
   
    CheckOfferHandler.checkOffer(trigger.new);
    
}